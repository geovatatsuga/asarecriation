import sys
sys.path.insert(0, "/c/Users/jeova/Downloads/Converted on 2022-06-04/server_py")
from unittest.mock import patch, MagicMock
from types import SimpleNamespace

class FakeInventoryManager:
    removed = []
    bought_item = None
    def __init__(self, db):
        self.db = db
    def load_inventory(self, role_name, bag_index):
        print(f"load_inventory called: role={role_name}, bag={bag_index}")
        if self.bought_item is not None:
            return [self.bought_item]
        if self.removed:
            return []
        return [SimpleNamespace(slot_index=0, item_code='pot_hpmp', item_id='item-1')]
    def get_item_definition(self, item_code):
        print(f"get_item_definition called: {item_code}")
        return {'ItemType': 1, 'BuyPrice': 10, 'ExtraDataJson': '{"hpAddFixed": 30, "mpAddFixed": 20, "cooldownMs": 2000}'}
    def remove_item(self, role_name, bag_index, slot_index, count):
        print(f"remove_item called: {role_name}, {bag_index}, {slot_index}, {count}")
        self.removed.append((role_name, bag_index, slot_index, count))
        return {'success': True}

class FakeSession:
    def __init__(self):
        self.server = MagicMock()
        self.server._get_db = MagicMock(return_value=MagicMock())
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

with patch('inventory_manager.InventoryManager', FakeInventoryManager):
    from handlers.inventory_handler import InventoryHandler
    from protocol.packet_reader import PacketReader
    from protocol.packet_builder import PacketBuilder
    
    def use_item_payload(bag_index=1, slot_index=0, map_id="m1"):
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
    
    session = FakeSession()
    handler = InventoryHandler(session)
    
    print("Calling handle_use_item...")
    handler.handle_use_item(PacketReader(use_item_payload()))
    print("Done!")
    print(f"hp: {session.player_data['hp']}, mp: {session.player_data['mp']}")
    print(f"removed: {FakeInventoryManager.removed}")
    print(f"sent packets: {len(session.sent_packets)}")
