import json
from pathlib import Path
from typing import Dict, List, Optional

from .base_handler import BaseHandler
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader
from config import GAME_RESOURCES_DIR
from servers.world_server import write_transportable_object


class TaskHandler(BaseHandler):
    RECEIVE_REQUEST = 5889
    FINISH_REQUEST = 5890
    ABORT_REQUEST = 5891
    RECEIVE_NOTIFY = 5892
    FINISH_NOTIFY = 5893
    ABORT_NOTIFY = 5894
    FINISH_SUCCESS_REQUEST = 5895
    FINISH_SUCCESS_NOTIFY = 5896
    _tasks_by_id: Optional[Dict[int, dict]] = None

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.RECEIVE_REQUEST: 'handle_receive',
            cls.FINISH_REQUEST: 'handle_finish',
            cls.ABORT_REQUEST: 'handle_abort',
            cls.FINISH_SUCCESS_REQUEST: 'handle_finish_success',
        }

    def _read_request(self, reader: PacketReader):
        npc_id = reader.read_string()
        task_id = reader.read_unsigned_short()
        return npc_id, task_id

    def _recorder(self):
        return self.player_data.setdefault('taskRecorder', {
            'doingAllocators': {},
            'doingTasks': [],
            'doneTasks': {},
        })

    def handle_receive(self, reader: PacketReader):
        npc_id, task_id = self._read_request(reader)
        recorder = self._recorder()
        done = recorder['doneTasks']
        doing = recorder['doingTasks']
        accepted_now = False
        if task_id not in doing and int(done.get(str(task_id), done.get(task_id, 0))) == 0:
            doing.append(task_id)
            accepted_now = True
            try:
                self.get_db().update_task_status(self.role_name, task_id, 'D', self._npc_allocator_id(npc_id), 0)
            except Exception as exc:
                self.log(f"Falha ao persistir missao aceita {task_id}: {exc}")
            self._apply_task_effects(task_id, 'receive')

        builder = PacketBuilder()
        builder.write_unsigned_short(task_id)
        builder.write_unsigned_short(0)
        self.send_packet(builder.build(self.RECEIVE_NOTIFY))
        suffix = "" if accepted_now else " (ja estava ativa/concluida; sem reaplicar recompensas)"
        self.log(f"Missao aceita: task={task_id}, npc={npc_id}{suffix}")

    def handle_finish(self, reader: PacketReader):
        npc_id, task_id = self._read_request(reader)
        recorder = self._recorder()
        was_active = task_id in recorder['doingTasks']
        already_done = int(recorder['doneTasks'].get(str(task_id), recorder['doneTasks'].get(task_id, 0))) > 0
        if task_id in recorder['doingTasks']:
            recorder['doingTasks'].remove(task_id)

        if was_active and not already_done:
            recorder['doneTasks'][str(task_id)] = 1
            try:
                self.get_db().update_task_status(self.role_name, task_id, 'C', self._npc_allocator_id(npc_id), 1)
            except Exception as exc:
                self.log(f"Falha ao persistir missao concluida {task_id}: {exc}")
            self._apply_task_effects(task_id, 'finish')

        builder = PacketBuilder()
        builder.write_unsigned_short(task_id)
        self.send_packet(builder.build(self.FINISH_NOTIFY))
        suffix = "" if was_active and not already_done else " (nao estava ativa ou ja concluida; sem reaplicar recompensas)"
        self.log(f"Missao concluida: task={task_id}, npc={npc_id}{suffix}")

    def handle_abort(self, reader: PacketReader):
        task_id = reader.read_unsigned_short()
        recorder = self._recorder()
        if task_id in recorder['doingTasks']:
            recorder['doingTasks'].remove(task_id)
        try:
            self.get_db().remove_task_status(self.role_name, task_id)
        except Exception as exc:
            self.log(f"Falha ao remover missao {task_id}: {exc}")

        builder = PacketBuilder()
        builder.write_unsigned_short(task_id)
        self.send_packet(builder.build(self.ABORT_NOTIFY))
        self.log(f"Missao abandonada: task={task_id}")

    def handle_finish_success(self, reader: PacketReader):
        success_id = reader.read_unsigned_short()
        self._record_finished_success(success_id)

        collected = self._try_progress_collect_task()
        suffix = f", collect={collected}" if collected else ""
        # Do not echo PLAYER_FINISH_SUCCESS_NOTIFY yet. The Flash client assumes
        # PlayerSuccessInfoNotify initialized successRecorder first; without it,
        # receiving 5896 crashes the success module with Error #1009.
        self.log(f"PlayerFinishSuccess: successId={success_id}{suffix} (notify suppressed)")

    def _npc_allocator_id(self, npc_id: str) -> int:
        digits = ''.join(ch for ch in str(npc_id).split('@', 1)[0] if ch.isdigit())
        return int(digits) if digits else 0

    @classmethod
    def _tasks(cls) -> Dict[int, dict]:
        if cls._tasks_by_id is None:
            cls._tasks_by_id = {}
            
            # Load from itl.json (general tasks)
            itl_path = Path(GAME_RESOURCES_DIR) / 'decoded' / 'itl.json'
            if itl_path.exists():
                data = json.loads(itl_path.read_text(encoding='utf-8'))
                for task in data:
                    if isinstance(task, dict) and str(task.get('taskId', '')).isdigit():
                        task_id = int(task['taskId'])
                        cls._tasks_by_id[task_id] = task
            
            # Load from _main_tasks_4990_5020.json (main quest chain 4999-5020)
            main_tasks_path = Path(GAME_RESOURCES_DIR) / 'decoded' / '_main_tasks_4990_5020.json'
            if main_tasks_path.exists():
                data = json.loads(main_tasks_path.read_text(encoding='utf-8'))
                for task in data:
                    if isinstance(task, dict) and str(task.get('taskId', '')).isdigit():
                        task_id = int(task['taskId'])
                        cls._tasks_by_id[task_id] = task
                        
        return cls._tasks_by_id

    def _task(self, task_id: int) -> Optional[dict]:
        return self._tasks().get(int(task_id))

    def _apply_task_effects(self, task_id: int, phase: str, send_talks: bool = True):
        task = self._task(task_id)
        if not task:
            return
        rule_name = 'receiveRule' if phase == 'receive' else 'finishRule'
        macro_name = 'onReceived' if phase == 'receive' else 'onFinished'
        rule = task.get(rule_name, {})
        macro = rule.get(macro_name, {})
        self._apply_macro(macro, f"task={task_id}:{phase}")

        # Handle NPC menu talks for both receive and finish.
        # Finish talks are sent so the player sees the NPC's closing dialog.
        # The _send_show_talks already filters out speaker="i" (player's own lines).
        if send_talks:
            npc_menu_key = 'npcMenuReceive' if phase == 'receive' else 'npcMenuFinish'
            npc_menu = rule.get(npc_menu_key, {})
            if npc_menu:
                talks = npc_menu.get('talks', [])
                if talks:
                    self._send_show_talks(talks)

        # Handle clientMacro in finish rule (e.g., showWelcome to open NPC dialog)
        if phase == 'finish':
            client_macros = rule.get('clientMacro', [])
            for macro_cmd in client_macros:
                self._execute_client_macro(macro_cmd)

    def _execute_client_macro(self, macro_cmd: str):
        """Execute client macro commands like 'showWelcome h5@o5'.
        showWelcome <npc_id> - opens NPC welcome dialog on client.
        """
        self.log(f"Client macro: {macro_cmd}")
        if macro_cmd.startswith("showWelcome "):
            npc_id = macro_cmd.split(" ", 1)[1].strip()
            # Send NPC function answer to open welcome screen.
            # The client expects NPC_FUNCTION_ANSWER (1029) with the welcome menu.
            # For now, ensure the NPC talks are visible via PLAYER_SHOW_TALKS_NOTIFY.
            # The npcMenuFinish already handles this, but we can also trigger
            # a menu open by sending a basic NPC function answer.
            try:
                from protocol.commands import NpcCommandCode
                from protocol.packet_builder import PacketBuilder
                builder = PacketBuilder()
                builder.write_string(npc_id)
                builder.write_byte(0)  # menu index / result
                self.send_packet(builder.build(NpcCommandCode.NPC_FUNCTION_ANSWER))
                self.log(f"Sent showWelcome for NPC {npc_id}")
            except Exception as e:
                self.log(f"Failed to send showWelcome: {e}")

    def _apply_macro(self, macro: dict, reason: str = ""):
        if not macro or not self.player_data:
            return
        self._apply_exec_scripts(macro.get('execScripts') or [])
        self._apply_bool_vars(macro)
        gold = int(macro.get('addGold') or 0)
        if gold:
            self.player_data['gold'] = float(self.player_data.get('gold', 0)) + gold
            self._update_role_field('Gold', int(self.player_data['gold']))
            self.session._send_gold_change(gold)

        exp = int(macro.get('addRoleExp') or 0)
        if exp:
            self._add_role_exp(exp)

        honor = int(macro.get('addHonorValue') or 0)
        if honor:
            self.player_data['honorValue'] = int(self.player_data.get('honorValue', 0)) + honor
            self._update_role_field('HonorValue', int(self.player_data['honorValue']))

        items = macro.get('receiveItems') or {}
        if items:
            self._receive_items(items)

        self._remove_items(macro.get('loseItems') or {})
        self._clear_items(macro.get('clearItems') or [])

        self.log(f"Macro de missao aplicada {reason}: gold={gold}, exp={exp}, honor={honor}, items={items}")

    def _dynamic_vars(self, key: str) -> dict:
        current = self.player_data.setdefault(key, {})
        if not isinstance(current, dict):
            current = {}
            self.player_data[key] = current
        current.setdefault('bool', {})
        current.setdefault('int', {})
        current.setdefault('str', {})
        return current

    def _apply_bool_vars(self, macro: dict):
        bool_vars = self._dynamic_vars('boolVars')
        for name, value in (macro.get('setBoolVar') or {}).items():
            bool_vars['bool'][str(name)] = bool(value)
        for name in macro.get('clearBoolVar') or []:
            bool_vars['bool'].pop(str(name), None)

    def _apply_exec_scripts(self, scripts: list):
        for script in scripts:
            if not isinstance(script, dict):
                continue
            if not self._conditions_met(script.get('ifCondition') or {}):
                continue
            macro = script.get('doMacro') or {}
            if 'addHp%' in macro:
                hp_max = float(self.player_data.get('hpMax', self.player_data.get('maxHp', 0)) or 0)
                current = float(self.player_data.get('hp', hp_max) or 0)
                changed = int(hp_max * float(macro.get('addHp%') or 0) / 100.0)
                self.player_data['hp'] = max(0, min(hp_max, current + changed))
                try:
                    self.session._send_hp_change(changed)
                except Exception:
                    pass

    def _remove_items(self, items: dict):
        for item_code, count in items.items():
            self._remove_item_code(str(item_code), int(count))

    def _clear_items(self, item_codes: list):
        for item_code in item_codes:
            self._remove_item_code(str(item_code), None)

    def _remove_item_code(self, item_code: str, count: Optional[int]):
        rows = self.get_db().execute_query(
            "SELECT BagIndex, SlotIndex, ItemCount FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND ItemCode=? ORDER BY SlotIndex",
            (self.role_name, 1, item_code),
        )
        remaining = count
        for row in rows:
            if remaining is not None and remaining <= 0:
                break
            current = int(row.get('ItemCount') or 0)
            remove_count = current if remaining is None else min(current, remaining)
            bag_index = int(row.get('BagIndex', row.get('bagindex', 1)) or 1)
            slot_index = int(row.get('SlotIndex', row.get('slotindex', 0)) or 0)
            self.get_db().remove_item(self.role_name, bag_index, slot_index, remove_count)
            if remaining is not None:
                remaining -= remove_count

    def _add_role_exp(self, exp: int):
        old_level = int(self.player_data.get('level', 1))
        max_level = int(self.player_data.get('maxLevel', 999))
        current_exp = int(self.player_data.get('exp', 0)) + int(exp)
        new_level = old_level

        while new_level < max_level and current_exp >= self._required_exp_for_level(new_level):
            current_exp -= self._required_exp_for_level(new_level)
            new_level += 1

        levels_gained = new_level - old_level
        self.player_data['exp'] = current_exp
        self.session._send_exp_change(exp)

        if levels_gained:
            self.player_data['level'] = new_level
            gained_points = levels_gained * 5
            self.player_data['freeAttrPt'] = int(self.player_data.get('freeAttrPt', 0)) + gained_points
            self.session._send_level_up(new_level)
            self.session._send_ext_attr_int_change(7, gained_points, self.player_data['freeAttrPt'])
            self.session._restore_vitals_after_level_up()

        self.get_db().execute_non_query(
            "UPDATE TB_Role SET Exp=?, Level=?, AttrRemainPoints=?, HP=?, MaxHP=?, MP=?, MaxMP=? WHERE Name=?",
            (
                int(self.player_data['exp']),
                int(self.player_data.get('level', new_level)),
                int(self.player_data.get('freeAttrPt', 0)),
                int(self.player_data.get('hp', 0)),
                int(self.player_data.get('hpMax', 0)),
                int(self.player_data.get('mp', 0)),
                int(self.player_data.get('mpMax', 0)),
                self.role_name,
            ),
        )

    def _required_exp_for_level(self, level: int) -> int:
        return max(100, int(level * level * 100))

    def _receive_items(self, items: dict):
        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(self.get_db())
        added = []
        for item_code, count in items.items():
            result = inv_mgr.add_item(self.role_name, str(item_code), int(count), 1)
            if result.get('success'):
                added.append({
                    'item_id': result.get('item_id', ''),
                    'item_code': str(item_code),
                    'count': int(count),
                })
            else:
                self.log(f"Falha ao entregar item {item_code}: {result.get('error')}")

        if added:
            self.session._send_item_added_notify(added)
            bag_items = inv_mgr.load_inventory(self.role_name, 1)
            self.session._send_bag_check(1, bag_items)

    def _record_finished_success(self, success_id: int):
        recorder = self.player_data.setdefault('successRecorder', {})
        done = recorder.setdefault('doneSuccesses', [])
        if success_id not in done:
            done.append(success_id)

    def _try_progress_collect_task(self) -> str:
        collect_task = self._active_collect_task()
        if not collect_task:
            return ""
        task_id, item_code, needed = collect_task
        current = self._item_count_in_bag(item_code, 1)
        if current >= needed:
            return f"task={task_id}:{item_code} ja completo {current}/{needed}"

        self._receive_items({item_code: 1})
        return f"task={task_id}:{item_code} {current + 1}/{needed}"

    def _active_collect_task(self):
        recorder = self._recorder()
        for task_id in recorder.get('doingTasks', []):
            task = self._task(int(task_id))
            if not task:
                continue
            condition = task.get('finishRule', {}).get('condition', {})
            items = condition.get('itemsInBag') or {}
            if not items:
                continue
            if self._task_uses_monster_kills(task):
                continue
            text = " ".join(
                str(task.get(key, ""))
                for key in ("name", "note", "detail", "tips")
            ).lower()
            if not any(marker in text for marker in ("colet", "planta", "erva", "collect")):
                continue
            item_code, needed = next(iter(items.items()))
            return int(task_id), str(item_code), int(needed)
        return None

    def _task_uses_monster_kills(self, task: dict) -> bool:
        condition = task.get('finishRule', {}).get('condition', {})
        if condition.get('hasKilledMonster'):
            return True
        text = " ".join(
            str(task.get(key, ""))
            for key in ("name", "note", "detail", "tips")
        ).lower()
        return "derrot" in text or "matar" in text or "monstro" in text

    def _auto_receive_available_tasks(self):
        recorder = self._recorder()
        for task_id, task in sorted(self._tasks().items()):
            if not (4999 <= task_id <= 5100 or 50020 <= task_id <= 50025):
                continue
            if task_id in recorder.get('doingTasks', []):
                continue
            if int(recorder.get('doneTasks', {}).get(str(task_id), recorder.get('doneTasks', {}).get(task_id, 0))) > 0:
                continue
            receive_rule = task.get('receiveRule', {})
            if not receive_rule.get('autoReceive'):
                continue
            if not self._conditions_met(receive_rule.get('condition', {})):
                continue
            recorder['doingTasks'].append(task_id)
            allocator = self._first_npc_allocator(receive_rule.get('atAnyNpc', []))
            recorder['doingAllocators'][allocator] = task_id
            self.get_db().update_task_status(self.role_name, task_id, 'D', allocator, 0)
            # Auto-receive should update state/rewards only. Sending the next
            # mission's receive dialog immediately after a finish dialog stacks
            # talk windows and makes the player press X through a backlog.
            self._apply_task_effects(task_id, 'receive', send_talks=False)
            
            builder = PacketBuilder()
            builder.write_unsigned_short(task_id)
            builder.write_unsigned_short(0)
            self.send_packet(builder.build(self.RECEIVE_NOTIFY))
            self.log(f"Missao auto-aceita: task={task_id}")
            if task_id == 5010 and self.player_data.get('mapId') == 'a2':
                try:
                    self.session._send_player_view_map_answer('a2')
                except Exception as exc:
                    self.log(f"Falha ao reenviar mapa a2 para harvests da 5010: {exc}")
            break

    def _conditions_met(self, condition: dict) -> bool:
        if not condition:
            return True
        done = self._recorder().get('doneTasks', {})
        for task_id in condition.get('hasDoneTask', []):
            if int(done.get(str(task_id), done.get(task_id, 0))) <= 0:
                return False
        if 'hasDoneTaskAny' in condition:
            if not any(
                int(done.get(str(task_id), done.get(task_id, 0))) > 0
                for task_id in condition.get('hasDoneTaskAny', [])
            ):
                return False
        if 'roleJob=' in condition and int(condition['roleJob=']) != int(self.player_data.get('jobCode', 0)):
            return False
        if 'hp%>=' in condition:
            hp_max = float(self.player_data.get('hpMax', self.player_data.get('maxHp', 0)) or 0)
            hp = float(self.player_data.get('hp', 0) or 0)
            if hp_max <= 0 or (hp * 100.0 / hp_max) < float(condition['hp%>=']):
                return False
        if 'boolVar=' in condition:
            bool_values = self._dynamic_vars('boolVars').get('bool', {})
            for name, expected in condition.get('boolVar=', {}).items():
                if bool(bool_values.get(str(name), False)) != bool(expected):
                    return False
        if 'itemsInBag' in condition:
            for item_code, count in condition.get('itemsInBag', {}).items():
                if self._item_count_in_bag(str(item_code), 1) < int(count):
                    return False
        if 'equipItems' in condition:
            equipped = {
                str(row.get('ItemCode'))
                for row in self.get_db().execute_query(
                    "SELECT ItemCode FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=?",
                    (self.role_name, 10),
                )
            }
            if any(str(item_code) not in equipped for item_code in condition.get('equipItems', [])):
                return False
        if 'jobSkPtUsed>=' in condition:
            if self._used_skill_points() < int(condition['jobSkPtUsed>=']):
                return False
        if 'hasKilledMonster' in condition:
            killed = self._dynamic_vars('killedMonsters').get('int', {})
            for monster_code, count in condition.get('hasKilledMonster', {}).items():
                if int(killed.get(str(monster_code), 0)) < int(count):
                    return False
        if 'mainBagSpace>=' in condition:
            try:
                from inventory_manager import InventoryManager
                used = len(InventoryManager(self.get_db()).load_inventory(self.role_name, 1))
                capacity = int(self.player_data.get('BagCapacityPlayer', self.player_data.get('bagCapacityPlayer', 36)))
                if capacity - used < int(condition['mainBagSpace>=']):
                    return False
            except Exception:
                return False
        return True

    def _item_count_in_bag(self, item_code: str, bag_index: int) -> int:
        rows = self.get_db().execute_query(
            "SELECT ItemCount FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND ItemCode=?",
            (self.role_name, bag_index, item_code),
        )
        return sum(int(row.get('ItemCount') or 0) for row in rows)

    def _used_skill_points(self) -> int:
        total = 0
        resource_index = getattr(self.server, 'resource_index', None)
        for code, level in self.player_data.get('learnedSkills', {}).items():
            if resource_index and hasattr(resource_index, 'is_basic_attack') and resource_index.is_basic_attack(code):
                continue
            total += max(0, int(level or 0))
        return total

    def _first_npc_allocator(self, npcs: List[str]) -> int:
        return self._npc_allocator_id(npcs[0]) if npcs else 0

    def _send_show_talks(self, talks: list):
        """Send PLAYER_SHOW_TALKS_NOTIFY (676) with formatted talks"""
        formatted_talks = []
        for talk in talks:
            if isinstance(talk, dict):
                text = talk.get('talk', '')
                speaker = talk.get('speaker', '')
                if speaker == 'i':
                    continue
                formatted_talks.append(text)
            elif isinstance(talk, str):
                formatted_talks.append(talk)
        
        if formatted_talks:
            formatted_talks = formatted_talks[:1]
            builder = PacketBuilder()
            builder.write_varint(len(formatted_talks))
            for t in formatted_talks:
                builder.write_string(t)
            self.send_packet(builder.build(676))  # PLAYER_SHOW_TALKS_NOTIFY
            self.log(f"Sent ShowTalks: {formatted_talks}")

    def _update_role_field(self, field: str, value: int):
        allowed = {'Gold', 'Exp', 'HonorValue', 'Level', 'AttrRemainPoints'}
        if field not in allowed:
            return
        self.get_db().execute_non_query(
            f"UPDATE TB_Role SET {field}=? WHERE Name=?",
            (value, self.role_name),
        )
