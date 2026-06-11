from copy import deepcopy
from typing import Dict

from handlers.base_handler import BaseHandler
from protocol.commands import PetCommandCode
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader
from servers.world_server import write_transportable_object


DEFAULT_PET = {
    "petId": "pet-1",
    "petCode": "p01",
    "name": "Mascote Fofinho",
    "sex": 0,
    "generation": 1,
    "level": 1,
    "exp": 0,
    "life": 1000,
    "loyalty": 100,
    "enhanceLevel": 0,
    "openedSkillNum": 1,
    "learnedSkillList": [],
    "fateSkillList": [],
    "freeAttrPt": 4,
    "hp": 150,
    "mp": 50,
    "equipment": [],
    "buffInfo": [],
    "attributes": {
        "strength": 10,
        "wisdom": 10,
        "agility": 10,
        "vitality": 10,
        "hpMax": 150,
        "mpMax": 50,
        "physicalAttack": 15.0,
        "magicAttack": 10.0,
        "hitValue": 30,
        "hitRate": 0.95,
        "critValue": 10,
        "critRate": 0.05,
        "strengthApt": 1000,
        "wisdomApt": 1000,
        "agilityApt": 1000,
        "vitalityApt": 1000,
        "subdueMul": 1.0,
        "damageAbsorbRatio": 0.0,
        "damageAbsorbMul": 1.0,
        "levelUpAttrPt": 0.0,
        "growthRate": 100,
    },
}


def _write_pet_attributes_raw(builder: PacketBuilder, attrs=None):
    attrs = attrs or DEFAULT_PET["attributes"]
    builder.write_int(int(attrs.get("strength", 0)))
    builder.write_int(int(attrs.get("wisdom", 0)))
    builder.write_int(int(attrs.get("agility", 0)))
    builder.write_int(int(attrs.get("vitality", 0)))
    builder.write_int(int(attrs.get("hpMax", 0)))
    builder.write_int(int(attrs.get("mpMax", 0)))
    builder.write_double(float(attrs.get("physicalAttack", 0.0)))
    builder.write_double(float(attrs.get("magicAttack", 0.0)))
    builder.write_int(int(attrs.get("hitValue", 0)))
    builder.write_float(float(attrs.get("hitRate", 0.0)))
    builder.write_int(int(attrs.get("critValue", 0)))
    builder.write_float(float(attrs.get("critRate", 0.0)))
    builder.write_int(int(attrs.get("strengthApt", 0)))
    builder.write_int(int(attrs.get("wisdomApt", 0)))
    builder.write_int(int(attrs.get("agilityApt", 0)))
    builder.write_int(int(attrs.get("vitalityApt", 0)))
    builder.write_float(float(attrs.get("subdueMul", 1.0)))
    builder.write_float(float(attrs.get("damageAbsorbRatio", 0.0)))
    builder.write_float(float(attrs.get("damageAbsorbMul", 1.0)))
    builder.write_float(float(attrs.get("levelUpAttrPt", 0.0)))
    builder.write_short(int(attrs.get("growthRate", 0)))


def write_pet_attributes(builder: PacketBuilder, attrs=None):
    write_transportable_object(builder, _write_pet_attributes_raw, attrs)


def _write_pet_skill_slot_raw(builder: PacketBuilder, skill):
    builder.write_string(skill.get("skillCode", ""))
    builder.write_byte(int(skill.get("skillLevel", 1)))


def _write_pet_skill_array(builder: PacketBuilder, skills):
    builder.write_varint(len(skills or []))
    for skill in skills or []:
        write_transportable_object(builder, _write_pet_skill_slot_raw, skill)


def _write_empty_transportable_array(builder: PacketBuilder, values):
    builder.write_varint(len(values or []))


