import unittest

from gameplay.macro_engine import MacroContext, MacroEngine


class Monster:
    hp = 50
    hp_max = 100


class MacroCombatIntegrationTests(unittest.TestCase):
    def test_periodic_macro_can_damage_and_heal_monster(self):
        monster = Monster()
        engine = MacroEngine(strict=True)
        context = MacroContext(server=object(), monster=monster)
        engine.execute({"addHp": -20}, context)
        self.assertEqual(monster.hp, 30)
        engine.execute({"addHp": 100}, context)
        self.assertEqual(monster.hp, 100)

    def test_macro_can_release_trap_on_current_map(self):
        class Map:
            released = None
            def release_from_macro(self, macro, owner, x, y, now=None, server=None):
                self.released = (macro, owner, x, y, server)
        class Maps:
            map = Map()
            def get_map(self, map_id):
                return self.map
        class Session:
            role_name = "hero"
            player_data = {"mapId": "a1", "posX": 10, "posY": 20}
        class Server:
            map_manager = Maps()
        server = Server()
        MacroEngine(strict=True).execute({"trapCode": "fire"}, MacroContext(server=server, session=Session()))
        self.assertEqual(server.map_manager.map.released, ({"trapCode": "fire"}, "hero", 10, 20, server))


if __name__ == "__main__":
    unittest.main()
