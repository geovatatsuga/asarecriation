import os
import sys
import unittest


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from handlers.pet_handler import PetHandler
from protocol.commands import PetCommandCode
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


def string_payload(*values):
    builder = PacketBuilder()
    for value in values:
        builder.write_string(value)
    return builder.get_bytes()


class FakeServer:
    def _get_db(self):
        return object()


class FakeSession:
    def __init__(self):
        self.server = FakeServer()
        self.account_id = "account"
        self.sent_packets = []
        self.logs = []
        self.player_data = {"name": "hero", "mapId": "m1"}

    def send_packet(self, packet):
        self.sent_packets.append(packet)

    def log(self, message):
        self.logs.append(message)


class PetHandlerTests(unittest.TestCase):
    def test_view_pet_sends_transportable_pet_full_info(self):
        session = FakeSession()
        handler = PetHandler(session)

        handler.handle_pet_view_request(PacketReader(string_payload("pet-9")))

        self.assertEqual(packet_command(session.sent_packets[-1]), PetCommandCode.PET_CHECK_NOTIFY)
        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertTrue(payload.read_bool())
        object_length = payload.read_unsigned_short()
        self.assertGreater(object_length, 0)
        object_reader = PacketReader(payload.read_bytes(object_length))
        self.assertEqual(object_reader.read_string(), "pet-9")
        self.assertEqual(object_reader.read_string(), "p01")
        self.assertEqual(session.player_data["activePetId"], "pet-9")
        self.assertEqual(session.player_data["petBkHp"], 150)

    def test_learn_skill_uses_as_payload_and_answer_shape(self):
        session = FakeSession()
        handler = PetHandler(session)
        handler._get_pet("pet-1")

        builder = PacketBuilder()
        builder.write_string("pet-1")
        builder.write_byte(2)
        builder.write_string("pet_fire")
        handler.handle_pet_learn_skill_request(PacketReader(builder.get_bytes()))

        self.assertEqual(session.player_data["pets"]["pet-1"]["learnedSkillList"][0]["skillCode"], "pet_fire")
        answer = next(packet for packet in session.sent_packets if packet_command(packet) == PetCommandCode.PET_LEARN_SKILL_ANSWER)
        payload = packet_payload_reader(answer)
        self.assertEqual(payload.read_string(), "pet-1")
        self.assertEqual(payload.read_byte(), 2)
        self.assertEqual(payload.read_string(), "pet_fire")
        self.assertEqual(payload.read_byte(), 1)
        self.assertEqual(payload.remaining(), 0)

    def test_assign_attr_reads_four_ints_and_updates_free_points(self):
        session = FakeSession()
        handler = PetHandler(session)
        handler._get_pet("pet-1")

        builder = PacketBuilder()
        builder.write_string("pet-1")
        builder.write_int(1)
        builder.write_int(1)
        builder.write_int(0)
        builder.write_int(0)
        handler.handle_pet_assign_attr_request(PacketReader(builder.get_bytes()))

        pet = session.player_data["pets"]["pet-1"]
        self.assertEqual(pet["attributes"]["strength"], 11)
        self.assertEqual(pet["attributes"]["wisdom"], 11)
        self.assertEqual(pet["freeAttrPt"], 2)
        commands = [packet_command(packet) for packet in session.sent_packets]
        self.assertIn(PetCommandCode.PET_ATTR_INT_CHANGE_NOTIFY, commands)
        self.assertIn(PetCommandCode.PET_CHECK_NOTIFY, commands)

    def test_action_mode_request_has_only_byte_payload(self):
        session = FakeSession()
        handler = PetHandler(session)

        builder = PacketBuilder()
        builder.write_byte(2)
        handler.handle_player_set_pet_action_mode_request(PacketReader(builder.get_bytes()))

        self.assertEqual(session.player_data["petActionMode"], 2)
        self.assertEqual(packet_command(session.sent_packets[-1]), PetCommandCode.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY)
        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertEqual(payload.read_byte(), 2)
        self.assertEqual(payload.remaining(), 0)

    def test_enhance_and_fusion_answers_match_as_fields(self):
        session = FakeSession()
        handler = PetHandler(session)
        handler._get_pet("pet-a")
        handler._get_pet("pet-b")

        enhance = PacketBuilder()
        enhance.write_string("pet-a")
        enhance.write_byte(0)
        handler.handle_pet_enhance_request(PacketReader(enhance.get_bytes()))

        enhance_answer = next(packet for packet in session.sent_packets if packet_command(packet) == PetCommandCode.PET_ENHANCE_ANSWER)
        payload = packet_payload_reader(enhance_answer)
        self.assertEqual(payload.read_string(), "pet-a")
        self.assertEqual(payload.read_string(), "p01")
        self.assertEqual(payload.read_byte(), 1)
        self.assertTrue(payload.read_bool())

        fusion = PacketBuilder()
        fusion.write_string("pet-a")
        fusion.write_string("pet-b")
        fusion.write_varint(1)
        fusion.write_string("stone")
        fusion.write_short(1)
        fusion.write_string("")
        handler.handle_pet_fusion_request(PacketReader(fusion.get_bytes()))

        fusion_answer = next(packet for packet in session.sent_packets if packet_command(packet) == PetCommandCode.PET_FUSION_ANSWER)
        payload = packet_payload_reader(fusion_answer)
        self.assertEqual(payload.read_string(), "pet-a")
        self.assertEqual(payload.read_string(), "p01")
        self.assertEqual(payload.read_byte(), 2)
        self.assertTrue(payload.read_bool())
        self.assertNotIn("pet-b", session.player_data["pets"])

    def test_decompose_removes_pet_and_sends_null_pet(self):
        session = FakeSession()
        handler = PetHandler(session)
        handler._get_pet("pet-1")

        handler.handle_pet_decompose_request(PacketReader(string_payload("pet-1")))

        self.assertNotIn("pet-1", session.player_data["pets"])
        payload = packet_payload_reader(session.sent_packets[-1])
        self.assertTrue(payload.read_bool())
        self.assertEqual(payload.read_unsigned_short(), 0)


if __name__ == "__main__":
    unittest.main()
