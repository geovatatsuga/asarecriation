import threading
import time
from typing import Dict
from .base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import BagCommandCode, EquipmentCommandCode

class InventoryHandler(BaseHandler):
    
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            BagCommandCode.PLAYER_USE_ITEM_REQ: 'handle_use_item',
            BagCommandCode.PLAYER_MOVE_ITEM_REQ: 'handle_move_item',
            BagCommandCode.PLAYER_SPLIT_ITEM_REQ: 'handle_split_item',
            BagCommandCode.PLAYER_MOVE_ITEM_CROSS_BAG_REQ: 'handle_move_item_cross_bag',
            BagCommandCode.PLAYER_VIEW_BAG_REQ: 'handle_view_bag',
            BagCommandCode.PLAYER_VIEW_ITEM_REQ: 'handle_view_item',
            BagCommandCode.PLAYER_RENEW_ITEM_REQ: 'handle_renew_item',
            BagCommandCode.PLAYER_BUY_AND_USE_ITEM_REQ: 'handle_buy_and_use_item',
            EquipmentCommandCode.PLAYER_REMOVE_EQUIPMENT_REQ: 'handle_remove_equipment',
            EquipmentCommandCode.PLAYER_SWITCH_FASHION_REQUEST: 'handle_switch_fashion',
            EquipmentCommandCode.PLAYER_VIEW_REPAIR_INFO_REQUEST: 'handle_view_repair_info',
            EquipmentCommandCode.PLAYER_REPAIR_EQUIPMENT_REQUEST: 'handle_repair_equipment',
            BagCommandCode.PLAYER_BAG_SORT_REQ: 'handle_bag_sort',
        }
    
    def handle_use_item(self, reader: PacketReader):
        """
        Usar item (cmd 5124)
        Se bagIndex >= 10, é desequipar item
        Se bagIndex == 1, é usar/equipar item
        """
        try:
            raw_data = reader.data[reader.pos:]
            self.log(f"🎮 UseItem raw ({len(raw_data)} bytes): {raw_data.hex()}")
            
            bag_index = reader.read_unsigned_byte()
            
            first_byte = reader.data[reader.pos]
            if first_byte >= 128:
                item_index = reader.read_varint()
            else:
                item_index = reader.read_unsigned_byte()
            
            map_id = reader.read_string() if reader.remaining() > 0 else ""
            
            target_x, target_y = 0, 0
            if reader.remaining() >= 2:
                point_size = reader.read_short()
                if point_size == 4:
                    target_x = reader.read_short()
                    target_y = reader.read_short()
                elif point_size > 0:
                    reader.skip(point_size)
            
            target_obj_id = reader.read_string() if reader.remaining() > 0 else ""
            parameters = {}
            if reader.remaining() > 0:
                try:
                    param_count = reader.read_varint()
                    for _ in range(param_count):
                        key = reader.read_string()
                        value = reader.read_string()
                        parameters[key] = value
                except Exception as parse_error:
                    self.log(f"UseItem parameters parse skipped: {parse_error}")
            
            self.log(f"🎮 UseItem: bag={bag_index}, slot={item_index}, map={map_id}")
            
            if not self.player_data:
                self.log("❌ Player data não disponível")
                return
            
            role_name = self.role_name
            
            if bag_index >= 10:
                self._handle_unequip_item(role_name, bag_index, item_index)
            else:
                self._handle_use_or_equip_item(role_name, bag_index, item_index)
                
        except Exception as e:
            self.log(f"Erro ao usar item: {e}")
            import traceback
            traceback.print_exc()
    
    def _handle_use_or_equip_item(self, role_name: str, bag_index: int, slot_index: int):
        """Usa ou equipa um item do inventário"""
        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(self.get_db())
        
        items = inv_mgr.load_inventory(role_name, bag_index)
        item = next((i for i in items if i.slot_index == slot_index), None)
        
        if not item:
            self.log(f"❌ Item não encontrado no slot {slot_index}")
            return
        
        item_def = inv_mgr.get_item_definition(item.item_code)
        
        if not item_def:
            self.log(f"❌ Definição do item {item.item_code} não encontrada")
            return
        
        item_type = int(item_def.get('ItemType', item_def.get('type', 0)) or 0)
        
        self.log(f"📦 Item: {item.item_code}, tipo={item_type}")
        
        if item_type == 4:
            self._equip_item(role_name, item, item_def, bag_index, slot_index)
        elif item_type in (1, 2):
            self._consume_item(role_name, item, item_def, bag_index, slot_index)
        else:
            self.log(f"⚠️ Tipo de item {item_type} não implementado")
    
    def _equip_item(self, role_name: str, item, item_def: dict, from_bag: int, from_slot: int):
        """Equipa um item de equipamento"""
        import json
        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(self.get_db())
        try:
            extra = item_def.get('ExtraDataJson') or {}
            extra = json.loads(extra) if isinstance(extra, str) else extra
        except Exception:
            extra = {}
        required_level = int(extra.get('requiredLevel', extra.get('level', 0)) or 0)
        allowed_jobs = extra.get('jobCodes', extra.get('jobs', extra.get('jobCode')))
        if required_level > int(self.player_data.get('level', 1)):
            self.log(f"Equip recusado: requer nivel {required_level}")
            return
        if allowed_jobs is not None:
            allowed_jobs = allowed_jobs if isinstance(allowed_jobs, list) else [allowed_jobs]
            if int(self.player_data.get('jobCode', 1)) not in [int(x) for x in allowed_jobs]:
                self.log("Equip recusado: classe incompativel")
                return
        
        subtype = item_def.get('ItemSubType', item_def.get('SubType', 0))
        equip_slot = self._get_equip_slot_for_subtype(subtype)
        
        self.log(f"🔧 Item {item.item_code}: SubType={subtype}, slot={equip_slot}")
        
        if equip_slot < 0:
            self.log(f"❌ SubType {subtype} não é equipável")
            return
        
        equip_bag = 10
        
        result = inv_mgr.equip_item(role_name, from_bag, from_slot, equip_bag, equip_slot)
        
        if not result['success']:
            self.log(f"❌ Erro ao equipar: {result['error']}")
            return
        
        from item_config_loader import item_config
        model_code = item_config.get_model_code(item.item_code)
        
        if not model_code:
            self.log(f"⚠️ ModelCode não encontrado para {item.item_code} no iie.txt!")
        
        self.log(f"📋 FASHION DEBUG: ItemCode={item.item_code}, SubType={item_def.get('ItemSubType')}, ModelCode={model_code}, EquipSlot={equip_slot}")
        
        self._update_equipment_model(role_name, equip_slot, model_code)
        
        if self.player_data and 'equipmentModels' in self.player_data:
            self.player_data['equipmentModels'][equip_slot] = model_code
            self.log(f"📋 FASHION DEBUG: equipmentModels atualizado: {self.player_data['equipmentModels']}")
        
        self._send_item_used_notify(from_bag, from_slot, item.item_code)
        
        items_from = inv_mgr.load_inventory(role_name, from_bag)
        self.session._send_bag_check(from_bag, items_from, [from_slot])
        
        items_equip = inv_mgr.load_inventory(role_name, equip_bag)
        
        for equip_item in items_equip:
            equip_item_def_result = self.get_db().execute_query(
                "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                (equip_item.item_code,)
            )
            equip_item_def = equip_item_def_result[0] if equip_item_def_result else None
            self.session._send_view_item_answer(equip_item, equip_item.item_id, equip_item_def)
        self.log(f"📦 GameItemFullInfo: {len(items_equip)} equipamentos pré-carregados")
        
        self.session._send_equipment_check_notify(items_equip)
        
        self.session._send_player_attributes()
        
        self._send_equipment_model_delayed(role_name, 0.5)
        
        self.log(f"✅ Item {item.item_code} equipado no slot {equip_slot} com modelo {model_code}!")
    
    def _consume_item(self, role_name: str, item, item_def: dict, bag_index: int, slot_index: int):
        """Usa um item consumível"""
        import json
        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(self.get_db())

        extra = item_def.get('ExtraDataJson') or item_def.get('properties') or {}
        try:
            extra = json.loads(extra) if isinstance(extra, str) else extra
        except Exception:
            extra = {}
        cooldown_ms = self._get_item_cooldown_ms(item_def, extra)
        if cooldown_ms > 0:
            remaining_ms = self._item_cooldown_remaining_ms(item.item_code)
            if remaining_ms > 0:
                self._send_item_cd_check_notify([(item.item_code, remaining_ms)])
                self.log(f"Item {item.item_code} em cooldown: {remaining_ms}ms restantes")
                return
        heal = next((extra.get(key) for key in (
            'hpAddFixed', 'hpAdd', 'addHp', 'recoverHp', 'restoreHp',
            'hpRestore', 'healHp', 'heal',
        ) if extra.get(key) is not None), None)
        mp_restore = next((extra.get(key) for key in (
            'mpAddFixed', 'mpAdd', 'addMp', 'recoverMp', 'restoreMp',
            'mpRestore', 'manaRestore', 'mana',
        ) if extra.get(key) is not None), None)
        hp_before = float(self.player_data.get('hp', 0))
        hp_max = float(self.player_data.get('hpMax', max(100, hp_before)))
        heal = float(heal) if heal is not None else max(50.0, hp_max * 0.25)
        hp_after = min(hp_max, hp_before + max(0.0, heal))
        mp_before = int(self.player_data.get('mp', 0))
        mp_max = int(self.player_data.get('mpMax', max(100, mp_before)))
        mp_amount = int(float(mp_restore)) if mp_restore is not None else 0
        mp_after = min(mp_max, mp_before + max(0, mp_amount))

        result = inv_mgr.remove_item(role_name, bag_index, slot_index, 1)
        
        if result['success']:
            self.player_data['hp'] = hp_after
            self.player_data['mp'] = mp_after
            if cooldown_ms > 0:
                self._start_item_cooldown(item.item_code, cooldown_ms)
            hp_changed = hp_after - hp_before
            if hp_changed:
                hp_notify = PacketBuilder()
                hp_notify.write_double(float(hp_changed))
                hp_notify.write_double(float(hp_after))
                hp_notify.write_string(item.item_code)
                hp_notify.write_bool(False)
                hp_notify.write_bool(False)
                self.send_packet(hp_notify.build(550))
                self.server.broadcast_remote_hp(self.session, hp_changed, item.item_code, False)
            if mp_after != mp_before:
                mp_notify = PacketBuilder()
                mp_notify.write_int(int(mp_after - mp_before))
                mp_notify.write_int(int(mp_after))
                mp_notify.write_string(item.item_code)
                self.send_packet(mp_notify.build(552))
                if hasattr(self.server, 'broadcast_remote_mp'):
                    self.server.broadcast_remote_mp(self.session, mp_after - mp_before, item.item_code)
            if cooldown_ms > 0:
                self._send_item_cd_check_notify([(item.item_code, cooldown_ms)])
            self._send_item_used_notify(bag_index, slot_index, item.item_code)
            
            items = inv_mgr.load_inventory(role_name, bag_index)
            remaining = next((i for i in items if i.slot_index == slot_index), None)
            empty = [slot_index] if not remaining else []
            self.session._send_bag_check(bag_index, items, empty)
            
            self._apply_item_result_scripts(self._get_item_result_scripts(item_def))
            self.log(f"✅ Item {item.item_code} usado!")

    def _get_item_result_scripts(self, item_def: dict) -> list:
        """Extrai scripts de properties.result usados por itens de missão."""
        import json

        raw_extra = item_def.get('ExtraDataJson') or item_def.get('properties') or {}
        try:
            extra = json.loads(raw_extra) if isinstance(raw_extra, str) else raw_extra
        except Exception:
            extra = {}

        if not isinstance(extra, dict):
            return []

        properties = extra.get('properties') if isinstance(extra.get('properties'), dict) else extra
        result = properties.get('result') if isinstance(properties, dict) else {}
        if not isinstance(result, dict):
            return []

        for entry in result.values():
            if isinstance(entry, dict) and isinstance(entry.get('scripts'), list):
                return entry['scripts']
        return []

    def _apply_item_result_scripts(self, scripts: list):
        if not scripts:
            return

        for script in scripts:
            if not isinstance(script, dict):
                continue
            condition = script.get('ifCondition')
            if condition and not self._item_condition_met(condition):
                continue
            macro = script.get('doMacro') if condition else script.get('doMacro')
            if not macro and not condition:
                macro = script
            self._apply_item_macro(macro)

    def _item_condition_met(self, condition: dict) -> bool:
        if not condition or not self.player_data:
            return True

        for key, value in condition.items():
            if key == 'mainBagSpace>=':
                try:
                    from inventory_manager import InventoryManager
                    used = len(InventoryManager(self.get_db()).load_inventory(self.role_name, 1))
                    capacity = int(self.player_data.get('BagCapacityPlayer', self.player_data.get('bagCapacityPlayer', 36)))
                    if capacity - used < int(value):
                        return False
                except Exception as exc:
                    self.log(f"Condição item mainBagSpace>= falhou: {exc}")
                    return False
            elif key == 'roleLevel>=':
                if int(self.player_data.get('level', 1)) < int(value):
                    return False
            elif key == 'mapDmg>=':
                if int(self.player_data.get('mapDmg', 0)) < int(value):
                    return False
            else:
                self.log(f"Condição de item ainda não suportada: {key}")
        return True

    def _apply_item_macro(self, macro: dict):
        if not isinstance(macro, dict) or not self.player_data:
            return

        bool_vars = macro.get('setBoolVar') or {}
        if bool_vars:
            bool_store = self.player_data.setdefault('boolVars', {}).setdefault('bool', {})
            for name, value in bool_vars.items():
                bool_store[str(name)] = bool(value)
                self.log(f"Item SetBoolVar: {name} = {value}")

        talks = macro.get('showTalks') or []
        if talks:
            formatted = [str(t).split(':', 1)[1] if isinstance(t, str) and ':' in t else str(t) for t in talks]
            formatted = formatted[:1]
            builder = PacketBuilder()
            builder.write_varint(len(formatted))
            for talk in formatted:
                builder.write_string(talk)
            self.send_packet(builder.build(676))
            self.log(f"Sent Item ShowTalks: {formatted}")

        hp_amount = macro.get('addHp')
        if hp_amount:
            hp_max = float(self.player_data.get('hpMax', 0) or 0)
            hp_before = float(self.player_data.get('hp', 0) or 0)
            hp_after = min(hp_max, hp_before + float(hp_amount))
            self.player_data['hp'] = hp_after
            hp_changed = hp_after - hp_before
            if hp_changed:
                hp_notify = PacketBuilder()
                hp_notify.write_double(hp_changed)
                hp_notify.write_double(hp_after)
                hp_notify.write_string('')
                hp_notify.write_bool(False)
                hp_notify.write_bool(False)
                self.send_packet(hp_notify.build(550))
                self.server.broadcast_remote_hp(self.session, hp_changed, '', False)

        mp_amount = macro.get('addMp')
        if mp_amount:
            mp_max = float(self.player_data.get('mpMax', 0) or 0)
            mp_before = float(self.player_data.get('mp', 0) or 0)
            mp_after = min(mp_max, mp_before + float(mp_amount))
            self.player_data['mp'] = mp_after
            mp_changed = mp_after - mp_before
            if mp_changed:
                mp_notify = PacketBuilder()
                mp_notify.write_int(int(mp_changed))
                mp_notify.write_int(int(mp_after))
                mp_notify.write_string('')
                self.send_packet(mp_notify.build(552))

        gold = int(macro.get('addGold') or 0)
        if gold:
            self.player_data['gold'] = int(self.player_data.get('gold', 0)) + gold
            self.get_db().execute_non_query('UPDATE TB_Role SET Gold=Gold+? WHERE Name=?', (gold, self.role_name))
            self.session._send_gold_change(gold)

        exp = int(macro.get('addRoleExp') or 0)
        if exp:
            self.player_data['exp'] = int(self.player_data.get('exp', 0)) + exp
            self.session._send_exp_change(exp)

        items = macro.get('receiveItems') or {}
        if items:
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
            if added:
                self.session._send_item_added_notify(added)
                self.session._send_bag_check(1, inv_mgr.load_inventory(self.role_name, 1))

    def _get_item_cooldown_ms(self, item_def: dict, extra: dict) -> int:
        value = next((extra.get(key) for key in (
            'cdTimeInMS', 'cdTimeMs', 'cooldownMs', 'coldTimeMs', 'itemCDTime',
            'cdTime', 'cooldown', 'coldTime',
        ) if extra.get(key) is not None), None)
        if value is None:
            value = next((item_def.get(key) for key in (
                'CDTime', 'CdTime', 'CoolDown', 'Cooldown', 'CooldownMs', 'coldTime',
            ) if item_def.get(key) is not None), None)
        if value is None:
            return 1500
        try:
            value = float(value)
        except (TypeError, ValueError):
            return 1500
        return int(value if value > 100 else value * 1000)

    def _item_cooldown_remaining_ms(self, item_code: str) -> int:
        cooldowns = self.player_data.setdefault('itemCooldowns', {})
        expire_at = float(cooldowns.get(item_code) or cooldowns.get('*potion') or 0)
        return max(0, int((expire_at - time.monotonic()) * 1000))

    def _start_item_cooldown(self, item_code: str, cooldown_ms: int):
        expire_at = time.monotonic() + cooldown_ms / 1000.0
        cooldowns = self.player_data.setdefault('itemCooldowns', {})
        cooldowns[item_code] = expire_at
        cooldowns['*potion'] = expire_at

    def _send_item_cd_check_notify(self, cd_items):
        """PlayerItemCDCheckNotify: cdItems:array(CDItemInfo(code:string, cdTimeLeftInMS:int))."""
        from servers.world_server import write_transportable_object
        builder = PacketBuilder()
        builder.write_varint(len(cd_items))
        for item_code, remaining_ms in cd_items:
            def write_cd_item(b, code=item_code, ms=remaining_ms):
                b.write_string(code)
                b.write_int(int(ms))
            write_transportable_object(builder, write_cd_item)
        self.send_packet(builder.build(BagCommandCode.PLAYER_ITEM_CD_CHECK_NOTIFY))

    def _handle_unequip_item(self, role_name: str, equip_bag: int, equip_slot: int):
        """Desequipa um item"""
        from inventory_manager import InventoryManager
        inv_mgr = InventoryManager(self.get_db())
        
        equipped_items = inv_mgr.load_inventory(role_name, equip_bag)
        item = next((i for i in equipped_items if i.slot_index == equip_slot), None)
        
        if not item:
            self.log(f"❌ Nenhum item no slot {equip_slot}")
            return
        
        main_bag = 1
        capacity = self.player_data.get('bag_capacity_player', 42) if self.player_data else 42
        empty_slot = inv_mgr.find_empty_slot(role_name, main_bag, capacity)
        
        if empty_slot is None:
            self.log(f"❌ Inventário cheio")
            return
        
        result = inv_mgr.equip_item(role_name, equip_bag, equip_slot, main_bag, empty_slot)
        
        if not result['success']:
            self.log(f"❌ Erro ao desequipar: {result['error']}")
            return
        
        self._update_equipment_model(role_name, equip_slot, '')
        
        if self.player_data and 'equipmentModels' in self.player_data:
            if equip_slot in self.player_data['equipmentModels']:
                del self.player_data['equipmentModels'][equip_slot]
        
        
        self.log(f"🔍 DEBUG: Carregando inventário da bag {equip_bag} para verificar itens restantes...")
        items_equip = inv_mgr.load_inventory(role_name, equip_bag)
        self.log(f"🔍 DEBUG: Retornados {len(items_equip)} itens da bag {equip_bag}: {[f'slot{i.slot_index}={i.item_code}' for i in items_equip]}")
        
        for equip_item in items_equip:
            equip_item_def_result = self.get_db().execute_query(
                "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                (equip_item.item_code,)
            )
            equip_item_def = equip_item_def_result[0] if equip_item_def_result else None
            self.session._send_view_item_answer(equip_item, equip_item.item_id, equip_item_def)
        self.log(f"📦 GameItemFullInfo: {len(items_equip)} equipamentos atualizados")
        
        self.session._send_equipment_check_notify(items_equip, empty_equipment_slots=[equip_slot])
        
        self.session._send_player_attributes()
        
        items_main = inv_mgr.load_inventory(role_name, main_bag)
        self.session._send_bag_check(main_bag, items_main, [empty_slot])
        
        self._send_equipment_model_delayed(role_name, 0.5)
        
        self.log(f"✅ Item {item.item_code} desequipado do slot {equip_slot}")
    
    def _get_equip_slot_for_subtype(self, subtype: int) -> int:
        """Retorna o slot de equipamento para um subtype"""
        if subtype >= 1024:
            kind = subtype - 1024
        else:
            kind = subtype
        
        kind_to_slot = {
            0: 0,
            1: 1,
            2: 2,
            3: 3,
            4: 4,
            5: 5,
            6: 6,
            7: 7,
            8: 8,
            9: 9,
            10: 10,
            11: 11, 12: 12, 13: 13, 14: 14, 15: 15,
            102: 102,
            103: 103,
            104: 104,
        }
        
        return kind_to_slot.get(kind, -1)
    
    def _send_item_used_notify(self, bag_index: int, slot_index: int, item_code: str):
        """Envia PlayerItemUsedNotify (cmd 5130)"""
        builder = PacketBuilder()
        builder.write_string(item_code)
        self.send_packet(builder.build(BagCommandCode.PLAYER_ITEM_USED_NOTIFY))
    
    def _update_equipment_model(self, role_name: str, slot: int, model_code: str):
        """Atualiza o modelo de equipamento no banco de dados"""
        try:
            self.get_db().execute_proc('SP_UpdateEquipmentModel', {
                'RoleName': role_name,
                'Slot': slot,
                'ModelCode': model_code
            })
            self.log(f"💾 Modelo {model_code} salvo no slot {slot}")
        except Exception as e:
            self.log(f"❌ Erro ao salvar modelo: {e}")
    
    def _send_equipment_model_delayed(self, role_name: str, delay: float):
        """
        Envia RemoteEquipmentModelCheckNotify (cmd 865) com delay.
        Isso garante que o cmd 4609 seja processado primeiro pelo cliente.
        """
        import time
        current_time = time.time()
        self.log(f"⏱️ TIMER DEBUG: Agendando cmd 865 para {delay}s no futuro (timestamp={current_time:.3f})")
        timer = threading.Timer(delay, self._send_equipment_model_update, args=[role_name, current_time])
        timer.start()
    
    def _send_equipment_model_update(self, role_name: str, scheduled_time: float):
        """
        Envia RemoteEquipmentModelCheckNotify (cmd 865)
        Atualiza o modelo visual do personagem no cliente
        
        Formato: roleName:string, equipmentModels:map(byte,string)
        
        IMPORTANTE: O servidor envia TODOS os equipamentos (normais E fashion).
        O cliente decide qual renderizar baseado em seu próprio isUseFashion.
        """
        import time
        actual_time = time.time()
        elapsed = actual_time - scheduled_time
        self.log(f"⏱️ TIMER DEBUG: Executando cmd 865 após {elapsed:.3f}s (esperado: 0.5s)")
        
        builder = PacketBuilder()
        
        builder.write_string(role_name)
        self.log(f"📋 FASHION DEBUG: Enviando roleName='{role_name}'")
        
        equip_models = self.player_data.get('equipmentModels', {}) if self.player_data else {}
        
        self.log(f"📋 FASHION DEBUG: equipmentModels do player_data: {equip_models}")
        
        builder.write_varint(len(equip_models))
        self.log(f"📋 FASHION DEBUG: map size = {len(equip_models)}")
        
        for slot, model_code in equip_models.items():
            builder.write_byte(int(slot))
            builder.write_string(model_code or '')
            self.log(f"📋 FASHION DEBUG: slot {slot} (byte) -> model '{model_code}'")
        
        packet_data = builder.build(865)
        self.log(f"📋 FASHION DEBUG: Pacote cmd=865, tamanho={len(packet_data)}, hex={packet_data.hex()}")
        self.send_packet(packet_data)
        map_id = self.player_data.get('mapId') if self.player_data else None
        if map_id:
            self.server.broadcast_to_map(map_id, packet_data, exclude_session=self.session)
        self.log(f"✅ RemoteEquipmentModelCheckNotify enviado: {equip_models}")

    def handle_move_item(self, reader: PacketReader):
        """Mover item no inventário (cmd 5125)"""
        try:
            bag_index = reader.read_byte()
            from_slot = reader.read_varint()
            to_slot = reader.read_varint()
            
            self.log(f"MoveItem: bag={bag_index}, from={from_slot}, to={to_slot}")
            
            if not self.player_data:
                return
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            
            result = inv_mgr.move_item(self.role_name, bag_index, from_slot, to_slot)
            
            if result['success']:
                items = inv_mgr.load_inventory(self.role_name, bag_index)
                from_slot_occupied = any(item.slot_index == from_slot for item in items)
                empty_slots = [from_slot] if not from_slot_occupied else []
                self.session._send_bag_check(bag_index, items, empty_slots)
            else:
                self.log(f"❌ Erro ao mover item: {result['error']}")
                
        except Exception as e:
            self.log(f"Erro ao mover item: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_split_item(self, reader: PacketReader):
        try:
            bag_index = reader.read_byte()
            from_slot = reader.read_unsigned_byte()
            to_slot = reader.read_unsigned_byte()
            split_number = reader.read_unsigned_byte()
            result = self.get_db().split_inventory_item(self.role_name, bag_index, from_slot, to_slot, split_number)
            if result.get('Success'):
                from inventory_manager import InventoryManager
                items = InventoryManager(self.get_db()).load_inventory(self.role_name, bag_index)
                self.session._send_bag_check(bag_index, items)
            else:
                self.log(f"SplitItem rejeitado: {result.get('ErrorMsg')}")
        except Exception as e:
            self.log(f"Erro ao dividir item: {e}")

    def handle_move_item_cross_bag(self, reader: PacketReader):
        try:
            reader.read_string()
            menu_count = reader.read_varint()
            for _ in range(menu_count):
                reader.read_byte()
            from_bag = reader.read_byte()
            from_slot = reader.read_unsigned_byte()
            to_bag = reader.read_byte()
            to_slot = reader.read_unsigned_byte()
            result = self.get_db().move_inventory_item_cross_bag(self.role_name, from_bag, from_slot, to_bag, to_slot)
            if result.get('Success'):
                from inventory_manager import InventoryManager
                inv = InventoryManager(self.get_db())
                self.session._send_bag_check(from_bag, inv.load_inventory(self.role_name, from_bag))
                self.session._send_bag_check(to_bag, inv.load_inventory(self.role_name, to_bag))
            else:
                self.log(f"MoveCrossBag rejeitado: {result.get('ErrorMsg')}")
        except Exception as e:
            self.log(f"Erro ao mover entre bolsas: {e}")

    def handle_view_bag(self, reader: PacketReader):
        """PlayerViewBagRequest: bagIndex:byte."""
        try:
            bag_index = reader.read_byte()
            from inventory_manager import InventoryManager
            items = InventoryManager(self.get_db()).load_inventory(self.role_name, bag_index)
            self.session._send_bag_check(bag_index, items)
        except Exception as e:
            self.log(f"Erro ao visualizar bag: {e}")

    def handle_renew_item(self, reader: PacketReader):
        """PlayerRenewItemRequest: itemId:string, renewRuleIndex:byte."""
        try:
            item_id = reader.read_string()
            renew_rule_index = reader.read_byte()
            self.log(f"RenewItem: itemId={item_id}, rule={renew_rule_index}")
            result = self.get_db().renew_inventory_item(self.role_name, item_id, renew_rule_index)
            if not result.get("Success"):
                self.log(f"RenewItem rejeitado: {result.get('ErrorMsg')}")
                return
            self._send_view_item_by_id(item_id)
        except Exception as e:
            self.log(f"Erro ao renovar item: {e}")

    def handle_buy_and_use_item(self, reader: PacketReader):
        """PlayerBuyAndUseItemRequest: itemCode, targetPoint, targetObjectId, parameters."""
        try:
            item_code = reader.read_string()
            point_size = reader.read_unsigned_short() if reader.remaining() >= 2 else 0
            if point_size > 0:
                reader.skip(point_size)
            target_obj_id = reader.read_string() if reader.remaining() > 0 else ""
            parameters = {}
            if reader.remaining() > 0:
                try:
                    for _ in range(reader.read_varint()):
                        parameters[reader.read_string()] = reader.read_string()
                except Exception:
                    parameters = {}
            self.log(f"BuyAndUseItem: itemCode={item_code}, target={target_obj_id}, params={parameters}")
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            item_def = inv_mgr.get_item_definition(item_code)
            if not item_def:
                self.log(f"BuyAndUseItem rejeitado: definicao ausente para {item_code}")
                return
            item_type = int(item_def.get('ItemType', item_def.get('type', 0)) or 0)
            if item_type not in (1, 2):
                self.log(f"BuyAndUseItem rejeitado: item {item_code} tipo {item_type} nao e consumivel")
                return
            unit_price = int(item_def.get('BuyPrice') or item_def.get('goldPrice') or 0)
            result = self.get_db().purchase_items(
                self.role_name,
                [{"item_code": item_code, "count": 1, "unit_price": unit_price}],
                "Gold",
                1,
            )
            if not result.get("Success"):
                self.log(f"BuyAndUseItem compra falhou: {result.get('ErrorMsg')}")
                return
            added = (result.get("Added") or [{}])[0]
            slot_index = int(added.get("SlotIndex") if added.get("SlotIndex") is not None else -1)
            item_id = added.get("ItemId")
            items = inv_mgr.load_inventory(self.role_name, 1)
            item = next((i for i in items if (item_id and i.item_id == item_id) or i.slot_index == slot_index), None)
            if not item:
                self.log(f"BuyAndUseItem compra ok, mas item nao localizado no slot {slot_index}")
                return
            if self.player_data is not None:
                self.player_data['gold'] = result.get("NewCurrency", self.player_data.get('gold', 0))
            self._consume_item(self.role_name, item, item_def, 1, item.slot_index)
        except Exception as e:
            self.log(f"Erro ao comprar e usar item: {e}")

    def handle_pickup_item(self, reader: PacketReader):
        """Pegar item do chão (cmd 5123 - PLAYER_PICKUP_ITEM_REQUEST)
        
        Formato: itemId:string
        """
        try:
            item_id = reader.read_string()
            self.log(f"PickupItem: itemId={item_id}")
            
            if not self.player_data:
                return
            
            # Get the dropped item info from the database/map
            db = self.get_db()
            rows = db.execute_query(
                "SELECT * FROM TB_DroppedItems WHERE ItemId = ?",
                (item_id,)
            )
            
            if not rows:
                self.log(f"PickupItem: item {item_id} não encontrado no chão")
                return
            
            dropped_item = rows[0]
            item_code = dropped_item.get('ItemCode', '')
            item_count = dropped_item.get('ItemCount', 1)
            is_bound = bool(dropped_item.get('IsBound', False))
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(db)
            
            # Try to add to main bag (bag 1)
            result = inv_mgr.add_item(self.role_name, 1, item_code, item_count, is_bound)
            
            if result['success']:
                # Remove from dropped items
                db.execute_query("DELETE FROM TB_DroppedItems WHERE ItemId = ?", (item_id,))
                
                # Notify client
                self.session._send_bag_check(1, inv_mgr.load_inventory(self.role_name, 1))
                self._send_item_used_notify(1, result.get('slot_index', 0), item_code)
                
                self.log(f"✅ PickupItem: {item_code} x{item_count} adicionado ao inventário")
            else:
                self.log(f"❌ PickupItem falhou: {result.get('error', 'inventário cheio')}")
                
        except Exception as e:
            self.log(f"Erro ao pegar item: {e}")
            import traceback
            traceback.print_exc()

    def handle_drop_item(self, reader: PacketReader):
        """Dropar item (cmd 5127)"""
        try:
            bag_index = reader.read_byte()
            slot_index = reader.read_varint()
            drop_count = reader.read_varint()
            
            self.log(f"DropItem: bag={bag_index}, slot={slot_index}, count={drop_count}")
            
            if not self.player_data:
                return
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            
            result = inv_mgr.remove_item(self.role_name, bag_index, slot_index, drop_count)
            
            if result['success']:
                items = inv_mgr.load_inventory(self.role_name, bag_index)
                self.session._send_bag_check(bag_index, items)
            else:
                self.log(f"❌ Erro ao dropar: {result['error']}")
                
        except Exception as e:
            self.log(f"Erro ao dropar item: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_view_item(self, reader: PacketReader):
        """Ver detalhes de um item (cmd 5133)"""
        try:
            item_id = reader.read_string()
            self.log(f"ViewItem: itemId={item_id}")
            self._send_view_item_by_id(item_id)
        except Exception as e:
            self.log(f"Erro ao ver item: {e}")

    def _send_view_item_by_id(self, item_id: str):
            db = self.get_db()
            rows = db.execute_query(
                "SELECT * FROM TB_RoleInventory WHERE ItemId = ?",
                (item_id,)
            )
            if rows:
                row = rows[0]
                from inventory_manager import ItemInfo
                item = ItemInfo(
                    inventory_id=row.get('InventoryID', 0),
                    slot_index=row.get('SlotIndex', 0),
                    item_id=row.get('ItemId', ''),
                    item_code=row.get('ItemCode', ''),
                    item_count=row.get('ItemCount', 1),
                    is_bound=bool(row.get('IsBound', False)),
                    enhance_level=row.get('EnhanceLevel', 0),
                    durability=int(row.get('Durability') if row.get('Durability') is not None else 100),
                    max_durability=int(row.get('MaxDurability') if row.get('MaxDurability') is not None else 100),
                    renew_rule_index=int(row.get('RenewRuleIndex') if row.get('RenewRuleIndex') is not None else 0),
                    extra_data=row.get('ExtraData')
                )
                item_def_rows = db.execute_query(
                    "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                    (item.item_code,)
                )
                item_def = item_def_rows[0] if item_def_rows else None
                self.session._send_view_item_answer(item, item_id, item_def)
            else:
                self.log(f"⚠️ Item {item_id} não encontrado no DB para visualização")
                builder = PacketBuilder()
                builder.write_string(item_id)
                builder.write_unsigned_short(0)
                self.send_packet(builder.build(BagCommandCode.PLAYER_VIEW_ITEM_ANSWER))

    def handle_remove_equipment(self, reader: PacketReader):
        """
        Desequipar item (cmd 4610 - PLAYER_REMOVE_EQUIPMENT_REQUEST)
        
        Request: equipmentKind:byte, toBagItemIndex:byte
        
        equipmentKind = slot do equipamento (0=arma, 1=capacete, etc)
        toBagItemIndex = slot destino na bag principal (ou -1 para primeiro slot livre)
        """
        try:
            equipment_kind = reader.read_byte()
            to_bag_index = reader.read_byte()
            
            self.log(f"⚔️ RemoveEquipment: equipKind={equipment_kind}, toBag={to_bag_index}")
            
            if not self.player_data:
                self.log("❌ Jogador não logado")
                return
            
            self._handle_unequip_item(self.role_name, 10, equipment_kind)
            
        except Exception as e:
            self.log(f"Erro ao desequipar: {e}")
            import traceback
            traceback.print_exc()

    def handle_view_repair_info(self, reader: PacketReader):
        """PlayerViewRepairInfoRequest: equipmentId:string."""
        try:
            equipment_id = reader.read_string()
            builder = PacketBuilder()
            builder.write_string(equipment_id)
            info = self.get_db().get_equipment_repair_info(self.role_name, equipment_id)
            builder.write_bool(bool(info.get("IsWornOut", False)))
            builder.write_bool(bool(info.get("IsFullDurability", True)))
            builder.write_int(int(info.get("RepairGold", 0)))
            builder.write_int(int(info.get("PerfectRepairGold", 0)))
            self.send_packet(builder.build(EquipmentCommandCode.PLAYER_VIEW_REPAIR_INFO_ANSWER))
        except Exception as e:
            self.log(f"Erro ao ver reparo: {e}")

    def handle_repair_equipment(self, reader: PacketReader):
        """PlayerRepairEquipmentRequest: equipmentId:string, isPerfectRepair:boolean."""
        try:
            equipment_id = reader.read_string()
            is_perfect = reader.read_bool()
            self.log(f"RepairEquipment: equipmentId={equipment_id}, perfect={is_perfect}")
            result = self.get_db().repair_equipment(self.role_name, equipment_id, is_perfect)
            builder = PacketBuilder()
            builder.write_string(equipment_id)
            builder.write_bool(bool(result.get("Success")))
            self.send_packet(builder.build(EquipmentCommandCode.PLAYER_REPAIR_EQUIPMENT_ANSWER))
            if result.get("Success"):
                if self.player_data is not None:
                    self.player_data['gold'] = result.get("NewGold", self.player_data.get('gold', 0))
                self._send_equipment_durability({equipment_id: min(100, int(result.get("Durability", 100)))})
                from inventory_manager import InventoryManager
                items = InventoryManager(self.get_db()).load_inventory(self.role_name, 10)
                self.session._send_equipment_check_notify(items)
            else:
                self.log(f"RepairEquipment falhou: {result.get('ErrorMsg')}")
        except Exception as e:
            self.log(f"Erro ao reparar equipamento: {e}")

    def _send_equipment_durability(self, dur_map):
        builder = PacketBuilder()
        builder.write_varint(len(dur_map))
        for equipment_id, durability in dur_map.items():
            builder.write_string(equipment_id)
            builder.write_byte(int(durability))
        self.send_packet(builder.build(EquipmentCommandCode.PLAYER_EQUIP_DUR_CHECK_NOTIFY))
    
    def handle_switch_fashion(self, reader: PacketReader):
        """
        Alterna entre mostrar fashion ou armadura normal (cmd 4611)
        
        PlayerSwitchFashionRequest: isUseFashion:boolean
        PlayerSwitchFashionNotify: isUseFashion:boolean
        """
        try:
            is_use_fashion = reader.read_bool()
            
            self.log(f"🎨 SwitchFashion: isUseFashion={is_use_fashion}")
            
            if self.player_data:
                self.player_data['isUseFashion'] = is_use_fashion
                role_id = self.player_data.get('roleId')
                if role_id:
                    db = self.get_db()
                    db.execute_query(
                        "UPDATE TB_Role SET IsUseFashion = ? WHERE RoleID = ?",
                        (1 if is_use_fashion else 0, role_id)
                    )
                    self.log(f"💾 IsUseFashion salvo no DB: {is_use_fashion}")
            
            builder = PacketBuilder()
            builder.write_bool(is_use_fashion)
            self.send_packet(builder.build(4612))
            
            self.log(f"✅ PlayerSwitchFashionNotify enviado: {is_use_fashion}")
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            role_name = self.role_name
            
            equip_items = inv_mgr.load_inventory(role_name, 10)
            if equip_items:
                for equip_item in equip_items:
                    equip_item_def_result = self.get_db().execute_query(
                        "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                        (equip_item.item_code,)
                    )
                    equip_item_def = equip_item_def_result[0] if equip_item_def_result else None
                    self.session._send_view_item_answer(equip_item, equip_item.item_id, equip_item_def)
                
                self.session._send_equipment_check_notify(equip_items)
                self.log(f"🔄 Equipamentos reenviados para atualizar visual fashion")
            
        except Exception as e:
            self.log(f"Erro ao alternar fashion: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_bag_sort(self, reader: PacketReader):
        """
        Organizar itens da mochila (cmd 5141 - PLAYER_BAG_SORT_REQUEST)
        
        Formato: bagIndex:byte
        
        Ordem de prioridade (por tipo):
        1. EXPENDABLE (1) - consumíveis/poções
        2. COLLECTION (2) - materiais/baús
        3. EQUIPMENT (4) - equipamentos
        4. PET (8)
        5. RIDE (16) - montarias
        6. SKILL (1048576)
        7. Outros
        
        Dentro do mesmo tipo: ordenar por itemCode
        """
        try:
            raw_data = reader.data[reader.pos:]
            self.log(f"📦 BagSort raw ({len(raw_data)} bytes): {raw_data.hex()}")
            
            bag_index = reader.read_byte() if reader.remaining() >= 1 else 1
            self.log(f"🗂️ BagSort: bagIndex={bag_index}")
            
            if not self.player_data:
                self.log("❌ Jogador não logado")
                return
            
            role_name = self.role_name
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            
            items = inv_mgr.load_inventory(role_name, bag_index)
            
            if not items:
                self.log("  Bag vazia, nada a ordenar")
                return
            
            self.log(f"  📋 {len(items)} itens antes da ordenação")
            
            type_priority = {
                1: 0,
                2: 1,
                4: 2,
                8: 3,
                16: 4,
                32: 5,
                128: 6,
                1048576: 7,
                2097152: 8,
            }
            
            items_with_type = []
            for item in items:
                item_code = item.item_code
                item_def = inv_mgr.get_item_definition(item_code)
                item_type = item_def.get('ItemType', 99) if item_def else 99
                
                items_with_type.append({
                    'item': item,
                    'type': item_type,
                    'type_priority': type_priority.get(item_type, 99),
                    'code': item_code
                })
            
            items_with_type.sort(key=lambda x: (x['type_priority'], x['code']))
            
            db = self.get_db()
            if not db:
                self.log("❌ DB não disponível")
                return
            
            for new_slot, item_data in enumerate(items_with_type):
                item = item_data['item']
                old_slot = item.slot_index
                
                if old_slot != new_slot:
                    self.log(f"    {item.item_code}: slot {old_slot} -> {new_slot} (invId={item.inventory_id})")
                    
                    sql = "UPDATE TB_RoleInventory SET SlotIndex = ? WHERE InventoryID = ?"
                    db.execute_query(sql, (new_slot, item.inventory_id))
            
            self.log(f"  ✅ Itens reorganizados")
            
            old_slots = set(item_data['item'].slot_index for item_data in items_with_type)
            new_slots = set(range(len(items_with_type)))
            empty_slots = list(old_slots - new_slots)
            
            items_updated = inv_mgr.load_inventory(role_name, bag_index)
            self.session._send_bag_check(bag_index, items_updated, empty_slots)
            self.log(f"  📤 Bag enviada: {len(items_updated)} itens, {len(empty_slots)} slots vazios")
            
        except Exception as e:
            self.log(f"Erro ao ordenar bag: {e}")
            import traceback
            traceback.print_exc()
