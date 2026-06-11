import os
import json
import time
import random
import math
from typing import Dict, List, Optional
from config import GAME_RESOURCES_DIR
from gameplay.trap_runtime import TrapRuntime

class Monster:
    def __init__(self, instance_id: str, code: str, x: int, y: int, mob_def: dict, spawn_rule: dict):
        self.instance_id = instance_id
        self.code = code
        self.spawn_x = x
        self.spawn_y = y
        self.x = x
        self.y = y
        self.mob_def = mob_def
        self.spawn_rule = spawn_rule
        self.level = mob_def.get("level", 1)
        self.walk_speed = mob_def.get("walkSpeed", 100)
        self.hp_max = mob_def.get("hp", 100)
        self.hp = self.hp_max
        self.is_dead = False
        self.death_time = 0.0
        self.path = []
        self.is_boss = bool(spawn_rule.get("bossChance", 0) > 0)
        self.last_patrol_time = time.time()
        self.active_buffs = {}
        self.is_temporary = bool(spawn_rule.get("temporary"))
        self.owner_id = spawn_rule.get("ownerId")

    def apply_buff(self, buff_id, config):
        from gameplay.buff_runtime import apply_buff
        now = time.time()
        result = apply_buff(self.active_buffs, {**config, "buffId": int(buff_id)}, now=now)
        if result.applied:
            for trigger in result.instance.get("triggers", []):
                if trigger["event"] == "timer":
                    trigger["nextTimerAt"] = now + trigger["firstDelay"]
        return result

    def expire_buffs(self, now):
        from gameplay.buff_runtime import expire_buffs
        expire_buffs(self.active_buffs, now)

    def get_hp_percent(self) -> int:
        if self.hp_max <= 0:
            return 0
        return int((self.hp / self.hp_max) * 100)