def _write_pet_full_info_raw(builder: PacketBuilder, pet):
    attrs = pet.get("attributes") or DEFAULT_PET["attributes"]
    builder.write_string(pet.get("petId", ""))
    builder.write_string(pet.get("petCode", "p01"))

    write_pet_attributes(builder, pet.get("baseAttributes") or attrs)
    write_pet_attributes(builder, pet.get("fusionAttributes") or attrs)
    write_pet_attributes(builder, pet.get("cultivateAttributes") or attrs)
    write_pet_attributes(builder, attrs)

    _write_empty_transportable_array(builder, pet.get("equipment", []))
    builder.write_string(pet.get("name", "Mascote Fofinho"))
    builder.write_byte(int(pet.get("sex", 0)))
    builder.write_byte(int(pet.get("generation", 1)))
    builder.write_short(int(pet.get("level", 1)))
    builder.write_int(int(pet.get("exp", 0)))
    builder.write_int(int(pet.get("life", 1000)))
    builder.write_short(int(pet.get("loyalty", 100)))
    builder.write_byte(int(pet.get("enhanceLevel", 0)))
    builder.write_byte(int(pet.get("openedSkillNum", 1)))
    _write_pet_skill_array(builder, pet.get("learnedSkillList", []))
    _write_pet_skill_array(builder, pet.get("fateSkillList", []))
    builder.write_int(int(pet.get("freeAttrPt", 0)))
    builder.write_int(int(pet.get("hp", attrs.get("hpMax", 0))))
    builder.write_varint(int(pet.get("mp", attrs.get("mpMax", 0))))
    _write_empty_transportable_array(builder, pet.get("buffInfo", []))


def write_pet_full_info(builder: PacketBuilder, pet):
    write_transportable_object(builder, _write_pet_full_info_raw, pet)


def write_null_transportable(builder: PacketBuilder):
    builder.write_unsigned_short(0)


def read_string_short_map(reader: PacketReader):
    start = reader.pos
    count = reader.read_varint()
    values = {}
    try:
        for _ in range(count):
            values[reader.read_string()] = reader.read_short()
    except Exception:
        reader.pos = start
        return {}
    return values


