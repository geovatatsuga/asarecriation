import json
import os
from pathlib import Path
from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from config import GAME_RESOURCES_DIR
from protocol.commands import NpcCommandCode

class NpcHandler(BaseHandler):
    _assemble_rules = None

    @classmethod
    def get_handlers(cls):
        return {
            NpcCommandCode.NPC_FUNCTION_REQUEST: 'handle_menu_action',
            NpcCommandCode.NPC_ASSEMBLE_ITEM_REQUEST: 'handle_assemble_item',
        }

    def handle_menu_action(self, reader: PacketReader):
        try:
            npc_id = reader.read_string()
            
            # Read array of bytes
            array_len = reader.read_varint()
            menu_index = []
            for _ in range(array_len):
                menu_index.append(reader.read_byte())
                
            self.log(f"Interact NPC: npcId={npc_id}, menuIndex={menu_index}")
            
            if not self.player_data:
                self.log("❌ Player data not loaded")
                return

            # Resolve the map file
            map_id = self.player_data.get('mapId', 'a1')
            map_path = os.path.join(GAME_RESOURCES_DIR, "decoded", f"m{map_id}.json")
            if not os.path.exists(map_path):
                self.log(f"❌ Map file not found: {map_path}")
                return
                
            with open(map_path, "r", encoding="utf-8") as f:
                map_def = json.load(f)
                
            npc_list = map_def.get("npcList", [])
            npc = None
            for n in npc_list:
                if n.get("id") == npc_id or f"{n.get('id')}@{map_id}" == npc_id:
                    npc = n
                    break
                    
            if not npc:
                # Fallback to check without @ suffix just in case
                simple_npc_id = npc_id.split("@")[0]
                for n in npc_list:
                    if n.get("id") == simple_npc_id:
                        npc = n
                        break

            if not npc:
                self.log(f"❌ NPC {npc_id} not found in map {map_id}")
                return
                
            current_menu = npc
            resolved_index = menu_index
            
            # If the first index is -1, skip it
            if resolved_index and resolved_index[0] == -1:
                resolved_index = resolved_index[1:]
                
            # Walk menu
            for idx in resolved_index:
                if isinstance(current_menu, dict) and "menus" in current_menu:
                    menus = current_menu["menus"]
                    if 0 <= idx < len(menus):
                        current_menu = menus[idx]
                    else:
                        self.log(f"⚠️ Index {idx} out of bounds for menus of size {len(menus)}")
                        break
                else:
                    self.log(f"⚠️ Cannot descend index {idx} in {current_menu}")
                    break
            
            self.log(f"Resolved menu option: {current_menu.get('label') if isinstance(current_menu, dict) else current_menu}")
            
            if isinstance(current_menu, dict):
                # Check condition if present at menu level
                cond = current_menu.get("condition", {})
                if cond and not self._check_condition(cond):
                    self.log(f"⚠️ Conditions not met for menu option: {cond}")
                    return
                
                # Process scripts
                para = current_menu.get("functionPara", {})
                scripts = para.get("scripts", [])
                for script in scripts:
                    self._execute_script(script, npc_id)

                # Confirm to the client
                builder = PacketBuilder()
                builder.write_string(npc_id) # npcFullId
                self.send_packet(builder.build(self.NPC_FUNCTION_ANSWER))

        except Exception as e:
            self.log(f"Erro em handle_menu_action: {e}")
            import traceback
            traceback.print_exc()

    def _check_condition(self, condition: dict) -> bool:
        # Evaluate conditions like roleLevel, roleRebornTimes, boolVar, etc.
        role_level = condition.get("roleLevel>=") or condition.get("roleLevel")
        if role_level is not None:
            current_level = int(self.player_data.get("level", 1))
            if current_level < int(role_level):
                return False
                
        reborn = condition.get("roleRebornTimes>=") or condition.get("roleRebornTimes")
        if reborn is not None:
            current_reborn = int(self.player_data.get("rebornTimes", 0))
            if current_reborn < int(reborn):
                return False
                
        bool_var = condition.get("boolVar=") or condition.get("boolVar")
        if bool_var and isinstance(bool_var, dict):
            sys_bools = self.player_data.get("sysVars", {}).get("bool", {})
            for var_name, expected_val in bool_var.items():
                actual_val = sys_bools.get(var_name, False)
                if actual_val != expected_val:
                    return False
        return True

    def _execute_script(self, script: dict, npc_id: str):
        if_cond = script.get("ifCondition")
        if if_cond:
            if self._check_condition(if_cond):
                macro = script.get("doMacro", {})
                self._apply_macro(macro, npc_id)
            else:
                else_macro = script.get("elseDoMacro", {})
                self._apply_macro(else_macro, npc_id)
        else:
            macro = script.get("doMacro", {})
            if not macro:
                macro = script
            self._apply_macro(macro, npc_id)

    def _apply_macro(self, macro: dict, npc_id: str):
        if not macro or not self.player_data:
            return
            
        # 1. receiveItems
        items = macro.get("receiveItems")
        if items:
            self._receive_items(items)
            
        # 2. setBoolVar
        bool_vars = macro.get("setBoolVar")
        if bool_vars:
            sys_vars = self.player_data.setdefault("sysVars", {})
            bool_store = sys_vars.setdefault("bool", {})
            for k, v in bool_vars.items():
                bool_store[k] = bool(v)
                self.log(f"SetBoolVar: {k} = {v}")
            
        # 3. showTalks
        talks = macro.get("showTalks")
        if talks:
            formatted_talks = []
            for talk in talks:
                if ":" not in talk:
                    formatted_talks.append(f"{npc_id}:{talk}")
                else:
                    formatted_talks.append(talk)
            
            formatted_talks = formatted_talks[:1]
            builder = PacketBuilder()
            builder.write_varint(len(formatted_talks))
            for t in formatted_talks:
                builder.write_string(t)
            self.send_packet(builder.build(self.PLAYER_SHOW_TALKS_NOTIFY))
            self.log(f"Sent ShowTalks: {formatted_talks}")

        # 4. teleport
        teleport = macro.get("teleport")
        if teleport:
            to_map = teleport.get("toMap")
            to_entry = teleport.get("toEntry")
            self.log(f"NPC Teleport: map={to_map}, entry={to_entry}")
            
            from servers.world_server import MAP_ENTRIES
            entry_info = MAP_ENTRIES.get(to_map, {}).get(to_entry)
            if entry_info:
                pos_x = entry_info.get("x", 1000)
                pos_y = entry_info.get("y", 1000)
                
                self.player_data["mapId"] = to_map
                self.player_data["posX"] = pos_x
                self.player_data["posY"] = pos_y
                
                self.get_db().execute_non_query(
                    "UPDATE TB_Role SET MapID=?, PosX=?, PosY=? WHERE Name=?",
                    (to_map, pos_x, pos_y, self.role_name)
                )
                
                transition_builder = PacketBuilder()
                transition_builder.write_string(to_map)
                from servers.world_server import write_map_point
                write_map_point(transition_builder, pos_x, pos_y)
                transition_builder.write_string("")
                transition_builder.write_byte(0) 
                
                self.send_packet(transition_builder.build(518))
                self.log(f"Sent map transition to client: map={to_map}, pos=({pos_x}, {pos_y})")

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

    def handle_assemble_item(self, reader: PacketReader):
        """Handle NPC_ASSEMBLE_ITEM_REQUEST (1026)
        
        AS Field order:
        - npcId: string
        - funcMenuFullIndex: array(byte)
        - assembleRuleIndex: ushort
        - addedItems: array(string)
        - baseItemIds: array(string)
        - priorityEqualItem: boolean
        - protectionItem: string
        """
        try:
            npc_id = reader.read_string()
            
            # Read funcMenuFullIndex array (bytes)
            array_len = reader.read_varint()
            menu_index = []
            for _ in range(array_len):
                menu_index.append(reader.read_byte())
            
            assemble_rule_index = reader.read_unsigned_short()
            
            # Read addedItems array (strings)
            added_items_len = reader.read_varint()
            added_items = []
            for _ in range(added_items_len):
                added_items.append(reader.read_string())
            
            # Read baseItemIds array (strings)
            base_items_len = reader.read_varint()
            base_item_ids = []
            for _ in range(base_items_len):
                base_item_ids.append(reader.read_string())
            
            priority_equal_item = reader.read_bool()
            protection_item = reader.read_string()
            
            self.log(f"NPC_ASSEMBLE_ITEM_REQUEST: npcId={npc_id}, ruleIndex={assemble_rule_index}, "
                     f"menuIndex={menu_index}, addedItems={added_items}, baseItems={base_item_ids}, "
                     f"priorityEqual={priority_equal_item}, protectionItem={protection_item}")
            
            if not self.player_data:
                self.log("❌ Player data not loaded")
                self._send_assemble_answer(assemble_rule_index, False)
                return
            
            result = self._perform_assemble(
                assemble_rule_index,
                base_item_ids=base_item_ids,
                added_item_ids=added_items,
                protection_item=protection_item,
            )
            self._send_assemble_answer(assemble_rule_index, bool(result.get("success")))
            if result.get("success"):
                self._sync_main_bag()
            else:
                self.log(f"NPC assemble failed: {result.get('error')}")
            
        except Exception as e:
            self.log(f"Error handling assemble item: {e}")
            import traceback
            traceback.print_exc()
            try:
                self._send_assemble_answer(0, False)
            except Exception:
                pass

    @classmethod
    def _load_assemble_rules(cls):
        if cls._assemble_rules is not None:
            return cls._assemble_rules
        cls._assemble_rules = {}
        path = Path(GAME_RESOURCES_DIR) / "decoded" / "iar.json"
        if not path.exists():
            return cls._assemble_rules
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            return cls._assemble_rules
        for rule in data:
            if not isinstance(rule, dict):
                continue
            rule_index = rule.get("ruleIndex")
            if rule_index is not None:
                cls._assemble_rules[str(rule_index)] = rule
        return cls._assemble_rules

    def _perform_assemble(self, assemble_rule_index: int, base_item_ids=None, added_item_ids=None, protection_item: str = ""):
        rule = self._load_assemble_rules().get(str(assemble_rule_index))
        if not rule:
            return {"success": False, "error": f"Regra de montagem nao encontrada: {assemble_rule_index}"}

        required_level = int((rule.get("condition") or {}).get("roleLevel>=") or 0)
        if required_level and int(self.player_data.get("level", 1)) < required_level:
            return {"success": False, "error": f"Nivel insuficiente: requer {required_level}"}

        target_items = rule.get("targetItems") or {}
        if not target_items and rule.get("itemUpgrade"):
            target_items = {rule["itemUpgrade"]: 1}
        if not target_items:
            return {"success": False, "error": "Regra sem targetItems/itemUpgrade"}

        required_items = {str(code): int(count) for code, count in (rule.get("baseItems") or {}).items()}
        if not required_items:
            return {"success": False, "error": "Regra sem baseItems"}

        selections = self._select_assemble_materials(required_items, base_item_ids or [], added_item_ids or [])
        if not selections.get("success"):
            return selections

        db = self.get_db()
        for item_id, count in selections["items"]:
            removed = db.remove_inventory_item_by_id(self.role_name, item_id, count)
            if not removed.get("Success", removed.get("success", False)):
                return {"success": False, "error": removed.get("ErrorMsg", removed.get("error", "Falha ao consumir material"))}

        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(db)
        added = []
        for item_code, count in target_items.items():
            result = inv_mgr.add_item(self.role_name, str(item_code), int(count), 1)
            if not result.get("success"):
                return {"success": False, "error": result.get("error", "Falha ao entregar item montado")}
            added.append({
                "item_id": result.get("item_id", ""),
                "item_code": str(item_code),
                "count": int(count),
            })

        if added and hasattr(self.session, "_send_item_added_notify"):
            self.session._send_item_added_notify(added)

        self.log(
            f"NPC assemble success: rule={assemble_rule_index}, type={rule.get('type')}, "
            f"{rule.get('itemBase')}->{rule.get('itemUpgrade') or target_items}"
        )
        return {"success": True, "added": added, "rule": rule}

    def _select_assemble_materials(self, required_items: dict, base_item_ids: list, added_item_ids: list):
        db = self.get_db()
        inventory = self._load_main_bag_rows()
        by_id = {str(item.get("item_id") or item.get("ItemId")): item for item in inventory if item.get("item_id") or item.get("ItemId")}
        remaining = dict(required_items)
        selected = {}

        for item_id in list(base_item_ids) + list(added_item_ids):
            if not item_id:
                continue
            item = by_id.get(str(item_id))
            if not item and hasattr(db, "get_inventory_item_by_id"):
                item = db.get_inventory_item_by_id(self.role_name, str(item_id))
            if not item:
                return {"success": False, "error": f"Item informado nao encontrado: {item_id}"}
            code = str(item.get("item_code") or item.get("ItemCode"))
            if code not in remaining or remaining[code] <= 0:
                continue
            count = min(int(item.get("item_count") or item.get("ItemCount") or 1), remaining[code])
            selected[str(item_id)] = selected.get(str(item_id), 0) + count
            remaining[code] -= count

        for item in inventory:
            code = str(item.get("item_code") or item.get("ItemCode"))
            if code not in remaining or remaining[code] <= 0:
                continue
            item_id = str(item.get("item_id") or item.get("ItemId"))
            if not item_id:
                continue
            available = int(item.get("item_count") or item.get("ItemCount") or 1)
            take = min(available, remaining[code])
            selected[item_id] = selected.get(item_id, 0) + take
            remaining[code] -= take

        missing = {code: count for code, count in remaining.items() if count > 0}
        if missing:
            return {"success": False, "error": f"Materiais insuficientes: {missing}"}
        return {"success": True, "items": list(selected.items())}

    def _load_main_bag_rows(self):
        from inventory_manager import InventoryManager
        items = InventoryManager(self.get_db()).load_inventory(self.role_name, 1)
        rows = []
        for item in items:
            if hasattr(item, "__dict__"):
                rows.append({
                    "item_id": item.item_id,
                    "item_code": item.item_code,
                    "item_count": item.item_count,
                    "slot_index": item.slot_index,
                })
            else:
                rows.append(item)
        return rows

    def _sync_main_bag(self):
        if not hasattr(self.session, "_send_bag_check"):
            return
        from inventory_manager import InventoryManager
        bag_items = InventoryManager(self.get_db()).load_inventory(self.role_name, 1)
        self.session._send_bag_check(1, bag_items)

    def _send_assemble_answer(self, assemble_rule_index: int, is_succeeded: bool):
        """Send NPC_ASSEMBLE_ITEM_ANSWER (1027)"""
        builder = PacketBuilder()
        builder.write_unsigned_short(assemble_rule_index)
        builder.write_bool(is_succeeded)
        self.send_packet(builder.build(NpcCommandCode.NPC_ASSEMBLE_ITEM_ANSWER))
        self.log(f"📤 NPC_ASSEMBLE_ITEM_ANSWER: ruleIndex={assemble_rule_index}, success={is_succeeded}")
