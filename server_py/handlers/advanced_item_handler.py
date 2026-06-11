import json
from typing import Dict, List

from handlers.base_handler import BaseHandler
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
from servers.world_server import write_transportable_object


def read_string_array(reader: PacketReader):
    return [reader.read_string() for _ in range(reader.read_varint())]


def skip_byte_array(reader: PacketReader):
    for _ in range(reader.read_varint()):
        reader.read_byte()


def read_transportable(reader: PacketReader) -> PacketReader:
    size = reader.read_unsigned_short()
    return PacketReader(reader.read_bytes(size))


def read_brief_info(reader: PacketReader) -> Dict:
    obj = read_transportable(reader)
    return {
        "item_id": obj.read_string(),
        "item_code": obj.read_string(),
        "count": obj.read_unsigned_byte(),
    }


def write_brief_info(builder: PacketBuilder, item_id: str, item_code: str, count: int):
    builder.write_string(str(item_id or ""))
    builder.write_string(str(item_code or ""))
    builder.write_unsigned_byte(min(max(int(count or 0), 0), 255))


def read_booth_item(reader: PacketReader) -> Dict:
    obj = read_transportable(reader)
    return {
        "item_index": obj.read_byte(),
        "item_id": obj.read_string(),
        "item_code": obj.read_string(),
        "count": obj.read_unsigned_byte(),
        "price": obj.read_int(),
    }


def write_booth_item(builder: PacketBuilder, item: Dict):
    builder.write_byte(int(item.get("ItemIndex", item.get("item_index", 0)) or 0))
    builder.write_string(str(item.get("ItemId", item.get("item_id", "")) or ""))
    builder.write_string(str(item.get("ItemCode", item.get("item_code", "")) or ""))
    builder.write_unsigned_byte(min(max(int(item.get("ItemCount", item.get("count", 1)) or 1), 0), 255))
    builder.write_int(int(item.get("ItemPrice", item.get("price", 0)) or 0))


def read_trade_item(reader: PacketReader) -> Dict:
    obj = read_transportable(reader)
    bag_index = obj.read_byte()
    item_index = obj.read_unsigned_byte()
    item_info = read_brief_info(obj)
    return {"bag_index": bag_index, "item_index": item_index, **item_info}


def write_agent_item(builder: PacketBuilder, item: Dict):
    builder.write_int(int(item.get("AgentRecId", 0) or 0))
    builder.write_string(str(item.get("ItemId", "") or ""))
    builder.write_string(str(item.get("ItemCode", "") or ""))
    builder.write_unsigned_byte(min(max(int(item.get("ItemCount", 1) or 1), 0), 255))
    builder.write_int(int(item.get("Price", 0) or 0))
    builder.write_byte(int(item.get("State", 0) or 0))
    builder.write_unsigned_short(0)


def write_wardrobe_info(builder: PacketBuilder, item: Dict):
    builder.write_unsigned_short(int(item.get("WardrobeIndex", 0) or 0))
    write_transportable_object(
        builder,
        write_brief_info,
        item.get("ItemId", ""),
        item.get("ItemCode", ""),
        int(item.get("ItemCount", 1) or 1),
    )


def write_kind_grow_info(builder: PacketBuilder, info: Dict):
    builder.write_unsigned_byte(int(info.get("Kind", info.get("kind", 0)) or 0))
    builder.write_unsigned_byte(int(info.get("Level", info.get("level", 0)) or 0))
    builder.write_int(int(info.get("Exp", info.get("exp", 0)) or 0))
    temper = info.get("TemperJson") or info.get("temper") or "{}"
    new_temper = info.get("NewTemperJson") or info.get("newTemper") or "{}"
    try:
        temper = json.loads(temper) if isinstance(temper, str) else temper
    except Exception:
        temper = {}
    try:
        new_temper = json.loads(new_temper) if isinstance(new_temper, str) else new_temper
    except Exception:
        new_temper = {}
    for values in (temper or {}, new_temper or {}):
        builder.write_varint(len(values))
        for key, value in values.items():
            builder.write_short(int(key))
            builder.write_float(float(value))


