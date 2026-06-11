import math
import random
import time
from typing import Dict
from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import PlayerCommandCode
from gameplay.combat_rules import STATUS_CANNOT_USE_SKILL, area_rule, buff_modifier, cast_rule, distance_to, effective_attribute, has_status, resolve_effects, resolve_target_effects, roll_hit_critical

class CombatHandler(BaseHandler):
    FALLBACK_BASIC_ATTACK_CODES = frozenset(('za0', 'basic', 'hg1', 'xj1', 'xj2', 'xj3', 'xj4', 'xj5', 'xj6', 'xj7'))
    PLAYER_USE_SKILL_REQ = 545
    MONSTER_HP_CHANGE_NOTIFY = 1286
    MONSTER_DIED_NOTIFY = 1282
    PLAYER_HP_CHANGE_NOTIFY = 550

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_USE_SKILL_REQ: 'handle_use_skill',
            PlayerCommandCode.PLAYER_CANCEL_SKILL_REQ: 'handle_cancel_skill',
        }

    def handle_use_skill(self, reader: PacketReader):
        try:
            map_id = reader.read_string()
            skill_sn = reader.read_unsigned_short()
            skill_code = reader.read_string()
            target_id = reader.read_string()
            
            # Read target point (MapPoint: prefixed with ushort length)
            has_point = reader.read_unsigned_short() > 0
            target_x = 0
            target_y = 0
            if has_point:
                target_x = reader.read_short()
                target_y = reader.read_short()
                
            # Read wrapped bytes (byteArray: prefixed with varint length)
            has_bytes = reader.read_varint()
            wrapped_bytes = b''
            if has_bytes > 0:
                wrapped_bytes = reader.read_bytes() # reads remaining or size-based
                
            self.log(f"UseSkill: skill={skill_code}, target={target_id}, pos=({target_x}, {target_y})")
            
            if not self.player_data:
                return
            if self.player_data.get('isDead'):
                return
            if has_status(self.player_data, STATUS_CANNOT_USE_SKILL):
                self._interrupt_skill(skill_sn, True)
                return
            if map_id != self.player_data.get('mapId'):
                self._interrupt_skill(skill_sn, True)
                return
            self.server.set_combat_status(self.session, True)
            now = self.server.combat_scheduler.now()
            cooldowns = self.player_data.setdefault('skillCooldowns', {})
            special_skill = bool(skill_code and not self._is_basic_attack(skill_code))
            skill_config = self.server.resource_index.skill(skill_code) or {}
            skill_level = int(self.player_data.get('learnedSkills', {}).get(skill_code, 0))
            if special_skill and (not skill_config or skill_level <= 0):
                self._interrupt_skill(skill_sn, True)
                return
            configured_cast = cast_rule(skill_config, max(1, skill_level))
            map_instance = self.server.map_manager.get_map(map_id)
            early_target = map_instance.monsters.get(target_id) if map_instance else None
            target_session = self.server.sessions.get(target_id)
            if target_session and target_session.player_data and target_session.player_data.get('mapId') != map_id:
                target_session = None
            if not early_target and not target_session and int(skill_config.get('target', 0) or 0) != 256:
                self._interrupt_skill(skill_sn, True)
                return
            target_pos = (
                (early_target.x, early_target.y) if early_target
                else (target_session.player_data.get('posX', 0), target_session.player_data.get('posY', 0)) if target_session
                else (self.player_data.get('posX', 0), self.player_data.get('posY', 0))
            )
            range_padding = 120 if not special_skill else 40
            default_range = 280 if not special_skill else 150
            allowed_range = float(configured_cast.get('range', default_range) or default_range) + range_padding
            if distance_to(self.player_data, *target_pos) > allowed_range:
                self._interrupt_skill(skill_sn, True)
                return
            # Basic attacks are paced by their short attack interval. Skills keep
            # their configured cooldown and the shared global skill lock.
            cooldown_ms = int(
                configured_cast.get('coldTime', 3000)
                if special_skill
                else self._basic_attack_interval_ms(configured_cast)
            )
            if special_skill:
                effective_cast_ms = self._effective_cast_time_ms(configured_cast)
                effective_sing_ms = self._effective_sing_time_ms(configured_cast)
                cooldown_ms += effective_cast_ms + effective_sing_ms
            global_cooldown_seconds = 0.15 if special_skill else 0
            cd_group = skill_config.get('cdFlag')
            if not self.server.combat_scheduler.is_ready(self.role_name, skill_code, cd_group):
                self._interrupt_skill(skill_sn, True)
                return
            raw_cost = configured_cast.get('castCost', 0)
            costs = dict(raw_cost) if isinstance(raw_cost, dict) else {'mp': raw_cost}
            if not costs.get('mp') and special_skill:
                costs['mp'] = max(1, int(self.player_data.get('level', 1) * 0.5))
            normalized_costs = {key.lower(): max(0, int(value or 0)) for key, value in costs.items() if key.lower() in {'hp', 'mp', 'sp'}}
            if any(int(self.player_data.get(key, 0)) < amount for key, amount in normalized_costs.items()):
                self._interrupt_skill(skill_sn, True)
                return
            cooldowns[skill_code] = now + cooldown_ms / 1000.0
            self.server.combat_scheduler.start_cooldowns(
                self.role_name,
                skill_code,
                cooldown_ms / 1000.0,
                cd_group,
                cooldown_ms / 1000.0 if cd_group else 0,
                global_cooldown_seconds,
            )
            cost_at_key_time = self._truthy_skill_value(skill_config, configured_cast, 'costAtKeyTime')
            if not cost_at_key_time and not self._apply_skill_cost(normalized_costs, skill_code):
                self._interrupt_skill(skill_sn, True)
                return
            macro = skill_config.get('doMacro') or skill_config.get('onUse') or skill_config.get('useMacro')
            scripts = skill_config.get('execScripts')
            if macro or scripts:
                from gameplay.macro_engine import MacroContext
                context = MacroContext(server=self.server, session=self.session, source=self.session)
                if macro:
                    self.server.macro_engine.execute(macro, context)
                if scripts:
                    self.server.macro_engine.execute_scripts(scripts, context)
            self_effects = resolve_effects(skill_config, self.player_data, "toSelf")
            if self_effects["healing"]:
                from gameplay.macro_engine import MacroContext
                self.server.macro_engine._add_hp(
                    self_effects["healing"], MacroContext(server=self.server, session=self.session), 0, {"remaining": 1}
                )
            if self_effects.get("mpRestore"):
                self._restore_mp(self.session, self_effects["mpRestore"], skill_code)
            for buff_id in self_effects["buffs"]:
                self.server.apply_buff(self.session, buff_id, 10)

            remote_skill = PacketBuilder()
            remote_skill.write_string(map_id)
            remote_skill.write_string(self.role_name)
            remote_skill.write_unsigned_short(skill_sn)
            remote_skill.write_string(skill_code)
            remote_skill.write_byte(1)
            remote_skill.write_string(target_id)
            if has_point:
                from handlers.movement_handler import write_map_point
                write_map_point(remote_skill, target_x, target_y)
            else:
                remote_skill.write_unsigned_short(0)
            remote_skill.write_unsigned_short(0)
            remote_skill.write_unsigned_short(0)
            self.server.broadcast_to_map(map_id, remote_skill.build(801), exclude_session=self.session)

            cast_delay = (int(configured_cast.get('singTime', 0) or 0) + int(configured_cast.get('castTime', 0) or 0)) / 1000.0
            key_time_delays = self._skill_key_time_delays(skill_config, configured_cast)
            scheduled_delays = key_time_delays or ([cast_delay] if cast_delay > 0 else [])
            if scheduled_delays:
                payload = {
                    "map_id": map_id,
                    "skill_config": skill_config,
                    "skill_level": max(1, skill_level),
                    "skill_code": skill_code,
                    "target_id": target_id,
                    "skill_sn": skill_sn,
                    "cancelled": False,
                    "requires_cost": bool(cost_at_key_time and normalized_costs),
                    "cost_paid": not bool(cost_at_key_time and normalized_costs),
                    "costs": normalized_costs,
                    "target_x": target_x,
                    "target_y": target_y,
                    "has_point": has_point,
                }
                if cost_at_key_time and normalized_costs:
                    self.server.combat_scheduler.schedule_skill_cost(
                        self.role_name,
                        skill_sn,
                        min(scheduled_delays),
                        lambda event: self._resolve_scheduled_cost(event.payload),
                        payload,
                    )
                if key_time_delays:
                    self.server.combat_scheduler.schedule_key_times(
                        self.role_name,
                        skill_sn,
                        scheduled_delays,
                        lambda event: self._resolve_scheduled_impact(event.payload),
                        payload,
                    )
                else:
                    self.server.combat_scheduler.schedule_cast(
                        self.role_name,
                        skill_sn,
                        scheduled_delays[0],
                        lambda event: self._resolve_scheduled_impact(event.payload),
                        payload,
                    )
                return

            if cost_at_key_time and not self._apply_skill_cost(normalized_costs, skill_code):
                self._interrupt_skill(skill_sn, True)
                return

            if target_session:
                self._resolve_player_target(skill_config, max(1, skill_level), target_session, skill_code)
                return
            if not early_target and int(skill_config.get('target', 0) or 0) == 256:
                self._resolve_ground_target(skill_config, max(1, skill_level), skill_code, map_id, target_x, target_y)
                return
                
            # Resolve target in map manager
            map_instance = self.server.map_manager.get_map(map_id)
            if not map_instance:
                self.log(f"❌ Map instance {map_id} not found")
                return
                
            monster = map_instance.monsters.get(target_id)
            if not monster or monster.is_dead:
                self.log(f"❌ Target monster {target_id} not found or is dead")
                return

            # Send configured cooldown visual for special skills.
            if special_skill:
                
                # Cooldown visual notify
                from servers.world_server import write_transportable_object
                cd_notify = PacketBuilder()
                cd_notify.write_varint(1) # array of length 1
                
                # CDItemInfo: code:string, cdTimeLeftInMS:int
                def write_cd_item(b):
                    b.write_string(skill_code)
                    b.write_int(cooldown_ms)
                
                write_transportable_object(cd_notify, write_cd_item)
                self.send_packet(cd_notify.build(569))

            self._resolve_monster_targets(map_instance, monster, skill_config, max(1, skill_level), skill_code, map_id)
            if not monster.is_dead:
                monster.aggro_target = self.role_name
            return

            # Check if monster dies
            if monster.hp <= 0:
                monster.is_dead = True
                monster.death_time = time.time()
                self.log(f"💀 Monster {target_id} died!")
                
                # Send MONSTER_DIED_NOTIFY (cmd 1282)
                died_notify = PacketBuilder()
                died_notify.write_string(target_id)
                self.server.broadcast_to_map(map_id, died_notify.build(self.MONSTER_DIED_NOTIFY))
                
                # Award Experience
                exp_gained = int(monster.mob_def.get('exp', 50))
                self._add_role_exp(exp_gained)
                
                # Award Gold
                gold_gained = int(monster.mob_def.get('gold', 10))
                if gold_gained:
                    current_gold = float(self.player_data.get('gold', 0))
                    new_gold = current_gold + gold_gained
                    self.player_data['gold'] = new_gold
                    self.get_db().execute_non_query(
                        "UPDATE TB_Role SET Gold=? WHERE Name=?",
                        (int(new_gold), self.role_name)
                    )
                    self.session._send_gold_change(gold_gained)
                
                # Trigger drops
                self._process_monster_drop(monster, map_id)
                
            # Make the monster retaliate (aggro target set to this player)
            if not monster.is_dead:
                monster.aggro_target = self.role_name

        except Exception as e:
            self.log(f"Erro ao processar use skill: {e}")
            import traceback
            traceback.print_exc()

    def _skill_value(self, skill_config, configured_cast, key):
        if isinstance(configured_cast, dict) and configured_cast.get(key) is not None:
            return configured_cast.get(key)
        if isinstance(skill_config, dict):
            return skill_config.get(key)
        return None

    def _basic_attack_interval_ms(self, configured_cast):
        base_cast_ms = max(1, int(configured_cast.get('castTime', 900) or 900))
        modifier = max(0.01, float(self.player_data.get('castTimeModifier', 1.0) or 1.0))
        speed_bonus = float(buff_modifier(self.player_data, 300) or 0.0)
        if abs(speed_bonus) > 1.0:
            speed_bonus /= 100.0
        attack_speed = max(0.2, (1.0 / modifier) + speed_bonus)
        modifier = max(0.2, 1.0 / attack_speed)
        return max(100, int(round(base_cast_ms * modifier)))

    def _is_basic_attack(self, skill_code):
        if hasattr(self.server.resource_index, 'is_basic_attack'):
            return self.server.resource_index.is_basic_attack(skill_code)
        return str(skill_code) in self.FALLBACK_BASIC_ATTACK_CODES

    def _effective_cast_time_ms(self, configured_cast):
        cast_ms = max(0, int(configured_cast.get('castTime', 0) or 0))
        if self._truthy_skill_value({}, configured_cast, 'castTimeFixed'):
            return cast_ms
        return int(round(cast_ms * max(0.2, float(self.player_data.get('castTimeModifier', 1.0) or 1.0))))

    def _effective_sing_time_ms(self, configured_cast):
        sing_ms = max(0, int(configured_cast.get('singTime', 0) or 0) - int(self.player_data.get('singTimeReduceMS', 0) or 0))
        if self._truthy_skill_value({}, configured_cast, 'singTimeFixed'):
            return sing_ms
        return int(round(sing_ms * max(0.2, float(self.player_data.get('singTimeModifier', 1.0) or 1.0))))

    def _truthy_skill_value(self, skill_config, configured_cast, key):
        value = self._skill_value(skill_config, configured_cast, key)
        if isinstance(value, str):
            return value.strip().lower() not in {"", "0", "false", "no", "none", "null"}
        return bool(value)

    def _extract_key_time_ms(self, value):
        if value is None:
            return []
        if isinstance(value, (int, float)):
            return [int(value)]
        if isinstance(value, str):
            parts = value.replace(";", ",").split(",")
            result = []
            for part in parts:
                part = part.strip()
                if not part:
                    continue
                try:
                    result.append(int(float(part)))
                except ValueError:
                    continue
            return result
        if isinstance(value, dict):
            for key in ("time", "keyTime", "key_time", "ms", "value"):
                if key in value:
                    return self._extract_key_time_ms(value.get(key))
            result = []
            for nested in value.values():
                result.extend(self._extract_key_time_ms(nested))
            return result
        if isinstance(value, (list, tuple, set)):
            result = []
            for nested in value:
                result.extend(self._extract_key_time_ms(nested))
            return result
        return []

    def _skill_key_time_delays(self, skill_config, configured_cast):
        sing_time_ms = max(0, int(configured_cast.get('singTime', 0) or 0))
        sing_keys = self._extract_key_time_ms(self._skill_value(skill_config, configured_cast, 'singKeyTimes'))
        cast_keys = self._extract_key_time_ms(self._skill_value(skill_config, configured_cast, 'castKeyTimes'))
        key_times_ms = [time_ms for time_ms in sing_keys if time_ms >= 0]
        key_times_ms.extend(sing_time_ms + time_ms for time_ms in cast_keys if time_ms >= 0)
        return [time_ms / 1000.0 for time_ms in sorted(set(key_times_ms))]

    def _apply_skill_cost(self, costs, skill_code):
        if not costs:
            return True
        normalized_costs = {
            key: max(0, int(value or 0))
            for key, value in costs.items()
            if key in {'hp', 'mp', 'sp'}
        }
        if any(int(self.player_data.get(key, 0)) < amount for key, amount in normalized_costs.items()):
            return False
        mp_cost = normalized_costs.get('mp', 0)
        if mp_cost:
            self.player_data['mp'] = int(self.player_data.get('mp', 0)) - mp_cost
            mp_notify = PacketBuilder()
            mp_notify.write_short(-mp_cost)
            mp_notify.write_int(int(self.player_data['mp']))
            mp_notify.write_string(skill_code)
            self.send_packet(mp_notify.build(PlayerCommandCode.PLAYER_MP_CHANGE_NOTIFY))
            self.server.broadcast_remote_mp(self.session, -mp_cost, skill_code)
        for vital in ('hp', 'sp'):
            amount = normalized_costs.get(vital, 0)
            if amount:
                self.player_data[vital] = int(self.player_data.get(vital, 0)) - amount
        return True

    def _resolve_scheduled_cost(self, payload):
        if payload.get("cancelled"):
            return
        skill_sn = payload.get("skill_sn")
        if not self.player_data or self.player_data.get('isDead') or self.player_data.get('mapId') != payload["map_id"]:
            payload["cancelled"] = True
            self.server.combat_scheduler.cancel(self.role_name, skill_sn)
            return
        if not self._apply_skill_cost(payload.get("costs") or {}, payload["skill_code"]):
            payload["cancelled"] = True
            self.server.combat_scheduler.cancel(self.role_name, skill_sn)
            self._interrupt_skill(skill_sn, True)
            return
        payload["cost_paid"] = True

    def _resolve_scheduled_impact(self, payload):
        if payload.get("cancelled") or (payload.get("requires_cost") and not payload.get("cost_paid")):
            return
        if not self.player_data or self.player_data.get('isDead'):
            return
        if self.player_data.get('mapId') != payload["map_id"]:
            return
        target_session = self.server.sessions.get(payload["target_id"])
        if target_session and target_session.player_data:
            self._resolve_player_target(payload["skill_config"], payload["skill_level"], target_session, payload["skill_code"])
            return
        if int(payload["skill_config"].get('target', 0) or 0) == 256:
            self._resolve_ground_target(
                payload["skill_config"],
                payload["skill_level"],
                payload["skill_code"],
                payload["map_id"],
                payload.get("target_x", 0),
                payload.get("target_y", 0),
            )
            return
        map_instance = self.server.map_manager.get_map(payload["map_id"])
        if not map_instance:
            return
        monster = map_instance.monsters.get(payload["target_id"])
        if not monster or monster.is_dead:
            return
        if distance_to(self.player_data, monster.x, monster.y) > float(cast_rule(payload["skill_config"], payload["skill_level"]).get('range', 150) or 150) + 80:
            return
        self._resolve_monster_targets(map_instance, monster, payload["skill_config"], payload["skill_level"], payload["skill_code"], payload["map_id"])

    def _resolve_monster_targets(self, map_instance, monster, skill_config, skill_level, skill_code, map_id):
        radius, target_number = area_rule(skill_config, skill_level)
        targets = [monster]
        if radius > 0 and target_number > 1:
            candidates = [
                other for other in map_instance.get_active_monsters()
                if other is not monster and ((other.x - monster.x) ** 2 + (other.y - monster.y) ** 2) <= radius ** 2
            ]
            targets.extend(candidates[:max(0, target_number - 1)])
        killed = []
        for affected in targets:
            target_data = {**affected.mob_def, "hp": affected.hp, "hpMax": affected.hp_max}
            resolved = resolve_target_effects(skill_config, self.player_data, 0, skill_level, target_data=target_data)
            hit, critical = self._roll_hit_critical(affected.mob_def, resolved)
            damage = (resolved['damage'] or self._basic_monster_damage(affected)) if hit else 0
            if hit and resolved.get("instantDeath"):
                damage = max(float(damage), float(affected.hp))
            self.server.trigger_monster_buffs(affected, 'under_attack', self.session)
            for buff_id in resolved['buffs']:
                affected.apply_buff(buff_id, self.server.resource_index.buff(buff_id))
            affected.hp = max(0, affected.hp - int(damage))
            self._apply_monster_threat(affected, resolved, damage)
            self._apply_monster_displacement(map_instance, affected, resolved, map_id)
            hp_notify = PacketBuilder()
            hp_notify.write_string(affected.instance_id)
            hp_notify.write_double(-float(damage))
            hp_notify.write_byte(affected.get_hp_percent())
            hp_notify.write_string(skill_code)
            hp_notify.write_bool(critical)
            self.server.broadcast_to_map(map_id, hp_notify.build(self.MONSTER_HP_CHANGE_NOTIFY))
            from gameplay.macro_engine import MacroContext
            for macro in resolved['macros'] + resolved['targetMacros']:
                self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, monster=affected))
            if resolved['traps']:
                map_instance.release_from_macro({"trapCode": resolved['traps']}, self.role_name, affected.x, affected.y, server=self.server)
            if resolved.get('sysTraps'):
                map_instance.release_from_macro({"releaseSysTrap": resolved['sysTraps']}, self.role_name, affected.x, affected.y, server=self.server)
            for macro in resolved['selfMacros']:
                self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, target_session=self.session))
            if damage and resolved['lifestealRate']:
                self.server.macro_engine._add_hp(int(damage * resolved['lifestealRate']), MacroContext(server=self.server, session=self.session), 0, {"remaining": 1})
            if affected.hp <= 0 and not affected.is_dead:
                affected.is_dead = True
                affected.death_time = time.time()
                died_notify = PacketBuilder()
                died_notify.write_string(affected.instance_id)
                self.server.broadcast_to_map(map_id, died_notify.build(self.MONSTER_DIED_NOTIFY))
                killed.append(affected)
        for affected in [target for target in killed if target is not monster]:
            self._award_monster_kill(affected, map_id)
        if monster in killed:
            self._award_monster_kill(monster, map_id)
        self.server.trigger_buffs(self.session, "attack")

    def _basic_monster_damage(self, monster):
        """Fallback damage for legacy basic attacks when no skill data is loaded."""
        attacker_attack = effective_attribute(self.player_data, "physicalAttack", self.player_data.get("attack", 10))
        monster_defense = effective_attribute(monster.mob_def, "physicalDefense", monster.mob_def.get("defense", 0))
        damage = int(max(1.0, float(attacker_attack) - float(monster_defense)))
        return damage

    def handle_cancel_skill(self, reader: PacketReader):
        try:
            skill_sn = reader.read_unsigned_short()
            self.server.combat_scheduler.cancel(self.role_name, skill_sn)
            local = PacketBuilder()
            local.write_unsigned_short(skill_sn)
            local.write_bool(True)
            self.send_packet(local.build(PlayerCommandCode.PLAYER_SKILL_INTERRUPTED_NOTIFY))
            remote = PacketBuilder()
            remote.write_string(self.role_name)
            remote.write_unsigned_short(skill_sn)
            self.server.broadcast_to_map(self.player_data.get('mapId'), remote.build(803), exclude_session=self.session)
        except Exception as e:
            self.log(f"Erro ao cancelar skill: {e}")

    def _same_team(self, other_session):
        mine = self.player_data.get('teamName')
        return bool(mine and mine == other_session.player_data.get('teamName'))

    def _award_monster_kill(self, monster, map_id):
        killed = self.player_data.setdefault('killedMonsters', {'bool': {}, 'int': {}, 'str': {}})
        killed.setdefault('bool', {})
        killed.setdefault('int', {})
        killed.setdefault('str', {})
        monster_code = str(monster.mob_def.get('code') or monster.mob_def.get('id') or monster.instance_id)
        killed['int'][monster_code] = int(killed['int'].get(monster_code, 0)) + 1
        self._send_killed_monster_change(monster_code, killed['int'][monster_code])
        self._add_role_exp(int(monster.mob_def.get('exp', 50)))
        gold = int(monster.mob_def.get('gold', 10))
        if gold:
            self.player_data['gold'] = float(self.player_data.get('gold', 0)) + gold
            self.get_db().execute_non_query("UPDATE TB_Role SET Gold=? WHERE Name=?", (int(self.player_data['gold']), self.role_name))
            self.session._send_gold_change(gold)
        self._process_monster_drop(monster, map_id)

    def _send_killed_monster_change(self, monster_code: str, count: int):
        notify = PacketBuilder()
        notify.write_varint(1)
        notify.write_string(str(monster_code))
        notify.write_int(int(count))
        self.send_packet(notify.build(611))
        self.log(f"Kill progress enviado: {monster_code}={count}")

    def _resolve_player_target(self, skill_config, skill_level, target, skill_code):
        self.log(f"[DEBUG PVP] _resolve_player_target iniciada. Atacante: {self.role_name}, Alvo: {target.role_name}, Habilidade: {skill_code}")
        target_mask = int(skill_config.get('target', 0) or 0)
        hostile = bool(target_mask & 16)
        self.log(f"[DEBUG PVP] target_mask={target_mask}, hostile={hostile}")
        if hostile and (target is self.session or self._same_team(target)):
            self.log(f"[DEBUG PVP] Abortado: target is self ou mesmo time.")
            return
        resolved = resolve_target_effects(
            skill_config, self.player_data, 0, skill_level, target_data=target.player_data
        )
        self.log(f"[DEBUG PVP] resolved={resolved}")
        if resolved['healing']:
            old = float(target.player_data.get('hp', 0))
            maximum = float(target.player_data.get('hpMax', old))
            target.player_data['hp'] = min(maximum, old + resolved['healing'])
            changed = target.player_data['hp'] - old
            if changed:
                local = PacketBuilder()
                local.write_double(float(changed))
                local.write_double(float(target.player_data['hp']))
                local.write_string(skill_code)
                local.write_bool(False)
                local.write_bool(False)
                target.send_packet(local.build(PlayerCommandCode.PLAYER_HP_CHANGE_NOTIFY))
                self.server.broadcast_remote_hp(target, changed, skill_code)
        if hostile and resolved['damage']:
            hit, critical = self._roll_hit_critical(target.player_data, resolved)
            self.log(f"[DEBUG PVP] Hostile detection: hit={hit}, critical={critical}, damage_base={resolved['damage']}")
            if hit:
                old = float(target.player_data.get('hp', 0))
                damage = max(float(resolved['damage']), old) if resolved.get("instantDeath") else float(resolved['damage'])
                target.player_data['hp'] = max(0, old - damage)
                changed = target.player_data['hp'] - old
                self.log(f"[DEBUG PVP] Dano aplicado: {damage}, HP anterior: {old}, HP novo: {target.player_data['hp']}")
                local = PacketBuilder()
                local.write_double(float(changed))
                local.write_double(float(target.player_data['hp']))
                local.write_string(skill_code)
                local.write_bool(critical)
                local.write_bool(False)
                target.send_packet(local.build(PlayerCommandCode.PLAYER_HP_CHANGE_NOTIFY))
                self.server.broadcast_remote_hp(target, changed, skill_code, critical)
                self.server.trigger_buffs(target, 'under_attack', self.session)
                if target.player_data['hp'] <= 0 and not target.player_data.get('isDead'):
                    self.server.notify_player_died(target)
        for buff_id in resolved['buffs']:
            self.server.apply_buff(target, buff_id, 10)
        if resolved.get('mpRestore'):
            self._restore_mp(target, resolved['mpRestore'], skill_code)
        from gameplay.macro_engine import MacroContext
        for macro in resolved['macros']:
            self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, target_session=target))
        for macro in resolved['targetMacros']:
            self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, target_session=target))
        for macro in resolved['selfMacros']:
            self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, target_session=self.session))
        if resolved['damage'] and resolved['lifestealRate']:
            self.server.macro_engine._add_hp(int(resolved['damage'] * resolved['lifestealRate']), MacroContext(server=self.server, session=self.session), 0, {"remaining": 1})
        self.server.trigger_buffs(self.session, 'attack', target)

    def _resolve_ground_target(self, skill_config, skill_level, skill_code, map_id, target_x, target_y):
        map_instance = self.server.map_manager.get_map(map_id)
        if not map_instance:
            return
        resolved = resolve_effects(skill_config, self.player_data, "toGround", 0, skill_level)
        x = int(target_x or self.player_data.get("posX", 0))
        y = int(target_y or self.player_data.get("posY", 0))
        if resolved.get("traps"):
            map_instance.release_from_macro({"trapCode": resolved["traps"]}, self.role_name, x, y, server=self.server)
        if resolved.get("sysTraps"):
            map_instance.release_from_macro({"releaseSysTrap": resolved["sysTraps"]}, self.role_name, x, y, server=self.server)
        from gameplay.macro_engine import MacroContext
        for macro in resolved["macros"] + resolved["targetMacros"]:
            self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session))
        for macro in resolved["selfMacros"]:
            self.server.macro_engine.execute(macro, MacroContext(server=self.server, session=self.session, target_session=self.session))

    def _roll_hit_critical(self, defender, resolved):
        fixed_hit_rate = resolved.get("fixedHitRate")
        if fixed_hit_rate is None:
            return roll_hit_critical(self.player_data, defender)
        hit = random.random() <= max(0.0, min(1.0, float(fixed_hit_rate)))
        if not hit:
            return False, False
        _, critical = roll_hit_critical(self.player_data, defender)
        return True, critical

    def _restore_mp(self, session, amount, skill_code):
        amount = max(0, int(amount or 0))
        if not amount or not session or not session.player_data:
            return
        old = int(session.player_data.get('mp', 0))
        maximum = int(session.player_data.get('mpMax', old + amount))
        session.player_data['mp'] = min(maximum, old + amount)
        changed = int(session.player_data['mp']) - old
        if not changed:
            return
        notify = PacketBuilder()
        notify.write_short(changed)
        notify.write_int(int(session.player_data['mp']))
        notify.write_string(skill_code)
        session.send_packet(notify.build(PlayerCommandCode.PLAYER_MP_CHANGE_NOTIFY))
        self.server.broadcast_remote_mp(session, changed, skill_code)

    def _apply_monster_threat(self, monster, resolved, damage):
        threat = resolved.get("threat") or {}
        threat_value = int(threat.get("value") or 0)
        if damage > 0 or threat_value > 0:
            monster.aggro_target = self.role_name
            monster.threat = getattr(monster, "threat", {})
            monster.threat[self.role_name] = monster.threat.get(self.role_name, 0) + max(1, int(damage) + threat_value)

    def _apply_monster_displacement(self, map_instance, monster, resolved, map_id):
        pixel = int(resolved.get("displacePixel") or resolved.get("keepSpace") or 0)
        if not pixel:
            return
        chance = resolved.get("displaceChance") or 1.0
        if random.random() > max(0.0, min(1.0, float(chance))):
            return
        source_x = float(self.player_data.get("posX", monster.x))
        source_y = float(self.player_data.get("posY", monster.y))
        dx = float(monster.x) - source_x
        dy = float(monster.y) - source_y
        length = math.hypot(dx, dy) or 1.0
        dest_x = int(monster.x + (dx / length) * pixel)
        dest_y = int(monster.y + (dy / length) * pixel)
        monster.x, monster.y = dest_x, dest_y
        move = PacketBuilder()
        move.write_string(map_id)
        move.write_string(monster.instance_id)
        move.write_string(monster.code)
        move.write_varint(1)
        from servers.world_server import write_map_point
        write_map_point(move, dest_x, dest_y)
        self.server.broadcast_to_map(map_id, move.build(1283))

    def _interrupt_skill(self, skill_sn: int, cancel_cd: bool):
        local = PacketBuilder()
        local.write_unsigned_short(skill_sn)
        local.write_bool(cancel_cd)
        self.send_packet(local.build(PlayerCommandCode.PLAYER_SKILL_INTERRUPTED_NOTIFY))
        remote = PacketBuilder()
        remote.write_string(self.role_name)
        remote.write_unsigned_short(skill_sn)
        self.server.broadcast_to_map(self.player_data.get('mapId'), remote.build(803), exclude_session=self.session)

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
            remote = PacketBuilder()
            remote.write_string(self.role_name)
            remote.write_short(new_level)
            self.server.broadcast_to_map(self.player_data.get('mapId'), remote.build(807), exclude_session=self.session)
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

    def _process_monster_drop(self, monster, map_id: str):
        try:
            self.log(f"Processando drops de {monster.code} em {map_id}")
            from handlers.loot_manager import LootManager
            loot_mgr = LootManager(self.session)
            
            extra_items = monster.mob_def.get("extraItems", [])
            import random
            for item_def in extra_items:
                chance = float(item_def.get("chance", 0.0))
                if random.random() <= chance:
                    item_code = item_def.get("itemCode")
                    if not item_code:
                        continue
                    min_c = int(item_def.get("minItemCount", 1))
                    max_c = int(item_def.get("maxItemCount", 1))
                    count = random.randint(min_c, max_c) if min_c < max_c else min_c
                    
                    loot_mgr.spawn_loot_on_ground(map_id, monster.x, monster.y, item_code, count)
                    self.log(f"🎉 Drop gerado: {item_code} x{count} em ({monster.x}, {monster.y})")
                    
        except Exception as e:
            self.log(f"Erro ao processar drop: {e}")
