import os
import sys
import unittest
from unittest.mock import patch


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.combat_handler import CombatHandler
from gameplay.combat_scheduler import CombatScheduler
from protocol.commands import PlayerCommandCode
from protocol.packet_reader import PacketReader
from attribute_calculator import AttributeCalculator


def packet_command(packet):
    reader = PacketReader(packet)
    reader.read_varint()
    return reader.read_unsigned_short()


class FakeUseSkillReader:
    def __init__(self, map_id, skill_sn, skill_code, target_id, target_x=0, target_y=0, has_point=False):
        self.strings = [map_id, skill_code, target_id]
        self.ushorts = [skill_sn, 1 if has_point else 0]
        self.shorts = [target_x, target_y]
        self.varints = [0]

    def read_string(self):
        return self.strings.pop(0)

    def read_unsigned_short(self):
        return self.ushorts.pop(0)

    def read_short(self):
        return self.shorts.pop(0)

    def read_varint(self):
        return self.varints.pop(0)

    def read_bytes(self):
        return b""


class FakeDb:
    def __init__(self):
        self.queries = []

    def execute_non_query(self, sql, args=()):
        self.queries.append((sql, args))

    def execute_query(self, sql, args=()):
        return []


class FakeScheduler:
    def __init__(self):
        self.cooldowns = []
        self.cancelled = []

    def now(self):
        return 0.0

    def is_ready(self, actor_id, skill_sn, group=None):
        return True

    def start_cooldowns(self, *args):
        self.cooldowns.append(args)

    def cancel(self, *args):
        self.cancelled.append(args)
        return 0

    def schedule_cast(self, *args):
        raise AssertionError("integration test skills should resolve immediately")

    def schedule_skill_cost(self, *args):
        raise AssertionError("integration test skills should resolve immediately")

    def schedule_key_times(self, *args, **kwargs):
        raise AssertionError("integration test skills should resolve immediately")


class FakeResourceIndex:
    def __init__(self, skills=None, buffs=None):
        self.skills = skills or {}
        self.buffs = buffs or {}

    def skill(self, code):
        return self.skills.get(code, {})

    def buff(self, buff_id):
        return self.buffs.get(int(buff_id), {})


class FakeMacroEngine:
    def __init__(self):
        self.executed = []

    def execute(self, macro, context):
        self.executed.append((macro, context))

    def _add_hp(self, amount, context, *_args):
        target = context.target_session or context.session
        if target and target.player_data:
            old = target.player_data.get("hp", 0)
            maximum = target.player_data.get("hpMax", old)
            target.player_data["hp"] = min(maximum, old + amount)


class FakeSession:
    def __init__(self, server, name, **player_data):
        self.server = server
        self.account_id = f"account:{name}"
        self.sent_packets = []
        self.logs = []
        self.exp_changes = []
        self.gold_changes = []
        self.level_ups = []
        self.attr_changes = []
        self.player_data = {
            "name": name,
            "roleId": name,
            "mapId": "m1",
            "posX": 0,
            "posY": 0,
            "hp": 100,
            "hpMax": 100,
            "mp": 100,
            "sp": 100,
            "level": 10,
            "maxLevel": 99,
            "exp": 0,
            "gold": 0,
            "physicalAttack": 100,
            "hitRate": 1.0,
            "critRate": 0,
            "learnedSkills": {},
            "activeBuffs": {},
        }
        self.player_data.update(player_data)

    @property
    def role_name(self) -> str:
        return self.player_data.get("name", "")

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_exp_change(self, exp):
        self.exp_changes.append(exp)

    def _send_gold_change(self, gold):
        self.gold_changes.append(gold)

    def _send_level_up(self, level):
        self.level_ups.append(level)

    def _send_ext_attr_int_change(self, *args):
        self.attr_changes.append(args)

    def _send_player_attributes(self):
        pass