class AdvancedItemHandler(BaseHandler):
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            EquipKindGrowCommandCode.KIND_GROW_ADD_EXP_REQUEST: "handle_kind_grow_add_exp",
            EquipKindGrowCommandCode.KIND_GROW_BREACH_REQUEST: "handle_kind_grow_breach",
            EquipKindGrowCommandCode.KIND_GROW_BLESS_REQUEST: "handle_kind_grow_bless",
            EquipKindGrowCommandCode.KIND_GROW_TEMPER_REQUEST: "handle_kind_grow_temper",
            EquipKindGrowCommandCode.KIND_GROW_TEMPER_SAVE_REQUEST: "handle_kind_grow_temper_save",
            TradeCommandCode.PLAYER_INVITE_TRADE_REQUEST: "handle_invite_trade",
            TradeCommandCode.PLAYER_PROCESS_INVITE_TRADE_REQUEST_REPLY: "handle_trade_invite_reply",
            TradeCommandCode.PLAYER_TRADE_ITEM_SUBMIT_REQUEST: "handle_trade_item_submit",
            TradeCommandCode.PLAYER_TRADE_CONFIRM_REQUEST: "handle_trade_confirm",
            TradeCommandCode.PLAYER_TRADE_CANCEL_REQUEST: "handle_trade_cancel",
            TradeCommandCode.PLAYER_TRADE_CHECK_REQUEST: "handle_trade_check",
            BoothCommandCode.BOOTH_START_REQUEST: "handle_booth_start",
            BoothCommandCode.BOOTH_STOP_REQUEST: "handle_booth_stop",
            BoothCommandCode.BOOTH_SET_TITLE_REQUEST: "handle_booth_set_title",
            BoothCommandCode.BOOTH_VISIT_REQUEST: "handle_booth_visit",
            BoothCommandCode.BOOTH_BUY_ITEM_REQUEST: "handle_booth_buy_item",
            BoothCommandCode.BOOTH_PURCHASE_ITEM_REQUEST: "handle_booth_purchase_item",
            AgentCommandCode.AGENT_SELL_ITEM_REQUEST: "handle_agent_sell_item",
            AgentCommandCode.AGENT_CANCEL_ITEM_REQUEST: "handle_agent_rec_id_only",
            AgentCommandCode.AGENT_BUY_ITEM_REQUEST: "handle_agent_rec_id_only",
            AgentCommandCode.AGENT_LIST_ITEM_REQUEST: "handle_agent_list_item",
            AgentCommandCode.AGENT_VIEW_MY_ITEMS_REQUEST: "handle_agent_view_my_items",
            AgentCommandCode.AGENT_TAKE_BACK_REQUEST: "handle_agent_rec_id_only",
            ArmoryCommandCode.PLAYER_ARMORY_REMOVE_REQUEST: "handle_armory_remove",
            ArmoryCommandCode.PLAYER_ARMORY_UPGRADE_REQUEST: "handle_armory_upgrade",
            WardrobeCommandCode.WARDROBE_ADD_REQUEST: "handle_wardrobe_add",
            WardrobeCommandCode.WARDROBE_REMOVE_REQUEST: "handle_wardrobe_remove",
            WardrobeCommandCode.WARDROBE_UPLEVEL_REQUEST: "handle_wardrobe_uplevel",
            ArtifactCommandCode.ARTIFACT_HOLE_REQUEST: "handle_artifact_hole",
            ArtifactCommandCode.ARTIFACT_EMBED_REQUEST: "handle_artifact_embed",
            ArtifactCommandCode.ARTIFACT_DISEMBED_REQUEST: "handle_artifact_disembed",
            ArtifactCommandCode.ARTIFACT_REFINE_REQUEST: "handle_artifact_refine",
            ArtifactCommandCode.ARTIFACT_SOUL_REQUEST: "handle_artifact_soul",
            ArtifactCommandCode.ARTIFACT_SOUL_MOVE_REQUEST: "handle_artifact_soul_move",
            ArtifactCommandCode.ARTIFACT_DECOMPOSE_REQUEST: "handle_artifact_decompose",
            ArtifactCommandCode.ARTIFACT_UPGRADE_REQUEST: "handle_artifact_upgrade",
            ArtifactCommandCode.ARTIFACT_FUSION_REQUEST: "handle_artifact_fusion",
            ArtifactCommandCode.ARTIFACT_WASH_REQUEST: "handle_artifact_wash",
            ArtifactCommandCode.ARTIFACT_LETTERING_REQUEST: "handle_artifact_lettering",
            ArtifactCommandCode.ARTIFACT_UP_EQU_EXP_REQUEST: "handle_artifact_up_equ_exp",
        }

    def _send_kind_grow_info_answer(self, command, kind):
        info = self.get_db().kind_grow_get(self.role_name, kind)
        builder = PacketBuilder()
        write_transportable_object(builder, write_kind_grow_info, info)
        self.send_packet(builder.build(command))

    def handle_kind_grow_add_exp(self, reader):
        kind = reader.read_unsigned_byte()
        equ_ids = read_string_array(reader)
        info = self.get_db().kind_grow_get(self.role_name, kind)
        exp = int(info.get("Exp") or 0) + max(1, len(equ_ids)) * 10
        level = int(info.get("Level") or 0)
        while exp >= (level + 1) * 100:
            level += 1
        self.get_db().kind_grow_save(self.role_name, kind, level, exp)
        self._send_kind_grow_info_answer(EquipKindGrowCommandCode.KIND_GROW_ADD_EXP_ANSWER, kind)

    def handle_kind_grow_breach(self, reader):
        kind = reader.read_unsigned_byte()
        info = self.get_db().kind_grow_get(self.role_name, kind)
        level = int(info.get("Level") or 0) + 1
        self.get_db().kind_grow_save(self.role_name, kind, level, int(info.get("Exp") or 0))
        self._send_kind_grow_info_answer(EquipKindGrowCommandCode.KIND_GROW_BREACH_ANSWER, kind)

    def handle_kind_grow_bless(self, reader):
        kind = reader.read_unsigned_byte()
        equip_id = reader.read_string()
        info = self.get_db().kind_grow_get(self.role_name, kind)
        self.get_db().kind_grow_save(self.role_name, kind, int(info.get("Level") or 0), int(info.get("Exp") or 0) + 25)
        builder = PacketBuilder()
        builder.write_string(equip_id)
        self.send_packet(builder.build(EquipKindGrowCommandCode.KIND_GROW_BLESS_ANSWER))

    def handle_kind_grow_temper(self, reader):
        kind = reader.read_unsigned_byte()
        locked = []
        for _ in range(reader.read_varint()):
            locked.append(reader.read_short())
        info = self.get_db().kind_grow_get(self.role_name, kind)
        new_temper = {str(100 + len(locked)): round(0.01 * (int(info.get("Level") or 0) + 1), 4)}
        self.get_db().kind_grow_save(self.role_name, kind, int(info.get("Level") or 0), int(info.get("Exp") or 0), info.get("TemperJson"), new_temper)
        self._send_kind_grow_info_answer(EquipKindGrowCommandCode.KIND_GROW_TEMPER_ANSWER, kind)

    def handle_kind_grow_temper_save(self, reader):
        kind = reader.read_unsigned_byte()
        info = self.get_db().kind_grow_get(self.role_name, kind)
        self.get_db().kind_grow_save(self.role_name, kind, int(info.get("Level") or 0), int(info.get("Exp") or 0), info.get("NewTemperJson"), {})
        self._send_kind_grow_info_answer(EquipKindGrowCommandCode.KIND_GROW_TEMPER_SAVE_ANSWER, kind)

    def handle_invite_trade(self, reader):
        target = reader.read_string()
        builder = PacketBuilder()
        builder.write_string(target)
        builder.write_bool(False)
        self.send_packet(builder.build(TradeCommandCode.PLAYER_INVITE_TRADE_ANSWER))

    def handle_trade_invite_reply(self, reader):
        source = reader.read_string()
        reader.read_bool()
        builder = PacketBuilder()
        builder.write_string(source)
        builder.write_byte(0)
        self.send_packet(builder.build(TradeCommandCode.PLAYER_TRADE_END_NOTIFY))

    def handle_trade_item_submit(self, reader):
        other = reader.read_string()
        gold = reader.read_int()
        items = [read_trade_item(reader) for _ in range(reader.read_varint())]
        if self.player_data is not None:
            self.player_data["tradeOffer"] = {"other": other, "gold": gold, "items": items}
        builder = PacketBuilder()
        builder.write_string(self.role_name)
        builder.write_int(gold)
        builder.write_varint(len(items))
        for item in items:
            write_transportable_object(
                builder,
                write_brief_info,
                item.get("item_id", ""),
                item.get("item_code", ""),
                item.get("count", 1),
            )
        self.send_packet(builder.build(TradeCommandCode.PLAYER_TRADE_ITEM_SUBMIT_NOTIFY))

    def handle_trade_confirm(self, reader):
        other = reader.read_string()
        builder = PacketBuilder()
        builder.write_string(other)
        builder.write_byte(0)
        self.send_packet(builder.build(TradeCommandCode.PLAYER_TRADE_END_NOTIFY))

    def handle_trade_cancel(self, reader):
        other = reader.read_string()
        builder = PacketBuilder()
        builder.write_string(other)
        builder.write_byte(0)
        self.send_packet(builder.build(TradeCommandCode.PLAYER_TRADE_END_NOTIFY))

    def handle_trade_check(self, reader):
        reader.read_string()
        builder = PacketBuilder()
        builder.write_string("")
        self.send_packet(builder.build(TradeCommandCode.PLAYER_TRADE_CHECK_ANSWER))

    def _send_booth_check(self):
        booth = self.get_db().get_booth(self.role_name)
        builder = PacketBuilder()
        builder.write_bool(bool(booth.get("IsBooth")))
        builder.write_string(booth.get("BoothTitle", ""))
        builder.write_varint(len(booth.get("SellItems", [])))
        for item in booth.get("SellItems", []):
            write_transportable_object(builder, write_booth_item, item)
        builder.write_varint(len(booth.get("PurchaseItems", [])))
        for item in booth.get("PurchaseItems", []):
            write_transportable_object(builder, write_booth_item, item)
        self.send_packet(builder.build(BoothCommandCode.BOOTH_CHECK_NOTIFY))

    def handle_booth_start(self, reader):
        title = reader.read_string()
        sell_items = [read_booth_item(reader) for _ in range(reader.read_varint())]
        purchase_items = [read_booth_item(reader) for _ in range(reader.read_varint())]
        self.get_db().set_booth(self.role_name, title, True, sell_items, purchase_items)
        if self.player_data is not None:
            self.player_data["isBooth"] = True
            self.player_data["boothTitle"] = title
        self._send_booth_check()

    def handle_booth_stop(self, reader):
        self.get_db().set_booth(self.role_name, "", False)
        if self.player_data is not None:
            self.player_data["isBooth"] = False
        self._send_booth_check()

    def handle_booth_set_title(self, reader):
        title = reader.read_string()
        booth = self.get_db().get_booth(self.role_name)
        self.get_db().set_booth(self.role_name, title, booth.get("IsBooth", False), booth.get("SellItems", []), booth.get("PurchaseItems", []))
        if self.player_data is not None:
            self.player_data["boothTitle"] = title
        self._send_booth_check()

    def handle_booth_visit(self, reader):
        owner = reader.read_string()
        booth = self.get_db().get_booth(owner)
        builder = PacketBuilder()
        builder.write_string(owner)
        builder.write_bool(bool(booth.get("IsBooth")))
        builder.write_string(booth.get("BoothTitle", ""))
        builder.write_varint(len(booth.get("SellItems", [])))
        for item in booth.get("SellItems", []):
            write_transportable_object(builder, write_booth_item, item)
        builder.write_varint(len(booth.get("PurchaseItems", [])))
        for item in booth.get("PurchaseItems", []):
            write_transportable_object(builder, write_booth_item, item)
        self.send_packet(builder.build(BoothCommandCode.BOOTH_VISIT_ANSWER))

    def handle_booth_buy_item(self, reader):
        owner = reader.read_string()
        buy_item = read_booth_item(reader)
        result = self.get_db().booth_buy_item(self.role_name, owner, int(buy_item.get("item_index", 0)))
        if not result.get("Success"):
            self.log(f"Booth buy failed: {result.get('ErrorMsg')}")
            return
        if self.player_data is not None:
            self.player_data["gold"] = result.get("NewGold", self.player_data.get("gold", 0))
        builder = PacketBuilder()
        write_transportable_object(builder, write_booth_item, result["Item"])
        self.send_packet(builder.build(BoothCommandCode.BOOTH_ITEM_SOLD_NOTIFY))
        self._send_booth_check()

    def handle_booth_purchase_item(self, reader):
        owner = reader.read_string()
        purchase_item = read_booth_item(reader)
        self.log(f"Booth purchase request recorded: owner={owner}, item={purchase_item.get('item_code')}")
        builder = PacketBuilder()
        write_transportable_object(builder, write_booth_item, purchase_item)
        self.send_packet(builder.build(BoothCommandCode.BOOTH_ITEM_PURCHASED_NOTIFY))

    def handle_agent_sell_item(self, reader):
        reader.read_string()
        skip_byte_array(reader)
        bag_index = reader.read_byte()
        item_index = reader.read_unsigned_byte()
        price = reader.read_int()
        result = self.get_db().agent_sell_item(self.role_name, bag_index, item_index, price)
        if not result.get("Success"):
            self.log(f"Agent sell failed: {result.get('ErrorMsg')}")
        self._send_agent_my_items()

    def handle_agent_rec_id_only(self, reader):
        cmd_pos = reader.pos
        reader.read_string()
        skip_byte_array(reader)
        rec_id = reader.read_int()
        # 2866 and 2872 both return the item to the seller; 2867 buys it for the current player.
        if rec_id:
            result = self.get_db().agent_buy_item(self.role_name, rec_id)
            if not result.get("Success"):
                result = self.get_db().agent_cancel_or_take_back(self.role_name, rec_id)
            if self.player_data is not None and result.get("NewGold") is not None:
                self.player_data["gold"] = result["NewGold"]
        self._send_agent_my_items()

    def handle_agent_list_item(self, reader):
        reader.read_string()
        skip_byte_array(reader)
        subtype = reader.read_unsigned_short()
        name = reader.read_string()
        page = reader.read_short()
        items = self.get_db().list_agent_items(None, subtype, name)
        builder = PacketBuilder()
        builder.write_unsigned_short(subtype)
        builder.write_string(name)
        builder.write_short(page)
        builder.write_varint(len(items))
        for item in items:
            write_transportable_object(builder, write_agent_item, item)
        self.send_packet(builder.build(AgentCommandCode.AGENT_LIST_ITEM_ANSWER))

    def handle_agent_view_my_items(self, reader):
        reader.read_string()
        skip_byte_array(reader)
        self._send_agent_my_items()

    def _send_agent_my_items(self):
        items = self.get_db().list_agent_items(self.role_name)
        builder = PacketBuilder()
        builder.write_varint(len(items))
        for item in items:
            write_transportable_object(builder, write_agent_item, item)
        self.send_packet(builder.build(AgentCommandCode.AGENT_VIEW_MY_ITEMS_ANSWER))

    def handle_armory_remove(self, reader):
        reader.read_string()
        if reader.remaining():
            reader.read_byte()
        builder = PacketBuilder()
        builder.write_varint(0)
        self.send_packet(builder.build(ArmoryCommandCode.PLAYER_ARMORY_PROPERTY_NOTIFY))

    def handle_armory_upgrade(self, reader):
        result = self.get_db().armory_upgrade(self.role_name, 1)
        exp = int(result.get("ArmoryExp", 1))
        level = int(result.get("ArmoryLevel", 1))
        if self.player_data is not None:
            self.player_data["armoryExp"] = exp
        builder = PacketBuilder()
        builder.write_int(exp)
        self.send_packet(builder.build(ArmoryCommandCode.PLAYER_ARMORY_UPGRADE_ANSWER))
        notify = PacketBuilder()
        notify.write_varint(0)
        notify.write_byte(level)
        notify.write_int(exp)
        self.send_packet(notify.build(ArmoryCommandCode.PLAYER_ARMORY_UPGRADE_NOTIFY))

    def handle_wardrobe_add(self, reader):
        item_id = reader.read_string()
        result = self.get_db().wardrobe_add(self.role_name, item_id)
        if not result.get("Success"):
            self.log(f"Wardrobe add failed: {result.get('ErrorMsg')}")
        self._send_wardrobe_items()

    def handle_wardrobe_remove(self, reader):
        index = reader.read_unsigned_short()
        item_id = reader.read_string()
        result = self.get_db().wardrobe_remove(self.role_name, index, item_id)
        if not result.get("Success"):
            self.log(f"Wardrobe remove failed: {result.get('ErrorMsg')}")
        self._send_wardrobe_items()

    def handle_wardrobe_uplevel(self, reader):
        result = self.get_db().wardrobe_uplevel(self.role_name)
        level = int(result.get("Level", 1))
        count = int(result.get("Count", 0))
        if self.player_data is not None:
            self.player_data["wardrobeLevel"] = level
        builder = PacketBuilder()
        builder.write_short(level)
        builder.write_unsigned_short(count)
        self.send_packet(builder.build(WardrobeCommandCode.WARDROBE_UPLEVEL_ANSWER))

    def _send_wardrobe_items(self):
        items = self.get_db().list_wardrobe(self.role_name)
        builder = PacketBuilder()
        builder.write_varint(len(items))
        for item in items:
            write_transportable_object(builder, write_wardrobe_info, item)
        builder.write_varint(0)
        self.send_packet(builder.build(WardrobeCommandCode.WARDROBE_ITEMS_NOTIFY))

    def handle_artifact_hole(self, reader):
        equipment_id = reader.read_string()
        hole = reader.read_byte()
        self.get_db().artifact_update(self.role_name, equipment_id, HoleCount=max(1, int(hole) + 1))
        self._send_artifact_bool(ArtifactCommandCode.ARTIFACT_HOLE_ANSWER, equipment_id, True)

    def handle_artifact_embed(self, reader):
        equipment_id = reader.read_string()
        gem_index = reader.read_unsigned_byte()
        hole = reader.read_byte()
        self.get_db().artifact_update(self.role_name, equipment_id, HoleCount=max(1, int(hole) + 1))
        self._send_artifact_bool(ArtifactCommandCode.ARTIFACT_EMBED_ANSWER, equipment_id, True)

    def handle_artifact_disembed(self, reader):
        equipment_id = reader.read_string()
        hole = reader.read_byte()
        self.get_db().artifact_update(self.role_name, equipment_id, HoleCount=max(0, int(hole)))
        self._send_artifact_bool(ArtifactCommandCode.ARTIFACT_DISEMBED_ANSWER, equipment_id, True)

    def handle_artifact_refine(self, reader):
        equipment_id = reader.read_string()
        level = reader.read_byte()
        materials = read_string_array(reader)
        for item_id in materials:
            self.get_db().remove_inventory_item_by_id(self.role_name, item_id, 1)
        new_level = min(255, int(level) + 1)
        self.get_db().artifact_update(self.role_name, equipment_id, RefineLevel=new_level)
        builder = PacketBuilder()
        builder.write_string(equipment_id)
        builder.write_byte(new_level)
        builder.write_bool(True)
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_REFINE_ANSWER))

    def handle_artifact_soul(self, reader):
        equipment_id = reader.read_string()
        self.get_db().artifact_update(self.role_name, equipment_id, SoulLevel=1)
        builder = PacketBuilder()
        builder.write_bool(True)
        builder.write_string(equipment_id)
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_SOUL_ANSWER))

    def handle_artifact_soul_move(self, reader):
        lose_id = reader.read_string()
        get_id = reader.read_string()
        self.get_db().artifact_update(self.role_name, lose_id, SoulLevel=0)
        self.get_db().artifact_update(self.role_name, get_id, SoulLevel=1)
        builder = PacketBuilder()
        builder.write_string(lose_id)
        builder.write_string(get_id)
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_SOUL_MOVE_ANSWER))

    def handle_artifact_decompose(self, reader):
        for equipment_id in read_string_array(reader):
            self.get_db().remove_inventory_item_by_id(self.role_name, equipment_id)
        self.get_db().add_item_to_inventory(self.role_name, "artifactDust", 1, 1)

    def handle_artifact_upgrade(self, reader):
        base = reader.read_string()
        materials = read_string_array(reader)
        for item_id in materials:
            if item_id != base:
                self.get_db().remove_inventory_item_by_id(self.role_name, item_id, 1)
        state = self.get_db().artifact_update(self.role_name, base, EquLevel=1)
        builder = PacketBuilder()
        builder.write_string(base)
        builder.write_string("")
        builder.write_bool(True)
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_UPGRADE_ANSWER))

    def handle_artifact_fusion(self, reader):
        base = reader.read_string()
        stuff = reader.read_string()
        self.get_db().remove_inventory_item_by_id(self.role_name, stuff, 1)
        self.get_db().artifact_update(self.role_name, base, HoleCount=1)
        self._send_artifact_bool(ArtifactCommandCode.ARTIFACT_FUSION_ANSWER, base, True)

    def handle_artifact_wash(self, reader):
        equipment_id = reader.read_string()
        state = self.get_db().artifact_update(self.role_name, equipment_id, WashPoint=1.0)
        builder = PacketBuilder()
        builder.write_string(equipment_id)
        builder.write_float(float(state.get("WashPoint", 1.0)))
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_WASH_ANSWER))

    def handle_artifact_lettering(self, reader):
        equipment_id = reader.read_string()
        word = reader.read_string()
        self.get_db().artifact_update(self.role_name, equipment_id, LetteringWord=word)
        builder = PacketBuilder()
        builder.write_string(equipment_id)
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_LETTERING_ANSWER))

    def handle_artifact_up_equ_exp(self, reader):
        equipment_id = reader.read_string()
        state = self.get_db().artifact_update(self.role_name, equipment_id, EquExp=10, EquLevel=1)
        builder = PacketBuilder()
        builder.write_string(equipment_id)
        builder.write_varint(int(state.get("EquExp", 10)))
        builder.write_byte(int(state.get("EquLevel", 1)))
        self.send_packet(builder.build(ArtifactCommandCode.ARTIFACT_UP_EQU_EXP_ANSWER))

    def _send_artifact_bool(self, command, equipment_id, success):
        builder = PacketBuilder()
        builder.write_string(equipment_id)
        builder.write_bool(success)
        self.send_packet(builder.build(command))
