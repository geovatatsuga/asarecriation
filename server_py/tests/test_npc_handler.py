import os
import sys
import unittest


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.npc_handler import NpcHandler
from protocol.commands import NpcCommandCode
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


def assemble_payload(rule_index, base_ids=None, added_ids=None):
    builder = PacketBuilder()
    builder.write_string("npc@a1")
    builder.write_varint(0)
    builder.write_unsigned_short(rule_index)
    builder.write_varint(len(added_ids or []))
    for item_id in added_ids or []:
        builder.write_string(item_id)
    builder.write_varint(len(base_ids or []))
    for item_id in base_ids or []:
        builder.write_string(item_id)
    builder.write_bool(False)
    builder.write_string("")
    return builder.get_bytes()


class FakeDb:
    def __init__(self):
        self.inventory = [
            {"ItemId": "wing-1", "ItemCode": "bb0800", "ItemCount": 1, "BagIndex": 1, "SlotIndex": 0},
            {"ItemId": "stone-1", "ItemCode": "sc1000", "ItemCount": 4, "BagIndex": 1, "SlotIndex": 1},
        ]

    def execute_query(self, query, params=()):
        if "TB_RoleInventory" in query:
            return list(self.inventory)
        if "TB_ItemDefinition" in query:
            return [{"MaxStack": 99}]
        if "BagCapacityPlayer" in query:
            return [{"BagCapacityPlayer": 36}]
        if "SELECT Id FROM TB_Role" in query:
            return [{"Id": 1}]
        return []

    def execute_proc(self, proc_name, params):
        if proc_name == "SP_AddItemToInventory":
            item_id = f"new-{params['ItemCode']}"
            self.inventory.append({
                "ItemId": item_id,
                "ItemCode": params["ItemCode"],
                "ItemCount": params["ItemCount"],
                "BagIndex": params.get("BagIndex", 1),
                "SlotIndex": len(self.inventory),
            })
            return [{"Success": True, "ErrorMsg": "", "SlotIndex": len(self.inventory) - 1, "ItemId": item_id}]
        return [{"Success": False, "ErrorMsg": "unknown proc"}]

    def get_inventory_item_by_id(self, role_name, item_id):
        for item in self.inventory:
            if item["ItemId"] == item_id:
                return item
        return None

    def remove_inventory_item_by_id(self, role_name, item_id, count=None):
        item = self.get_inventory_item_by_id(role_name, item_id)
        if not item:
            return {"Success": False, "ErrorMsg": "Item nao encontrado"}
        remove_count = int(count if count is not None else item["ItemCount"])
        item["ItemCount"] -= remove_count
        if item["ItemCount"] <= 0:
            self.inventory.remove(item)
        return {"Success": True, "ErrorMsg": "", "RemainingCount": max(0, item.get("ItemCount", 0))}


class FakeServer:
    def __init__(self):
        self.db = FakeDb()

    def _get_db(self):
        return self.db


class FakeSession:
    def __init__(self, level=20):
        self.server = FakeServer()
        self.account_id = "account"
        self.player_data = {"name": "hero", "level": level}
        self.sent_packets = []
        self.logs = []
        self.bag_syncs = []
        self.added_notifies = []

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_bag_check(self, bag_index, items):
        self.bag_syncs.append((bag_index, items))

    def _send_item_added_notify(self, added):
        self.added_notifies.append(added)


class NpcHandlerTests(unittest.TestCase):
    def setUp(self):
        NpcHandler._assemble_rules = {
            "300": {
                "ruleIndex": "300",
                "type": "Asas",
                "condition": {"roleLevel>=": 20},
                "baseItems": {"bb0800": 1, "sc1000": 4},
                "targetItems": {"bb0801": 1},
                "itemBase": "bb0800",
                "itemUpgrade": "bb0801",
            }
        }

    def tearDown(self):
        NpcHandler._assemble_rules = None

    def test_assemble_fails_when_level_is_too_low(self):
        session = FakeSession(level=19)
        handler = NpcHandler(session)

        handler.handle_assemble_item(PacketReader(assemble_payload(300, base_ids=["wing-1"], added_ids=["stone-1"])))

        self.assertEqual(packet_command(session.sent_packets[-1]), NpcCommandCode.NPC_ASSEMBLE_ITEM_ANSWER)
        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertEqual(payload.read_unsigned_short(), 300)
        self.assertFalse(payload.read_bool())
        self.assertTrue(any("Nivel insuficiente" in log for log in session.logs))

    def test_assemble_fails_when_materials_are_missing(self):
        session = FakeSession(level=20)
        session.server.db.inventory = session.server.db.inventory[:1]
        handler = NpcHandler(session)

        handler.handle_assemble_item(PacketReader(assemble_payload(300, base_ids=["wing-1"])))

        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertEqual(payload.read_unsigned_short(), 300)
        self.assertFalse(payload.read_bool())
        self.assertFalse(any(item["ItemCode"] == "bb0801" for item in session.server.db.inventory))

    def test_assemble_consumes_materials_and_adds_upgrade(self):
        session = FakeSession(level=20)
        handler = NpcHandler(session)

        handler.handle_assemble_item(PacketReader(assemble_payload(300, base_ids=["wing-1"], added_ids=["stone-1"])))

        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertEqual(payload.read_unsigned_short(), 300)
        self.assertTrue(payload.read_bool())
        codes = [item["ItemCode"] for item in session.server.db.inventory]
        self.assertNotIn("bb0800", codes)
        self.assertNotIn("sc1000", codes)
        self.assertIn("bb0801", codes)
        self.assertTrue(session.bag_syncs)
        self.assertTrue(session.added_notifies)


if __name__ == "__main__":
    unittest.main()