class PetHandler(BaseHandler):
    PET_CHECK_NOTIFY = PetCommandCode.PET_CHECK_NOTIFY
    PET_VIEW_REQUEST = PetCommandCode.PET_VIEW_REQUEST
    PET_ATTR_INT_CHANGE_NOTIFY = PetCommandCode.PET_ATTR_INT_CHANGE_NOTIFY
    PET_RENAME_REQUEST = PetCommandCode.PET_RENAME_REQUEST
    PET_FORGET_SKILL_REQUEST = PetCommandCode.PET_FORGET_SKILL_REQUEST
    PET_ASSIGN_ATTR_REQUEST = PetCommandCode.PET_ASSIGN_ATTR_REQUEST
    PET_LEARN_SKILL_REQUEST = PetCommandCode.PET_LEARN_SKILL_REQUEST
    PET_LEARN_SKILL_ANSWER = PetCommandCode.PET_LEARN_SKILL_ANSWER
    PET_USE_SKILL_NOTIFY = PetCommandCode.PET_USE_SKILL_NOTIFY
    PET_HP_CHANGE_NOTIFY = PetCommandCode.PET_HP_CHANGE_NOTIFY
    PLAYER_SET_PET_ACTION_MODE_REQUEST = PetCommandCode.PLAYER_SET_PET_ACTION_MODE_REQUEST
    PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY = PetCommandCode.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY
    PET_ENHANCE_REQUEST = PetCommandCode.PET_ENHANCE_REQUEST
    PET_ENHANCE_ANSWER = PetCommandCode.PET_ENHANCE_ANSWER
    PET_FUSION_REQUEST = PetCommandCode.PET_FUSION_REQUEST
    PET_FUSION_ANSWER = PetCommandCode.PET_FUSION_ANSWER
    PET_REMOVE_EQUIPMENT_REQUEST = PetCommandCode.PET_REMOVE_EQUIPMENT_REQUEST
    PET_DECOMPOSE_REQUEST = PetCommandCode.PET_DECOMPOSE_REQUEST

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PET_VIEW_REQUEST: "handle_pet_view_request",
            cls.PET_RENAME_REQUEST: "handle_pet_rename_request",
            cls.PET_FORGET_SKILL_REQUEST: "handle_pet_forget_skill_request",
            cls.PET_ASSIGN_ATTR_REQUEST: "handle_pet_assign_attr_request",
            cls.PET_LEARN_SKILL_REQUEST: "handle_pet_learn_skill_request",
            cls.PLAYER_SET_PET_ACTION_MODE_REQUEST: "handle_player_set_pet_action_mode_request",
            cls.PET_ENHANCE_REQUEST: "handle_pet_enhance_request",
            cls.PET_FUSION_REQUEST: "handle_pet_fusion_request",
            cls.PET_REMOVE_EQUIPMENT_REQUEST: "handle_pet_remove_equipment_request",
            cls.PET_DECOMPOSE_REQUEST: "handle_pet_decompose_request",
        }

    def _pet_store(self):
        if self.player_data is None:
            return {}
        pets = self.player_data.setdefault("pets", {})
        if not pets:
            pet = deepcopy(DEFAULT_PET)
            pets[pet["petId"]] = pet
        return pets

    def _get_pet(self, pet_id, create=True):
        pets = self._pet_store()
        if not pet_id or pet_id == "0":
            active_id = self.player_data.get("activePetId") if self.player_data else None
            pet_id = active_id or DEFAULT_PET["petId"]
        if pet_id not in pets and create:
            pet = deepcopy(DEFAULT_PET)
            pet["petId"] = pet_id
            pets[pet_id] = pet
        return pets.get(pet_id)

    def _send_pet_check(self, pet=None, is_using=True):
        builder = PacketBuilder()
        builder.write_bool(bool(is_using))
        if pet:
            write_pet_full_info(builder, pet)
        else:
            write_null_transportable(builder)
        self.send_packet(builder.build(self.PET_CHECK_NOTIFY))

    def _send_attr_change(self, pet_id, attr, changed, current):
        builder = PacketBuilder()
        builder.write_string(pet_id)
        builder.write_byte(attr)
        builder.write_int(changed)
        builder.write_int(current)
        self.send_packet(builder.build(self.PET_ATTR_INT_CHANGE_NOTIFY))

    def handle_pet_view_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            self.log(f"PET_VIEW_REQUEST: pet_id={pet_id}")
            if not self.player_data:
                return

            if not pet_id or pet_id == "0":
                self.player_data["activePetId"] = ""
                self.player_data["petBkHp"] = 0
                self.player_data["petBkHpMax"] = 0
                self.player_data["petBkMp"] = 0
                self.player_data["petBkMpMax"] = 0
                self._send_pet_check(None, True)
                return

            pet = self._get_pet(pet_id)
            attrs = pet.get("attributes", {})
            self.player_data["activePetId"] = pet["petId"]
            self.player_data["petBkHp"] = int(pet.get("hp", 0))
            self.player_data["petBkHpMax"] = int(attrs.get("hpMax", 0))
            self.player_data["petBkMp"] = int(pet.get("mp", 0))
            self.player_data["petBkMpMax"] = int(attrs.get("mpMax", 0))
            self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet view request: {e}")

    def handle_pet_rename_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            new_name = reader.read_string()
            self.log(f"PET_RENAME_REQUEST: pet_id={pet_id}, new_name={new_name}")
            pet = self._get_pet(pet_id, create=False)
            if pet and new_name.strip():
                pet["name"] = new_name.strip()[:24]
                self._send_pet_check(pet, True)
            else:
                self._send_pet_check(None, False)
        except Exception as e:
            self.log(f"Error handling pet rename request: {e}")
            self._send_pet_check(None, False)

    def handle_pet_forget_skill_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            skill_code = reader.read_string()
            self.log(f"PET_FORGET_SKILL_REQUEST: pet_id={pet_id}, skill_code={skill_code}")
            pet = self._get_pet(pet_id, create=False)
            if not pet:
                self._send_pet_check(None, False)
                return

            pet["learnedSkillList"] = [
                skill for skill in pet.get("learnedSkillList", [])
                if skill.get("skillCode") != skill_code
            ]
            self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet forget skill request: {e}")
            self._send_pet_check(None, False)

    def handle_pet_assign_attr_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            str_added = reader.read_int()
            wis_added = reader.read_int()
            agi_added = reader.read_int()
            vit_added = reader.read_int()
            self.log(
                "PET_ASSIGN_ATTR_REQUEST: "
                f"pet_id={pet_id}, str={str_added}, wis={wis_added}, agi={agi_added}, vit={vit_added}"
            )
            pet = self._get_pet(pet_id, create=False)
            total = max(0, str_added) + max(0, wis_added) + max(0, agi_added) + max(0, vit_added)
            if not pet or total > int(pet.get("freeAttrPt", 0)):
                self._send_pet_check(None, False)
                return

            attrs = pet.setdefault("attributes", deepcopy(DEFAULT_PET["attributes"]))
            changes = [(1, "strength", str_added), (2, "wisdom", wis_added), (3, "agility", agi_added), (4, "vitality", vit_added)]
            for attr_code, attr_name, delta in changes:
                if delta <= 0:
                    continue
                attrs[attr_name] = int(attrs.get(attr_name, 0)) + delta
                self._send_attr_change(pet["petId"], attr_code, delta, attrs[attr_name])
            pet["freeAttrPt"] = int(pet.get("freeAttrPt", 0)) - total
            self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet assign attr request: {e}")
            self._send_pet_check(None, False)

    def handle_pet_learn_skill_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            skill_kind = reader.read_byte()
            skill_code = reader.read_string()
            self.log(
                f"PET_LEARN_SKILL_REQUEST: pet_id={pet_id}, skill_kind={skill_kind}, skill_code={skill_code}"
            )
            pet = self._get_pet(pet_id, create=False)
            if not pet or not skill_code:
                self._send_pet_learn_skill_answer(pet_id, skill_kind, skill_code, 0)
                return

            skills = pet.setdefault("learnedSkillList", [])
            existing = next((skill for skill in skills if skill.get("skillCode") == skill_code), None)
            if existing:
                existing["skillLevel"] = max(1, int(existing.get("skillLevel", 1)))
                level = existing["skillLevel"]
            else:
                level = 1
                skills.append({"skillCode": skill_code, "skillLevel": level, "skillKind": skill_kind})
            pet["openedSkillNum"] = max(int(pet.get("openedSkillNum", 1)), len(skills))
            self._send_pet_learn_skill_answer(pet["petId"], skill_kind, skill_code, level)
            self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet learn skill request: {e}")
            self._send_pet_learn_skill_answer("", 0, "", 0)

    def _send_pet_learn_skill_answer(self, pet_id, skill_kind, skill_code, skill_level):
        builder = PacketBuilder()
        builder.write_string(pet_id)
        builder.write_byte(int(skill_kind))
        builder.write_string(skill_code)
        builder.write_byte(int(skill_level))
        self.send_packet(builder.build(self.PET_LEARN_SKILL_ANSWER))

    def handle_player_set_pet_action_mode_request(self, reader: PacketReader):
        try:
            mode = reader.read_byte()
            self.log(f"PLAYER_SET_PET_ACTION_MODE_REQUEST: mode={mode}")
            if self.player_data is not None:
                self.player_data["petActionMode"] = mode

            builder = PacketBuilder()
            builder.write_byte(mode)
            self.send_packet(builder.build(self.PLAYER_PET_ACTION_MODE_CHANGE_NOTIFY))
        except Exception as e:
            self.log(f"Error handling player set pet action mode request: {e}")

    def handle_pet_enhance_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            current_level = reader.read_byte()
            self.log(f"PET_ENHANCE_REQUEST: pet_id={pet_id}, current_level={current_level}")
            pet = self._get_pet(pet_id, create=False)
            success = bool(pet)
            if success:
                pet["enhanceLevel"] = max(int(pet.get("enhanceLevel", 0)), current_level) + 1
            self._send_pet_enhance_answer(pet_id, pet.get("petCode", "") if pet else "", pet.get("enhanceLevel", 0) if pet else current_level, success)
            if pet:
                self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet enhance request: {e}")
            self._send_pet_enhance_answer("", "", 0, False)

    def _send_pet_enhance_answer(self, pet_id, pet_code, enhance_level, success):
        builder = PacketBuilder()
        builder.write_string(pet_id)
        builder.write_string(pet_code)
        builder.write_byte(int(enhance_level))
        builder.write_bool(success)
        self.send_packet(builder.build(self.PET_ENHANCE_ANSWER))

    def handle_pet_fusion_request(self, reader: PacketReader):
        try:
            man_pet_id = reader.read_string()
            woman_pet_id = reader.read_string()
            fusion_items = read_string_short_map(reader)
            protect_item = reader.read_string() if reader.remaining() else ""
            self.log(
                "PET_FUSION_REQUEST: "
                f"man={man_pet_id}, woman={woman_pet_id}, items={fusion_items}, protect={protect_item}"
            )
            man_pet = self._get_pet(man_pet_id, create=False)
            woman_pet = self._get_pet(woman_pet_id, create=False)
            success = bool(man_pet and woman_pet and man_pet_id != woman_pet_id)
            if success:
                man_pet["generation"] = max(int(man_pet.get("generation", 1)), int(woman_pet.get("generation", 1))) + 1
                self._pet_store().pop(woman_pet_id, None)
            result_pet = man_pet if success else None
            self._send_pet_fusion_answer(
                man_pet_id,
                result_pet.get("petCode", "") if result_pet else "",
                result_pet.get("generation", 0) if result_pet else 0,
                success,
            )
            if result_pet:
                self._send_pet_check(result_pet, True)
        except Exception as e:
            self.log(f"Error handling pet fusion request: {e}")
            self._send_pet_fusion_answer("", "", 0, False)

    def _send_pet_fusion_answer(self, pet_id, pet_code, generation, success):
        builder = PacketBuilder()
        builder.write_string(pet_id)
        builder.write_string(pet_code)
        builder.write_byte(int(generation))
        builder.write_bool(success)
        self.send_packet(builder.build(self.PET_FUSION_ANSWER))

    def handle_pet_remove_equipment_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            equipment_kind = reader.read_unsigned_short()
            to_bag_item_index = reader.read_byte()
            self.log(
                "PET_REMOVE_EQUIPMENT_REQUEST: "
                f"pet_id={pet_id}, equipment_kind={equipment_kind}, to_bag={to_bag_item_index}"
            )
            pet = self._get_pet(pet_id, create=False)
            if not pet:
                self._send_pet_check(None, False)
                return
            pet["equipment"] = [
                item for item in pet.get("equipment", [])
                if item.get("equipmentKind") != equipment_kind
            ]
            self._send_pet_check(pet, True)
        except Exception as e:
            self.log(f"Error handling pet remove equipment request: {e}")
            self._send_pet_check(None, False)

    def handle_pet_decompose_request(self, reader: PacketReader):
        try:
            pet_id = reader.read_string()
            self.log(f"PET_DECOMPOSE_REQUEST: pet_id={pet_id}")
            pets = self._pet_store()
            pet = pets.pop(pet_id, None)
            if self.player_data and self.player_data.get("activePetId") == pet_id:
                self.player_data["activePetId"] = ""
            self._send_pet_check(None, bool(pet))
        except Exception as e:
            self.log(f"Error handling pet decompose request: {e}")
            self._send_pet_check(None, False)