class MapInstance:
    MONSTER_BORN_NOTIFY = 1281
    MONSTER_REMOVED_NOTIFY = 1288

    def __init__(self, map_id: str, map_def: dict, mob_defs: dict):
        self.map_id = map_id
        self.map_def = map_def
        self.mob_defs = mob_defs
        self.monsters: Dict[str, Monster] = {}
        self.items: Dict[str, dict] = {}
        self.trap_runtime = TrapRuntime(map_id)
        self._init_monsters()
        
    def _init_monsters(self):
        monster_arr = self.map_def.get("monsterRule", {}).get("monsterArray", [])
        for idx, spawn in enumerate(monster_arr):
            code = spawn.get("code")
            px = int(spawn.get("px", 0))
            py = int(spawn.get("py", 0))
            mob_def = self.mob_defs.get(code)
            if mob_def:
                inst_id = f"m_{self.map_id}_{idx}"
                self.monsters[inst_id] = Monster(inst_id, code, px, py, mob_def, spawn)
                
    def get_active_monsters(self) -> List[Monster]:
        return [m for m in self.monsters.values() if not m.is_dead]

    def release_trap(self, trap_code, owner_id, x, y, definition=None, now=None):
        return self.trap_runtime.release_trap(
            trap_code,
            owner_id,
            x,
            y,
            definition or {},
            time.time() if now is None else now,
        )

    def release_sys_trap(self, trap_code, owner_id, x, y, definition=None, now=None):
        return self.trap_runtime.release_sys_trap(
            trap_code,
            owner_id,
            x,
            y,
            definition or {},
            time.time() if now is None else now,
        )

    def release_temporary_monster(self, monster_code, owner_id, x, y, definition=None, now=None, server=None):
        now = time.time() if now is None else now
        summon = self.trap_runtime.release_summon(
            monster_code,
            owner_id,
            x,
            y,
            self.mob_defs,
            definition or {},
            now,
        )
        spawn_rule = {
            "code": summon.code,
            "px": int(summon.x),
            "py": int(summon.y),
            "temporary": True,
            "ownerId": summon.owner_id,
            "expiresAt": summon.expires_at,
        }
        self.monsters[summon.instance_id] = Monster(
            summon.instance_id,
            summon.code,
            int(summon.x),
            int(summon.y),
            summon.mob_def,
            spawn_rule,
        )
        monster = self.monsters[summon.instance_id]
        self._broadcast_monster_born(server, monster)
        return monster

    def release_from_macro(self, macro, owner_id, x, y, now=None, server=None):
        now = time.time() if now is None else now
        events = self.trap_runtime.release_from_macro(macro, owner_id, x, y, self.mob_defs, now)
        for event in events:
            if event.kind != "summon_spawned":
                continue
            summon = event.payload["summon"]
            spawn_rule = {
                "code": summon.code,
                "px": int(summon.x),
                "py": int(summon.y),
                "temporary": True,
                "ownerId": summon.owner_id,
                "expiresAt": summon.expires_at,
            }
            self.monsters[summon.instance_id] = Monster(
                summon.instance_id,
                summon.code,
                int(summon.x),
                int(summon.y),
                summon.mob_def,
                spawn_rule,
            )
            self._broadcast_monster_born(server, self.monsters[summon.instance_id])
        return events

    def _broadcast_monster_born(self, server, monster):
        if not server or not hasattr(server, "broadcast_to_map"):
            return
        try:
            from protocol.packet_builder import PacketBuilder
            from servers.world_server import write_monster_info
            born = PacketBuilder()
            born.write_string(self.map_id)
            write_monster_info(born, monster)
            server.broadcast_to_map(self.map_id, born.build(self.MONSTER_BORN_NOTIFY))
        except Exception as exc:
            print(f"[MapManager] Falha ao notificar nascimento de monstro temporario {monster.instance_id}: {exc}")

    def _broadcast_monster_removed(self, server, monster_id):
        if not server or not hasattr(server, "broadcast_to_map"):
            return
        try:
            from protocol.packet_builder import PacketBuilder
            removed = PacketBuilder()
            removed.write_string(monster_id)
            server.broadcast_to_map(self.map_id, removed.build(self.MONSTER_REMOVED_NOTIFY))
        except Exception as exc:
            print(f"[MapManager] Falha ao notificar remocao de monstro temporario {monster_id}: {exc}")
        
    def tick(self, current_time: float, server=None):
        def run_trap_macro(macro, trap, target):
            if not server:
                return
            from gameplay.macro_engine import MacroContext
            server.macro_engine.execute(macro, MacroContext(server=server, monster=target, source=trap))

        trap_events = self.trap_runtime.tick(current_time, self.get_active_monsters(), run_trap_macro if server else None)
        expired_summons = {
            event.payload["summon"].instance_id
            for event in trap_events
            if event.kind == "summon_expired" and event.payload.get("summon")
        }
        for instance_id in expired_summons:
            if instance_id in self.monsters:
                del self.monsters[instance_id]
                self._broadcast_monster_removed(server, instance_id)

        # Gerencia respawn de monstros mortos
        for m in self.monsters.values():
            if getattr(m, "is_temporary", False):
                expires_at = m.spawn_rule.get("expiresAt")
                if expires_at is not None and current_time >= expires_at:
                    continue
            m.expire_buffs(current_time)
            if server:
                for buff in list(m.active_buffs.values()):
                    for trigger in buff.get("triggers", []):
                        if trigger["event"] == "timer" and current_time >= trigger.get("nextTimerAt", 0):
                            from gameplay.macro_engine import MacroContext
                            server.macro_engine.execute(trigger["macro"], MacroContext(server=server, monster=m, source=buff))
                            trigger["nextTimerAt"] = current_time + max(0.1, trigger["repeatInterval"] or 999999999)
            if m.is_dead:
                # rebirthIntervalMin é em minutos, se for 0 usamos padrão de 15 segundos para fins de teste/debug
                interval_min = m.spawn_rule.get("rebirthIntervalMin", 1)
                interval_sec = interval_min * 60 if interval_min > 0 else 15
                respawn_time = m.death_time + interval_sec
                if current_time >= respawn_time:
                    m.is_dead = False
                    m.hp = m.hp_max
                    m.x = m.spawn_x
                    m.y = m.spawn_y
                    m.aggro_target = None
                    if server:
                        from protocol.packet_builder import PacketBuilder
                        from servers.world_server import write_monster_info
                        born = PacketBuilder()
                        born.write_string(self.map_id)
                        write_monster_info(born, m)
                        server.broadcast_to_map(self.map_id, born.build(1281))
            elif server:
                # Apenas monstros agressivos (threatAIMode 1 ou 2) têm aggro automático
                if not getattr(m, 'aggro_target', None) and m.mob_def.get('threatAIMode') in (1, 2):
                    for sess in server.sessions.values():
                        if sess.player_data and not sess.player_data.get('isDead') and sess.player_data.get('mapId') == self.map_id:
                            px = sess.player_data.get('posX', 0)
                            py = sess.player_data.get('posY', 0)
                            if math.hypot(m.x - px, m.y - py) < 250:
                                m.aggro_target = sess.role_name
                                break
                
                if getattr(m, 'aggro_target', None):
                    session = server.sessions.get(m.aggro_target)
                    if not session:
                        session = next(
                            (candidate for candidate in server.sessions.values()
                             if candidate.player_data and candidate.role_name == m.aggro_target),
                            None,
                        )
                    if not session or not session.player_data or session.player_data.get('isDead'):
                        m.aggro_target = None
                        continue
                    
                    if session.player_data.get('mapId') != self.map_id:
                        m.aggro_target = None
                        continue
                    
                    # Cooldown de 2 segundos para ataque do monstro
                    last_atk = getattr(m, 'last_attack_time', 0.0)
                    if current_time - last_atk < 2.0:
                        continue
                    m.last_attack_time = current_time
                    
                    # Calcular dano
                    monster_atk = float(
                        m.mob_def.get('physicalAttack')
                        or m.mob_def.get('magicAttack')
                        or m.mob_def.get('attack')
                        or 10
                    )
                    player_def = float(session.player_data.get('physicalDefense', 5))
                    damage = max(1.0, monster_atk - player_def)
                    
                    player_hp = float(session.player_data.get('hp', 100))
                    new_hp = max(0.0, player_hp - damage)
                    session.player_data['hp'] = new_hp
                    server.set_combat_status(session, True)
                    server.trigger_buffs(session, "under_attack")
                    server.trigger_monster_buffs(m, "attack", session)
                    
                    # Send MONSTER_USE_SKILL_NOTIFY (cmd 1285) to trigger attack animation
                    from protocol.packet_builder import PacketBuilder
                    atk_builder = PacketBuilder()
                    atk_builder.write_string(self.map_id)
                    atk_builder.write_string(m.instance_id)
                    atk_builder.write_string(m.code)
                    atk_builder.write_short(int(m.x))
                    atk_builder.write_short(int(m.y))
                    atk_builder.write_string("basic") # skillCode
                    atk_builder.write_byte(1) # skillLevel
                    atk_builder.write_string(session.role_name) # targetId
                    
                    from servers.world_server import write_map_point
                    write_map_point(atk_builder, int(session.player_data.get('posX', m.x)), int(session.player_data.get('posY', m.y)))
                    
                    atk_builder.write_unsigned_short(0) # singTime
                    atk_builder.write_unsigned_short(0) # castTime
                    server.broadcast_to_map(self.map_id, atk_builder.build(1285))
                    
                    # Send PLAYER_HP_CHANGE_NOTIFY (cmd 550)
                    hp_builder = PacketBuilder()
                    hp_builder.write_double(-float(damage))
                    hp_builder.write_double(float(new_hp))
                    hp_builder.write_string("basic")
                    hp_builder.write_bool(False) # isCriticalStrike
                    hp_builder.write_bool(False) # isHidden
                    session.send_packet(hp_builder.build(550))
                    server.broadcast_remote_hp(session, -damage, "basic", False)
                    
                    session.log(f"💥 Monstro {m.instance_id} atacou {m.aggro_target} causando {damage} de dano! HP: {new_hp}")
                    
                    if new_hp <= 0:
                        server.notify_player_died(session)
                        m.aggro_target = None
            elif server and m.walk_speed > 0 and current_time - m.last_patrol_time >= 5.0:
                patrol_range = int(m.mob_def.get('patrolRange', 0) or 0)
                if patrol_range > 1:
                    m.last_patrol_time = current_time
                    angle = random.random() * math.pi * 2
                    dest_x = int(m.spawn_x + math.cos(angle) * random.randint(20, patrol_range))
                    dest_y = int(m.spawn_y + math.sin(angle) * random.randint(20, patrol_range))
                    m.x, m.y = dest_x, dest_y
                    from protocol.packet_builder import PacketBuilder
                    from servers.world_server import write_map_point
                    move = PacketBuilder()
                    move.write_string(self.map_id)
                    move.write_string(m.instance_id)
                    move.write_string(m.code)
                    move.write_varint(1)
                    write_map_point(move, dest_x, dest_y)
                    server.broadcast_to_map(self.map_id, move.build(1283))