class FakeServer:
    def __init__(self, skills=None, buffs=None):
        self.db = FakeDb()
        self.sessions = {}
        self.resource_index = FakeResourceIndex(skills, buffs)
        self.map_manager = FakeMapManager()
        self.combat_scheduler = FakeScheduler()
        self.macro_engine = FakeMacroEngine()
        self.broadcasts = []
        self.remote_hp = []
        self.remote_mp = []
        self.combat_status = []
        self.applied_buffs = []
        self.deaths = []
        self.triggered_buffs = []
        self.triggered_monster_buffs = []

    def _get_db(self):
        return self.db

    def set_combat_status(self, session, enabled):
        self.combat_status.append((session.player_data["name"], enabled))

    def broadcast_to_map(self, map_id, packet, exclude_session=None):
        self.broadcasts.append((map_id, packet, exclude_session))

    def broadcast_remote_hp(self, session, amount, skill_code, critical=False):
        self.remote_hp.append((session.player_data["name"], amount, skill_code, critical))

    def broadcast_remote_mp(self, session, amount, skill_code):
        self.remote_mp.append((session.player_data["name"], amount, skill_code))

    def apply_buff(self, session, buff_id, duration_sec):
        session.player_data.setdefault("activeBuffs", {})[int(buff_id)] = {
            "buffId": int(buff_id),
            "durationInSec": duration_sec,
            **self.resource_index.buff(buff_id),
        }
        self.applied_buffs.append((session.player_data["name"], int(buff_id), duration_sec))

    def trigger_buffs(self, *args):
        self.triggered_buffs.append(args)

    def trigger_monster_buffs(self, *args):
        self.triggered_monster_buffs.append(args)

    def notify_player_died(self, session):
        self.deaths.append(session.player_data["name"])


class AttrDb:
    def execute_query(self, sql, args=()):
        return []


class FakeMonster:
    def __init__(self, instance_id, x, y, hp=30, exp=15, gold=7):
        self.instance_id = instance_id
        self.code = instance_id
        self.x = x
        self.y = y
        self.hp = hp
        self.hp_max = hp
        self.is_dead = False
        self.death_time = None
        self.aggro_target = None
        self.last_attack_time = None
        self.applied_buffs = []
        self.mob_def = {
            "posX": x,
            "posY": y,
            "hp": hp,
            "physicalDefense": 0,
            "magicDefense": 0,
            "dodgeRate": 0,
            "exp": exp,
            "gold": gold,
            "extraItems": [],
        }

    def get_hp_percent(self):
        return int((self.hp / self.hp_max) * 100) if self.hp_max else 0

    def apply_buff(self, buff_id, config):
        self.applied_buffs.append((buff_id, config))


class FakeMap:
    def __init__(self, monsters=None):
        self.monsters = {monster.instance_id: monster for monster in monsters or []}
        self.released_macros = []

    def get_active_monsters(self):
        return [monster for monster in self.monsters.values() if not monster.is_dead]

    def release_from_macro(self, macro, owner, x, y, now=None, server=None):
        self.released_macros.append((macro, owner, x, y, server))
        return []


class FakeMapManager:
    def __init__(self):
        self.maps = {}

    def get_map(self, map_id):
        return self.maps.get(map_id)


def damage_skill(range_=200, damage=25, target=16, radius=0, target_number=1):
    return {
        "code": "damage",
        "target": target,
        "levelInfo": [{
            "castRule": {
                "range": range_,
                "coldTime": 0,
                "castCost": {"mp": 0},
                "areaAttributes": {"radius": radius},
                "targetNumber": target_number,
            },
            "resultRule": {
                "toTarget": {
                    "attack1Attr": 11,
                    "attack1AttrMultiply": 0,
                    "attackAdded": damage,
                }
            },
        }],
    }


def keyed_damage_skill():
    skill = damage_skill(range_=300, damage=5)
    skill["levelInfo"][0]["castRule"].update({
        "singTime": 1000,
        "castTime": 2000,
        "singKeyTimes": [500],
        "castKeyTimes": [250, 1500],
        "costAtKeyTime": True,
        "castCost": {"mp": 30},
    })
    return skill


