import os
import sys
import unittest
from unittest.mock import patch


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.shop_handler import ShopHandler
from protocol.commands import ShopCommandCode
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader
from servers.world_server import write_transportable_object


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


def shop_buy_payload():
    builder = PacketBuilder()
    builder.write_string("npc1@x")
    builder.write_varint(1)
    builder.write_byte(0)
    builder.write_varint(1)

    def write_buy_item(raw):
        raw.write_string("pot_hpmp")
        raw.write_unsigned_byte(2)
        raw.write_byte(0)

    write_transportable_object(builder, write_buy_item)
    builder.write_short(123)
    return builder.get_bytes()


class FakeDb:
    def __init__(self):
        self.purchases = []

    def purchase_items(self, role_name, purchase_rows, currency, bag_index):
        self.purchases.append((role_name, purchase_rows, currency, bag_index))
        total_spent = sum(row["count"] * row["unit_price"] for row in purchase_rows)
        new_gold = 100 - total_spent
        return {
            "Success": True,
            "Spent": total_spent,
            "NewCurrency": new_gold,
            "Added": [{"ItemId": "item-1", "ItemCode": "pot_hpmp", "ItemCount": 2}],
        }


class FakeInventoryManager:
    def __init__(self, db):
        self.db = db

    def get_item_definition(self, code):
        return {"BuyPrice": 10}

    def load_inventory(self, role_name, bag_index):
        return []


class FakeServer:
    def __init__(self):
        self.db = FakeDb()

    def _get_db(self):
        return self.db


class FakeSession:
    def __init__(self):
        self.server = FakeServer()
        self.account_id = "account"
        self.player_data = {"name": "hero", "mapId": "m1", "gold": 100}
        self.sent_packets = []
        self.logs = []
        self.gold_changes = []
        self.bag_checks = []
        self.added_notifies = []

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_gold_change(self, amount):
        self.gold_changes.append(amount)

    def _send_bag_check(self, bag_index, items):
        self.bag_checks.append((bag_index, list(items)))

    def _send_item_added_notify(self, added):
        self.added_notifies.append(added)


class ShopHandlerTests(unittest.TestCase):
    @patch("inventory_manager.InventoryManager", FakeInventoryManager)
    def test_shop_buy_uses_as_answer_2824_with_item_code_and_count(self):
        session = FakeSession()
        handler = ShopHandler(session)

        with patch.object(handler, "_allowed_items_for_npc", return_value={"pot_hpmp"}):
            handler.handle_buy_item_gold(PacketReader(shop_buy_payload()))

        self.assertEqual(
            session.server.db.purchases,
            [("hero", [{"item_code": "pot_hpmp", "count": 2, "unit_price": 10}], "Gold", 1)],
        )
        self.assertEqual(session.player_data["gold"], 80)
        self.assertEqual(session.gold_changes, [-20])
        self.assertEqual(session.added_notifies, [[{"item_id": "item-1", "item_code": "pot_hpmp", "count": 2}]])

        buy_packets = [packet for packet in session.sent_packets if packet_command(packet) == ShopCommandCode.SHOP_BUY_ITEM_ANSWER]
        self.assertEqual(len(buy_packets), 1)
        payload = packet_payload_reader(buy_packets[0])
        self.assertEqual(payload.read_string(), "pot_hpmp")
        self.assertEqual(payload.read_unsigned_byte(), 2)
        self.assertEqual(payload.remaining(), 0)

    @patch("inventory_manager.InventoryManager", FakeInventoryManager)
    def test_lead_info_and_var_shop_have_registered_responses(self):
        session = FakeSession()
        handler = ShopHandler(session)

        handler.handle_lead_item_info(PacketReader(b""))
        self.assertEqual(packet_command(session.sent_packets[-1]), ShopCommandCode.LEAD_ITEM_INFO_NOTIFY)

        payload = PacketBuilder()
        payload.write_string("shop")
        payload.write_int(1)
        payload.write_string("pot_hpmp")
        handler.handle_var_shop_buy(PacketReader(payload.get_bytes()))
        commands = [packet_command(packet) for packet in session.sent_packets]
        self.assertIn(ShopCommandCode.SHOP_BUY_ITEM_ANSWER, commands)
        self.assertIn(ShopCommandCode.VAR_SHOP_BUY_ANSWER, commands)




