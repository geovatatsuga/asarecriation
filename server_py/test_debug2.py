import sys
sys.path.insert(0, "/c/Users/jeova/Downloads/Converted on 2022-06-04/server_py")
import unittest
from unittest.mock import patch
from types import SimpleNamespace

class FakeInventoryManager:
    removed = []
    bought_item = None
    def __init__(self, db):
        self.db = db
    def load_inventory(self, role_name, bag_index):
        if self.bought_item is not None:
            return [self.bought_item]
        if self.removed:
            return []
        return [SimpleNamespace(slot_index=0, item_code='pot_hpmp', item_id='item-1')]
    def get_item_definition(self, item_code):
        return {'ItemType': 1, 'BuyPrice': 10, 'ExtraDataJson': '{"hpAddFixed": 30, "mpAddFixed": 20, "cooldownMs": 2000}'}
    def remove_item(self, role_name, bag_index, slot_index, count):
        self.removed.append((role_name, bag_index, slot_index, count))
        return {'success': True}

class FakeServer:
    def __init__(self):
        self.remote_hp = []
        self.remote_mp = []
        self.db = FakeDb()

    def _get_db(self):
        return self.db

    def broadcast_remote_hp(self, session, amount, item_code, critical=False):
        self.remote_hp.append((amount, item_code, critical))

    def broadcast_remote_mp(self, session, amount, item_code):
        self.remote_mp.append((amount, item_code))

class FakeSession:
    def __init__(self):
        self.server = FakeServer()
        self.account_id = "account"
        self.sent_packets = []
        self.logs = []
        self.bag_checks = []
        self.player_data = {
            "name": "hero",
            "mapId": "m1",
            "hp": 40,
            "hpMax": 100,
            "mp": 10,
            "mpMax": 50,
        }

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_bag_check(self, bag_index, items, empty_slots=None):
        self.bag_checks.append((bag_index, list(items), empty_slots or []))

    def _send_equipment_check_notify(self, items):
        self.equipment_check = list(items)

class FakeDb:
    def __init__(self):
        self.purchases = []
        self.renewed = []
        self.repaired = []

    def renew_inventory_item(self, role_name, item_id, renew_rule_index):
        self.renewed.append((role_name, item_id, renew_rule_index))
        return {"Success": True}

    def purchase_items(self, role_name, rows, currency, bag_index):
        self.purchases.append((role_name, rows, currency, bag_index))
        return {
            "Success": True,
            "NewCurrency": 90,
            "Added": [{"SlotIndex": 0, "ItemId": "bought-1", "ItemCode": "pot_hpmp", "ItemCount": 1}],
        }

    def get_equipment_repair_info(self, role_name, equipment_id):
        return {
            "Success": True,
            "IsWornOut": False,
            "IsFullDurability": False,
            "RepairGold": 15,
            "PerfectRepairGold": 30,
        }

    def repair_equipment(self, role_name, equipment_id, is_perfect):
        self.repaired.append((role_name, equipment_id, is_perfect))
        return {"Success": True, "NewGold": 70, "Durability": 100}

def packet_command(packet):
    from protocol.packet_reader import PacketReader
    reader = PacketReader(packet)
    reader.read_varint()
    return reader.read_unsigned_short()

def use_item_payload(bag_index=1, slot_index=0, map_id="m1"):
    from protocol.packet_builder import PacketBuilder
    builder = PacketBuilder()
    builder.write_unsigned_byte(bag_index)
    builder.write_unsigned_byte(slot_index)
    builder.write_string(map_id)
    builder.write_unsigned_short(4)
    builder.write_short(0)
    builder.write_short(0)
    builder.write_string("")
    builder.write_varint(0)
    return builder.get_bytes()

class InventoryHandlerTests(unittest.TestCase):
    def setUp(self):
        FakeInventoryManager.removed = []
        FakeInventoryManager.bought_item = None

    @patch("inventory_manager.InventoryManager", FakeInventoryManager)
    def test_potion_restores_hp_mp_and_starts_item_cooldown(self):
        print("Starting test...")
        session = FakeSession()
        from handlers.inventory_handler import InventoryHandler
        handler = InventoryHandler(session)
        print("Handler created")
        
        from protocol.packet_reader import PacketReader
        handler.handle_use_item(PacketReader(use_item_payload()))
        print("handle_use_item returned")

        self.assertEqual(session.player_data["hp"], 70)
        self.assertEqual(session.player_data["mp"], 30)
        self.assertEqual(FakeInventoryManager.removed, [("hero", 1, 0, 1)])
        commands = [packet_command(packet) for packet in session.sent_packets]
        self.assertIn(550, commands)  # PLAYER_HP_CHANGE_NOTIFY
        self.assertIn(551, commands)  # PLAYER_MP_CHANGE_NOTIFY
        self.assertIn(5125, commands)  # PLAYER_ITEM_USED_NOTIFY
        self.assertIn(5130, commands)  # PLAYER_ITEM_CD_CHECK_NOTIFY

        handler.handle_use_item(PacketReader(use_item_payload()))

        self.assertEqual(FakeInventoryManager.removed, [("hero", 1, 0, 1)])
        self.assertEqual(session.player_data["hp"], 70)
        self.assertEqual(session.player_data["mp"], 30)

if __name__ == "__main__":
    unittest.main()