class MapManager:
    _instance: Optional['MapManager'] = None

    @classmethod
    def get_instance(cls) -> 'MapManager':
        if cls._instance is None:
            cls._instance = MapManager()
        return cls._instance

    def __init__(self):
        self.mob_definitions = {}
        self.maps: Dict[str, MapInstance] = {}
        self.load_data()
        
    def load_data(self):
        decoded_dir = os.path.join(GAME_RESOURCES_DIR, "decoded")
        
        # Carrega as definições dos monstros
        mob_def_path = os.path.join(decoded_dir, "imn.json")
        if os.path.exists(mob_def_path):
            try:
                with open(mob_def_path, "r", encoding="utf-8") as f:
                    mobs = json.load(f)
                    for m in mobs:
                        self.mob_definitions[m.get("code")] = m
                print(f"[MapManager] Carregadas {len(self.mob_definitions)} definições de monstros.")
            except Exception as e:
                print(f"[MapManager] Erro ao carregar imn.json: {e}")
                
        # Carrega os arquivos de mapas
        for map_name in ["a1", "a2", "a3", "a4"]:
            map_path = os.path.join(decoded_dir, f"m{map_name}.json")
            if os.path.exists(map_path):
                try:
                    with open(map_path, "r", encoding="utf-8") as f:
                        map_def = json.load(f)
                        self.maps[map_name] = MapInstance(map_name, map_def, self.mob_definitions)
                        print(f"[MapManager] Mapa {map_name} instanciado com {len(self.maps[map_name].monsters)} spawns.")
                except Exception as e:
                    print(f"[MapManager] Erro ao carregar mapa {map_name}: {e}")
                    
    def get_map(self, map_id: str) -> Optional[MapInstance]:
        return self.maps.get(map_id)
        
    def tick(self, server=None):
        now = time.time()
        for inst in self.maps.values():
            inst.tick(now, server)
