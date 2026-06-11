import os
import sys
import unittest


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.advanced_item_handler import AdvancedItemHandler
from handlers.registry import get_handler_registry
from protocol.commands import (
    AgentCommandCode,
    ArmoryCommandCode,
    ArtifactCommandCode,
    BoothCommandCode,
    EquipKindGrowCommandCode,
    TradeCommandCode,
    WardrobeCommandCode,
)
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader


def packet_command(packet):
    reader = PacketReader(packet)
    reader.read_varint()
    return reader.read_unsigned_short()


class FakeServer:
    def __init__(self):
        self.db = FakeDb()

    def _get_db(self):
        return self.db


class FakeDb:
    def __init__(self):
        self.kind = {}
        self.artifacts = []
        self.booths = {}

    def kind_grow_get(self, role_name, kind):
        return self.kind.get((role_name, kind), {"Kind": kind, "Level": 0, "Exp": 0, "TemperJson": None, "NewTemperJson": None})

    def kind_grow_save(self, role_name, kind, level, exp, temper=None, new_temper=None):
        row = {"Kind": kind, "Level": level, "Exp": exp, "TemperJson": "{}", "NewTemperJson": "{}"}
        self.kind[(role_name, kind)] = row
        return row

    def get_booth(self, owner):
        return self.booths.get(owner, {"IsBooth": False, "BoothTitle": "", "SellItems": [], "PurchaseItems": []})

    def artifact_update(self, role_name, equipment_id, **changes):
        self.artifacts.append((role_name, equipment_id, changes))
        return {"Success": True, **changes}

    def remove_inventory_item_by_id(self, role_name, item_id, count=None):
        return {"Success": True}


class FakeSession:
    def __init__(self):
        self.server = FakeServer()
        self.account_id = "account"
        self.player_data = {"name": "hero"}
        self.sent_packets = []
        self.logs = []

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)


class AdvancedItemHandlerTests(unittest.TestCase):
    def test_registry_owns_advanced_item_commands(self):
        registered = get_handler_registry().get_registered_commands()
        self.assertEqual(registered[int(EquipKindGrowCommandCode.KIND_GROW_BLESS_REQUEST)], "AdvancedItemHandler.handle_kind_grow_bless")
        self.assertEqual(registered[int(TradeCommandCode.PLAYER_INVITE_TRADE_REQUEST)], "AdvancedItemHandler.handle_invite_trade")
        self.assertEqual(registered[int(BoothCommandCode.BOOTH_VISIT_REQUEST)], "AdvancedItemHandler.handle_booth_visit")
        self.assertEqual(registered[int(AgentCommandCode.AGENT_LIST_ITEM_REQUEST)], "AdvancedItemHandler.handle_agent_list_item")
        self.assertEqual(registered[int(ArmoryCommandCode.PLAYER_ARMORY_UPGRADE_REQUEST)], "AdvancedItemHandler.handle_armory_upgrade")
        self.assertEqual(registered[int(WardrobeCommandCode.WARDROBE_UPLEVEL_REQUEST)], "AdvancedItemHandler.handle_wardrobe_uplevel")
        self.assertEqual(registered[int(ArtifactCommandCode.ARTIFACT_REFINE_REQUEST)], "AdvancedItemHandler.handle_artifact_refine")

    def test_simple_advanced_answers_are_emitted(self):
        session = FakeSession()
        handler = AdvancedItemHandler(session)

        bless = PacketBuilder()
        bless.write_unsigned_byte(1)
        bless.write_string("eq-1")
        handler.handle_kind_grow_bless(PacketReader(bless.get_bytes()))
        self.assertEqual(packet_command(session.sent_packets[-1]), EquipKindGrowCommandCode.KIND_GROW_BLESS_ANSWER)

        booth = PacketBuilder()
        booth.write_string("owner")
        handler.handle_booth_visit(PacketReader(booth.get_bytes()))
        self.assertEqual(packet_command(session.sent_packets[-1]), BoothCommandCode.BOOTH_VISIT_ANSWER)

        artifact = PacketBuilder()
        artifact.write_string("eq-1")
        artifact.write_byte(2)
        artifact.write_varint(0)
        handler.handle_artifact_refine(PacketReader(artifact.get_bytes()))
        self.assertEqual(packet_command(session.sent_packets[-1]), ArtifactCommandCode.ARTIFACT_REFINE_ANSWER)


if __name__ == "__main__":
    unittest.main()