class FakeDbWithSell:
    def __init__(self):
        self.purchases = []
        self.sales = []

    def purchase_items(self, role_name, purchase_rows, currency, bag_index):
        self.purchases.append((role_name, purchase_rows, currency, bag_index))
        total_spent = sum(row["count"] * row["unit_price"] for row in purchase_rows)
        new_gold = 100 - total_spent
        return {
            "Success": True,
            "Spent": total_spent,
            "NewCurrency": new_gold,
            "Added": [{"ItemId": "item-1", "ItemCode": purchase_rows[0]["item_code"], "ItemCount": purchase_rows[0]["count"]}],
        }

    def sell_inventory_items(self, role_name, bag_index, slot_indexes):
        self.sales.append((role_name, bag_index, slot_indexes))
        return {
            "Success": True,
            "GoldAdded": 50,
            "NewGold": 150,
        }


class FakeInventoryManagerWithFallback:
    def __init__(self, db):
        self.db = db

    def get_item_definition(self, code):
        # Simulate item only in iie.json (not in TB_ItemDefinition)
        if code == "zq700":
            return {
                "ItemCode": "zq700",
                "ItemName": "Capa do Aventureiro - Ofensiva",
                "BuyPrice": 5848,
                "SellPrice": 1462,
                "ItemType": 4,
                "ItemSubType": 1039,
            }
        return {"BuyPrice": 10}

    def load_inventory(self, role_name, bag_index):
        # Return an item in slot 5 for sell testing
        from dataclasses import dataclass
        @dataclass
        class ItemInfo:
            inventory_id: int
            slot_index: int
            item_id: str
            item_code: str
            item_count: int
            is_bound: bool = False
            enhance_level: int = 0
            extra_data: str = None
        if role_name == "hero":
            return [ItemInfo(1, 5, "item-sell-1", "zq700", 1)]
        return []


class FakeServerWithSell:
    def __init__(self):
        self.db = FakeDbWithSell()

    def _get_db(self):
        return self.db


class FakeSessionWithSell:
    def __init__(self):
        self.server = FakeServerWithSell()
        self.account_id = "account"
        self.player_data = {"name": "hero", "mapId": "m1", "gold": 100}
        self.sent_packets = []
        self.logs = []
        self.gold_changes = []
        self.bag_checks = []
        self.added_notifies = []

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)

    def _send_gold_change(self, amount):
        self.gold_changes.append(amount)

    def _send_bag_check(self, bag_index, items):
        self.bag_checks.append((bag_index, list(items)))

    def _send_item_added_notify(self, added):
        self.added_notifies.append(added)


def shop_buy_payload_item(item_code, count=1):
    builder = PacketBuilder()
    builder.write_string("npc1@x")
    builder.write_varint(1)
    builder.write_byte(0)
    builder.write_varint(1)

    def write_buy_item(raw):
        raw.write_string(item_code)
        raw.write_unsigned_byte(count)
        raw.write_byte(0)

    write_transportable_object(builder, write_buy_item)
    builder.write_short(123)
    return builder.get_bytes()


def shop_sell_payload(slot_indexes):
    builder = PacketBuilder()
    builder.write_string("npc1@x")
    builder.write_varint(1)
    builder.write_byte(0)
    builder.write_byte(1)  # bag_index
    builder.write_varint(len(slot_indexes))
    for slot in slot_indexes:
        builder.write_unsigned_byte(slot)
    builder.write_short(123)
    return builder.get_bytes()


@patch("inventory_manager.InventoryManager", FakeInventoryManagerWithFallback)
class ShopHandlerIieFallbackTests(unittest.TestCase):
    def test_shop_buy_with_item_only_in_iie_json(self):
        """Test buying an item that exists only in iie.json, not in TB_ItemDefinition"""
        session = FakeSessionWithSell()
        handler = ShopHandler(session)

        with patch.object(handler, "_allowed_items_for_npc", return_value={"zq700"}):
            handler.handle_buy_item_gold(PacketReader(shop_buy_payload_item("zq700", 1)))

        self.assertEqual(
            session.server.db.purchases,
            [("hero", [{"item_code": "zq700", "count": 1, "unit_price": 5848}], "Gold", 1)],
        )
        self.assertEqual(session.player_data["gold"], -5748)
        self.assertEqual(session.gold_changes, [-5848])

    def test_shop_sell_with_item_only_in_iie_json(self):
        """Test selling an item that exists only in iie.json, not in TB_ItemDefinition"""
        session = FakeSessionWithSell()
        handler = ShopHandler(session)

        with patch.object(handler, "_allowed_items_for_npc", return_value={"zq700"}):
            handler.handle_sell_item(PacketReader(shop_sell_payload([5])))

        self.assertEqual(
            session.server.db.sales,
            [("hero", 1, [5])],
        )
        self.assertEqual(session.player_data["gold"], 150)
        self.assertEqual(session.gold_changes, [50])


if __name__ == "__main__":
    unittest.main()
