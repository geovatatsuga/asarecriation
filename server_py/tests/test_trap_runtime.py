import unittest

from gameplay.trap_runtime import TrapRuntime
from map_manager import MapInstance


def packet_command(packet):
    pos = 0
    while True:
        byte = packet[pos]
        pos += 1
        if not byte & 0x80:
            break
    return int.from_bytes(packet[pos:pos + 2], "big")


class Target:
    def __init__(self, instance_id="m1", x=0, y=0, hp=100):
        self.instance_id = instance_id
        self.x = x
        self.y = y
        self.hp = hp
        self.is_dead = False


class TrapRuntimeTests(unittest.TestCase):
    def test_trap_code_releases_logical_trap_and_expires(self):
        runtime = TrapRuntime("a1")
        events = runtime.release_from_macro({"trapCode": "fire"}, "hero", 10, 20, now=1)
        self.assertEqual([event.kind for event in events], ["trap_released"])
        trap = events[0].payload["trap"]
        self.assertEqual(trap.code, "fire")
        self.assertEqual(trap.owner_id, "hero")
        self.assertEqual(trap.x, 10)
        self.assertEqual(trap.y, 20)

        expired = runtime.tick(10, [])
        self.assertEqual([event.kind for event in expired], ["trap_expired"])
        self.assertFalse(runtime.traps)

    def test_release_trap_ticks_damage_and_macro_inside_radius(self):
        runtime = TrapRuntime("a1")
        target = Target(x=5, y=0, hp=50)
        calls = []
        runtime.release_trap(
            "ice",
            "hero",
            0,
            0,
            {"radius": 10, "damage": 7, "repeatTimeInSec": 2, "doMacro": {"addBuffs": [1]}},
            now=0,
        )

        events = runtime.tick(0, [target], lambda macro, trap, touched: calls.append((macro, trap.code, touched.instance_id)))
        self.assertEqual(target.hp, 43)
        self.assertEqual(calls, [({"addBuffs": [1]}, "ice", "m1")])
        self.assertIn("trap_triggered", [event.kind for event in events])
        self.assertIn("damage", [event.kind for event in events])
        self.assertIn("macro", [event.kind for event in events])

        runtime.tick(1, [target])
        self.assertEqual(target.hp, 43)
        runtime.tick(2, [target])
        self.assertEqual(target.hp, 36)

    def test_release_sys_trap_once_only_fires_once(self):
        runtime = TrapRuntime("a1")
        target = Target(hp=30)
        runtime.release_sys_trap("burst", "system", 0, 0, {"radius": 10, "damage": 10, "triggerOnce": True}, now=0)

        first = runtime.tick(0, [target])
        second = runtime.tick(0.1, [target])

        self.assertEqual(target.hp, 20)
        self.assertIn("trap_expired", [event.kind for event in first])
        self.assertEqual(second, [])

    def test_release_monster_uses_existing_definition_when_available(self):
        runtime = TrapRuntime("a1")
        events = runtime.release_from_macro(
            {"releaseMonster": {"monsterCode": "mob01", "durationInSec": 3}},
            "hero",
            15,
            25,
            {"mob01": {"code": "mob01", "hp": 250, "level": 9}},
            now=4,
        )
        summon = events[0].payload["summon"]
        self.assertEqual(events[0].kind, "summon_spawned")
        self.assertEqual(summon.mob_def["hp"], 250)
        self.assertEqual(summon.expires_at, 7)

        expired = runtime.tick(7, [])
        self.assertEqual([event.kind for event in expired], ["summon_expired"])


class MapTrapIntegrationTests(unittest.TestCase):
    def test_map_instance_stores_traps_and_temporary_monsters(self):
        mob_defs = {"mob01": {"code": "mob01", "hp": 250, "level": 9}}
        inst = MapInstance("a1", {"monsterRule": {"monsterArray": []}}, mob_defs)

        trap = inst.release_trap("fire", "hero", 1, 2, {"durationInSec": 2}, now=0)
        monster = inst.release_temporary_monster("mob01", "hero", 10, 20, {"durationInSec": 2}, now=0)

        self.assertIn(trap.instance_id, inst.trap_runtime.traps)
        self.assertIn(monster.instance_id, inst.monsters)
        self.assertTrue(inst.monsters[monster.instance_id].is_temporary)
        self.assertEqual(inst.monsters[monster.instance_id].hp_max, 250)

        inst.tick(2, server=None)
        self.assertNotIn(trap.instance_id, inst.trap_runtime.traps)
        self.assertNotIn(monster.instance_id, inst.monsters)

    def test_map_release_from_macro_creates_trap_and_summon(self):
        mob_defs = {"mob01": {"code": "mob01", "hp": 100}}
        inst = MapInstance("a1", {"monsterRule": {"monsterArray": []}}, mob_defs)

        events = inst.release_from_macro(
            {
                "releaseSysTrap": {"trapCode": "sys01", "durationInSec": 1},
                "releaseMonster": {"monsterCode": "mob01", "durationInSec": 1},
            },
            "hero",
            0,
            0,
            now=0,
        )

        self.assertEqual([event.kind for event in events], ["trap_released", "summon_spawned"])
        self.assertEqual(len(inst.trap_runtime.traps), 1)
        self.assertEqual(len(inst.monsters), 1)

    def test_map_release_from_macro_broadcasts_temporary_monster_lifecycle(self):
        class Server:
            def __init__(self):
                self.sent = []

            def broadcast_to_map(self, map_id, packet, exclude_session=None):
                self.sent.append((map_id, packet))

        mob_defs = {"mob01": {"code": "mob01", "hp": 100, "level": 2}}
        inst = MapInstance("a1", {"monsterRule": {"monsterArray": []}}, mob_defs)
        server = Server()

        events = inst.release_from_macro(
            {"releaseMonster": {"monsterCode": "mob01", "durationInSec": 1}},
            "hero",
            10,
            20,
            now=0,
            server=server,
        )

        summon_id = events[0].instance_id
        self.assertEqual([packet_command(packet) for _, packet in server.sent], [1281])
        self.assertIn(summon_id, inst.monsters)

        inst.tick(1, server=server)

        self.assertNotIn(summon_id, inst.monsters)
        self.assertEqual([packet_command(packet) for _, packet in server.sent], [1281, 1288])


if __name__ == "__main__":
    unittest.main()