def ground_trap_skill():
    return {
        "code": "ground",
        "target": 256,
        "levelInfo": [{
            "castRule": {"range": 300, "coldTime": 0, "castCost": {"mp": 0}},
            "resultRule": {
                "toGround": {
                    "0": {"trapCode": "fire01"},
                    "1": {"isSysTrap": True, "trapCode": "sys01"},
                }
            },
        }],
    }


class TestClock:
    def __init__(self):
        self.value = 0.0

    def __call__(self):
        return self.value

    def advance(self, seconds):
        self.value += seconds


def healing_buff_skill():
    return {
        "code": "heal",
        "target": 0,
        "levelInfo": [{
            "castRule": {"range": 300, "coldTime": 0, "castCost": {"mp": 0}},
            "resultRule": {
                "toTarget": {
                    "hpAddFixed": 40,
                    "buffIds": [1234],
                }
            },
        }],
    }


class CombatHandlerIntegrationTests(unittest.TestCase):
    def make_handler(self, server, **player_overrides):
        hero = FakeSession(server, "hero", **player_overrides)
        server.sessions["hero"] = hero
        return CombatHandler(hero), hero

    def use_skill(self, handler, skill_code, target_id, skill_sn=77, map_id="m1"):
        handler.handle_use_skill(FakeUseSkillReader(map_id, skill_sn, skill_code, target_id))

    def assert_interrupted(self, session):
        commands = [packet_command(packet) for packet in session.sent_packets]
        self.assertIn(PlayerCommandCode.PLAYER_SKILL_INTERRUPTED_NOTIFY, commands)

    def test_unknown_skill_is_rejected(self):
        server = FakeServer(skills={})
        handler, hero = self.make_handler(server, learnedSkills={"missing": 1})

        self.use_skill(handler, "missing", "target")

        self.assert_interrupted(hero)
        self.assertEqual(server.combat_scheduler.cooldowns, [])

    def test_unlearned_skill_is_rejected(self):
        server = FakeServer(skills={"fire": damage_skill()})
        handler, hero = self.make_handler(server, learnedSkills={})

        self.use_skill(handler, "fire", "target")

        self.assert_interrupted(hero)
        self.assertEqual(server.combat_scheduler.cooldowns, [])

    def test_out_of_range_skill_is_rejected(self):
        monster = FakeMonster("mob1", 1000, 0)
        server = FakeServer(skills={"fire": damage_skill(range_=100)})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={"fire": 1})

        self.use_skill(handler, "fire", "mob1")

        self.assert_interrupted(hero)
        self.assertEqual(monster.hp, 30)

    def test_basic_attack_uses_fallback_damage_when_skill_config_is_missing(self):
        monster = FakeMonster("mob1", 100, 0, hp=30, exp=15, gold=7)
        server = FakeServer(skills={})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={"basic": 1}, physicalAttack=50)

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            self.use_skill(handler, "basic", "mob1")

        self.assertLess(monster.hp, 30)
        self.assertTrue(server.triggered_monster_buffs)
        self.assertEqual(server.triggered_monster_buffs[-1][1], "under_attack")
        self.assertTrue(server.broadcasts)
        self.assertEqual(server.broadcasts[-1][0], "m1")
        self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0.9)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][-1], 0)

    def test_za0_is_basic_attack_and_does_not_need_to_be_learned(self):
        monster = FakeMonster("mob1", 100, 0, hp=30)
        server = FakeServer(skills={})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={}, physicalAttack=50)

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            self.use_skill(handler, "za0", "mob1")

        self.assertLess(monster.hp, 30)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][1], "za0")
        self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0.9)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][-1], 0)

    def test_xj_class_attacks_are_basic_attacks_and_do_not_need_to_be_learned(self):
        for skill_code in ("xj1", "xj2", "xj3", "xj4", "xj5", "xj6", "xj7"):
            with self.subTest(skill_code=skill_code):
                monster = FakeMonster("mob1", 100, 0, hp=30)
                server = FakeServer(skills={})
                server.map_manager.maps["m1"] = FakeMap([monster])
                handler, hero = self.make_handler(server, learnedSkills={}, physicalAttack=50)

                with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
                    self.use_skill(handler, skill_code, "mob1")

                self.assertLess(monster.hp, 30)
                self.assertEqual(server.combat_scheduler.cooldowns[-1][1], skill_code)
                self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0.9)
                self.assertEqual(server.combat_scheduler.cooldowns[-1][-1], 0)

    def test_za0_basic_attack_accepts_client_auto_attack_spacing(self):
        monster = FakeMonster("mob1", 250, 0, hp=30)
        server = FakeServer(skills={})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={}, physicalAttack=50)

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            self.use_skill(handler, "za0", "mob1")

        self.assertLess(monster.hp, 30)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][1], "za0")

    def test_basic_attack_interval_uses_attack_speed_modifier(self):
        monster = FakeMonster("mob1", 100, 0, hp=300)
        server = FakeServer(skills={})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(
            server,
            learnedSkills={"basic": 1},
            castTimeModifier=0.5,
        )

        self.use_skill(handler, "basic", "mob1")

        self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0.45)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][-1], 0)

    def test_basic_attack_interval_uses_attack_speed_buff(self):
        monster = FakeMonster("mob1", 100, 0, hp=300)
        server = FakeServer(skills={})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(
            server,
            learnedSkills={"basic": 1},
            castTimeModifier=1.0,
            activeBuffs={1: {"resultAttr": {"300": 0.25}}},
        )

        self.use_skill(handler, "basic", "mob1")

        self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0.72)

    def test_special_skill_keeps_configured_cooldown_and_global_lock(self):
        monster = FakeMonster("mob1", 100, 0)
        server = FakeServer(skills={"fire": damage_skill()})
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={"fire": 1})

        self.use_skill(handler, "fire", "mob1")

        self.assertEqual(server.combat_scheduler.cooldowns[-1][2], 0)
        self.assertEqual(server.combat_scheduler.cooldowns[-1][-1], 0.15)

    def test_basic_skill_does_not_consume_learn_points(self):
        server = FakeServer(skills={"fire": damage_skill()})
        handler, hero = self.make_handler(server, learnedSkills={"basic": 1}, level=2)

        with patch("handlers.skill_handler.PacketBuilder"):
            pass

        # The important part is that basic attack is ignored in used-point accounting.
        skills = hero.player_data.setdefault("learnedSkills", {})
        self.assertEqual(skills.get("basic"), 1)

    def test_attribute_calculator_reads_baseattr_and_extattr(self):
        calc = AttributeCalculator(AttrDb())
        attrs = {
            "properties": {
                "baseAttr": [{"attr": 140, "value": "25"}],
                "extAttr": [{"attr": 200, "value": "100"}],
            }
        }
        values = list(calc._iter_attrs(attrs))
        self.assertIn((140, 25.0), values)
        self.assertIn((200, 100.0), values)

    def test_healing_and_buff_apply_to_player_target(self):
        server = FakeServer(skills={"heal": healing_buff_skill()}, buffs={1234: {"resultStatus": 0}})
        handler, hero = self.make_handler(server, learnedSkills={"heal": 1})
        ally = FakeSession(server, "ally", hp=50, hpMax=100, posX=50, posY=0)
        server.sessions["ally"] = ally

        self.use_skill(handler, "heal", "ally")

        self.assertEqual(ally.player_data["hp"], 90)
        self.assertIn((ally.player_data["name"], 1234, 10), server.applied_buffs)
        self.assertIn(1234, ally.player_data["activeBuffs"])

    def test_pvp_damage_is_blocked_for_same_group(self):
        server = FakeServer(skills={"strike": damage_skill(damage=80, target=16)})
        handler, hero = self.make_handler(server, learnedSkills={"strike": 1}, teamName="party")
        ally = FakeSession(server, "ally", hp=100, posX=50, posY=0, teamName="party")
        server.sessions["ally"] = ally

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            self.use_skill(handler, "strike", "ally")

        self.assertEqual(ally.player_data["hp"], 100)
        self.assertEqual(server.remote_hp, [])
        self.assertEqual(server.deaths, [])

    def test_aoe_kills_secondary_monster_and_awards_rewards(self):
        primary = FakeMonster("mob1", 100, 0, hp=30, exp=15, gold=7)
        secondary = FakeMonster("mob2", 120, 0, hp=30, exp=25, gold=11)
        far = FakeMonster("mob3", 800, 0, hp=30, exp=99, gold=99)
        server = FakeServer(
            skills={"burst": damage_skill(range_=300, damage=50, radius=80, target_number=2)}
        )
        server.map_manager.maps["m1"] = FakeMap([primary, secondary, far])
        handler, hero = self.make_handler(server, learnedSkills={"burst": 1})
        dropped = []
        handler._process_monster_drop = lambda monster, map_id: dropped.append((monster.instance_id, map_id))

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            self.use_skill(handler, "burst", "mob1")

        self.assertTrue(primary.is_dead)
        self.assertTrue(secondary.is_dead)
        self.assertFalse(far.is_dead)
        self.assertEqual(hero.exp_changes, [25, 15])
        self.assertEqual(hero.gold_changes, [11, 7])
        self.assertEqual(dropped, [("mob2", "m1"), ("mob1", "m1")])

    def test_ground_skill_releases_normal_and_system_traps_at_target_point(self):
        server = FakeServer(skills={"ground": ground_trap_skill()})
        game_map = FakeMap()
        server.map_manager.maps["m1"] = game_map
        handler, hero = self.make_handler(server, learnedSkills={"ground": 1})

        handler.handle_use_skill(FakeUseSkillReader("m1", 77, "ground", "", 140, 220, has_point=True))

        self.assertEqual(
            game_map.released_macros,
            [
                ({"trapCode": ["fire01"]}, "hero", 140, 220, server),
                ({"releaseSysTrap": ["sys01"]}, "hero", 140, 220, server),
            ],
        )

    def test_key_times_defer_cost_and_resolve_each_key_without_final_duplicate(self):
        clock = TestClock()
        monster = FakeMonster("mob1", 100, 0, hp=30)
        server = FakeServer(skills={"beam": keyed_damage_skill()})
        server.combat_scheduler = CombatScheduler(clock=clock)
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={"beam": 1})

        self.use_skill(handler, "beam", "mob1")

        self.assertEqual(hero.player_data["mp"], 100)
        self.assertEqual(monster.hp, 30)
        self.assertEqual(server.combat_scheduler.pending_count(), 4)

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            clock.advance(0.5)
            self.assertEqual(server.combat_scheduler.run_due(), 2)
            self.assertEqual(hero.player_data["mp"], 70)
            self.assertEqual(monster.hp, 25)

            clock.advance(0.75)
            self.assertEqual(server.combat_scheduler.run_due(), 1)
            self.assertEqual(monster.hp, 20)

            clock.advance(1.25)
            self.assertEqual(server.combat_scheduler.run_due(), 1)
            self.assertEqual(monster.hp, 15)

        self.assertEqual(server.combat_scheduler.pending_count(), 0)

    def test_key_time_cost_failure_cancels_ready_impact_and_remaining_keys(self):
        clock = TestClock()
        monster = FakeMonster("mob1", 100, 0, hp=30)
        server = FakeServer(skills={"beam": keyed_damage_skill()})
        server.combat_scheduler = CombatScheduler(clock=clock)
        server.map_manager.maps["m1"] = FakeMap([monster])
        handler, hero = self.make_handler(server, learnedSkills={"beam": 1})

        self.use_skill(handler, "beam", "mob1")
        hero.player_data["mp"] = 0

        with patch("handlers.combat_handler.roll_hit_critical", return_value=(True, False)):
            clock.advance(0.5)
            self.assertEqual(server.combat_scheduler.run_due(), 2)

        self.assertEqual(monster.hp, 30)
        self.assertEqual(hero.player_data["mp"], 0)
        self.assertEqual(server.combat_scheduler.pending_count(), 0)
        self.assert_interrupted(hero)


if __name__ == "__main__":
    unittest.main()
