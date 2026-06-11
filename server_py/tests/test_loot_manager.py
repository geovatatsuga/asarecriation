import os
import sys
import unittest
from types import SimpleNamespace
from unittest.mock import patch


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.loot_manager import LootManager
from handlers.registry import HandlerRegistry, _register_all_handlers
from protocol.commands import BagCommandCode, MapCommandCode
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader


def packet_command(packet):
    reader = PacketReader(packet)
    reader.read_varint()
    return reader.read_unsigned_short()


def packet_payload_reader(packet):
    reader = PacketReader(packet)
    reader.read_varint()
    reader.read_unsigned_short()
    reader.read_unsigned_short()
    return reader


def pickup_payload(map_id="m1", item_id="loot-1"):
    builder = PacketBuilder()
    builder.write_string(map_id)
    builder.write_string(item_id)
    return builder.get_bytes()


class FakeInventoryManager:
    added = []
    removed = []

    def __init__(self, db):
        self.db = db

    def add_item(self, role_name, item_code, count=1, bag_index=1):
        self.added.append((role_name, item_code, count, bag_index))
        return {"success": True, "item_id": "bag-item-1", "slot_index": 0}

    def remove_item(self, role_name, bag_index, slot_index, count=None):
        self.removed.append((role_name, bag_index, slot_index, count))
        return {"success": True}

    def load_inventory(self, role_name, bag_index):
        return [SimpleNamespace(slot_index=0, item_code="pot_hpmp", item_count=2, item_id="bag-item-1")]


class FakeMap:
    def __init__(self):
        self.items = {
            "loot-1": {
                "x": 120,
                "y": 220,
                "itemId": "loot-1",
                "itemCode": "pot_hpmp",
                "itemCount": 2,
                "protectionTimeLeft": 0,
            }
        }


class FakeMapManager:
    def __init__(self):
        self.maps = {"m1": FakeMap()}

    def get_map(self, map_id):
        return self.maps.get(map_id)


class FakeServer:
    def __init__(self):
        self.map_manager = FakeMapManager()
        self.sessions = {}

    def _get_db(self):
        return object()


class FakeSession:
    def __init__(self, name="hero", map_id="m1"):
        self.server = FakeServer()
        self.account_id = f"account:{name}"
        self.player_data = {"name": name, "mapId": map_id, "posX": 100, "posY": 200}
        self.sent_packets = []
        self.logs = []
        self.item_added = []
        self.bag_checks = []
        self.server.sessions[name] = self

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_item_added_notify(self, added):
        self.item_added.append(added)

    def _send_bag_check(self, bag_index, items, empty_slots=None):
        self.bag_checks.append((bag_index, list(items), empty_slots or []))


class LootManagerTests(unittest.TestCase):
    def setUp(self):
        FakeInventoryManager.added = []
        FakeInventoryManager.removed = []

    @patch("inventory_manager.InventoryManager", FakeInventoryManager)
    def test_pickup_item_adds_to_bag_and_broadcasts_map_remove(self):
        session = FakeSession()
        handler = LootManager(session)

        handler.handle_pickup_item(PacketReader(pickup_payload()))

        self.assertEqual(FakeInventoryManager.added, [("hero", "pot_hpmp", 2, 1)])
        self.assertNotIn("loot-1", session.server.map_manager.get_map("m1").items)
        self.assertEqual(session.item_added, [[{"item_id": "loot-1", "item_code": "pot_hpmp", "count": 2}]])
        commands = [packet_command(packet) for packet in session.sent_packets]
        self.assertIn(MapCommandCode.MAP_ITEM_REMOVED_NOTIFY, commands)

    def test_spawn_loot_uses_map_item_added_as_fields(self):
        session = FakeSession()
        handler = LootManager(session)

        handler.spawn_loot_on_ground("m1", 321, 654, "pot_hpmp", 3)

        packets = [packet for packet in session.sent_packets if packet_command(packet) == MapCommandCode.MAP_ITEM_ADDED_NOTIFY]
        self.assertEqual(len(packets), 1)
        payload = packet_payload_reader(packets[0])
        self.assertEqual(payload.read_string(), "m1")
        obj_size = payload.read_unsigned_short()
        self.assertGreater(obj_size, 0)
        self.assertEqual(payload.read_short(), 321)
        self.assertEqual(payload.read_short(), 654)
        self.assertTrue(payload.read_string().startswith("loot_"))
        self.assertEqual(payload.read_string(), "pot_hpmp")
        self.assertEqual(payload.read_unsigned_byte(), 3)
        self.assertEqual(payload.read_byte(), 0)

    def test_drop_command_is_owned_by_loot_manager(self):
        registry = HandlerRegistry()
        _register_all_handlers(registry)

        registered = registry.get_registered_commands()
        self.assertEqual(registered[int(BagCommandCode.PLAYER_PICKUP_ITEM_REQ)], "LootManager.handle_pickup_item")
        self.assertEqual(registered[int(BagCommandCode.PLAYER_DROP_ITEM_REQ)], "LootManager.handle_drop_item")


if __name__ == "__main__":
    unittest.main()
