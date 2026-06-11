import json
import os
from typing import Dict

from config import GAME_RESOURCES_DIR
from protocol.commands import ShopCommandCode
from protocol.packet_builder import PacketBuilder
from protocol.packet_reader import PacketReader
from .base_handler import BaseHandler


class ShopHandler(BaseHandler):
    _catalog = None

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            ShopCommandCode.SHOP_SELL_ITEM_REQ: "handle_sell_item",
            ShopCommandCode.SHOP_BUY_ITEM_REQ: "handle_buy_item_gold",
            ShopCommandCode.STORE_BUY_ITEM_REQ: "handle_buy_item_crystal",
            ShopCommandCode.LEAD_ITEM_INFO_REQ: "handle_lead_item_info",
            ShopCommandCode.LEAD_BUY_ITEM_REQ: "handle_lead_buy_item",
            ShopCommandCode.VIP_SHOP_BUY_ITEM_REQ: "handle_vip_shop_buy_item",
            ShopCommandCode.REWARD_SHOP_BUY_REQ: "handle_reward_shop_buy",
            ShopCommandCode.VAR_SHOP_BUY_REQ: "handle_var_shop_buy",
        }

    def handle_buy_item_gold(self, reader: PacketReader):
        try:
            npc_id = reader.read_string()
            menu_indexes = self._read_byte_array(reader)
            items = self._read_buy_items(reader)
            if reader.remaining() >= 2:
                reader.read_short()
            allowed = self._allowed_items_for_npc(npc_id, menu_indexes)
            if not allowed:
                self._send_buy_error("Loja invalida")
                return
            purchase_rows = []
            for item in items:
                code, count = item["itemCode"], item["count"]
                if code not in allowed or count <= 0:
                    self._send_buy_error("Item nao vendido nesta loja")
                    return
                definition = self._definition(code)
                price = int(definition.get("BuyPrice") or 0) if definition else -1
                if price < 0:
                    self._send_buy_error("Item sem preco valido")
                    return
                purchase_rows.append({"item_code": code, "count": count, "unit_price": price})
            result = self.get_db().purchase_items(self.role_name, purchase_rows, "Gold", 1)
            if not result.get("Success"):
                self._send_buy_error(result.get("ErrorMsg", "Compra recusada"))
                return
            bought = [{"item_id": row.get("ItemId", ""), "item_code": row["ItemCode"], "count": row["ItemCount"]} for row in result["Added"]]
            self.player_data["gold"] = result["NewCurrency"]
            self.session._send_gold_change(-result["Spent"])
            self._sync_bag(bought)
            self._send_buy_result(bought)
        except Exception as exc:
            self.log(f"Erro ao comprar com gold: {exc}")
            self._send_buy_error("Pacote de compra invalido")

    def handle_buy_item_crystal(self, reader: PacketReader):
        try:
            items = self._read_buy_items(reader)
            if reader.remaining() > 0:
                reader.read_string()
            if reader.remaining() >= 2:
                reader.read_short()
            purchase_rows = []
            for item in items:
                code, count = item["itemCode"], item["count"]
                definition = self._definition(code)
                price = self._premium_price(definition)
                if price is None or count <= 0:
                    self._send_buy_error("Item indisponivel na loja premium")
                    return
                purchase_rows.append({"item_code": code, "count": count, "unit_price": price})
            result = self.get_db().purchase_items(self.role_name, purchase_rows, "Money", 1)
            if not result.get("Success"):
                self._send_buy_error(result.get("ErrorMsg", "Compra recusada"))
                return
            bought = [{"item_id": row.get("ItemId", ""), "item_code": row["ItemCode"], "count": row["ItemCount"]} for row in result["Added"]]
            self.player_data["money"] = result["NewCurrency"]
            self.session._send_money_change(-result["Spent"])
            self._sync_bag(bought)
            self._send_buy_result(bought)
        except Exception as exc:
            self.log(f"Erro ao comprar com cristal: {exc}")
            self._send_buy_error("Pacote de compra invalido")

    def handle_sell_item(self, reader: PacketReader):
        try:
            npc_id = reader.read_string()
            menu_indexes = self._read_byte_array(reader)
            bag_index = reader.read_byte()
            slots = [reader.read_unsigned_byte() for _ in range(reader.read_varint())]
            if reader.remaining() >= 2:
                reader.read_short()
            if not self._allowed_items_for_npc(npc_id, menu_indexes):
                self._send_sell_error("NPC nao aceita vendas")
                return
            result = self.get_db().sell_inventory_items(self.role_name, bag_index, slots)
            if not result.get("Success"):
                self._send_sell_error(result.get("ErrorMsg", "Venda recusada"))
                return
            self.player_data["gold"] = result["NewGold"]
            self.session._send_gold_change(result["GoldAdded"])
            self._sync_bag([])
            self._send_sell_result()
        except Exception as exc:
            self.log(f"Erro ao vender: {exc}")
            self._send_sell_error("Pacote de venda invalido")

    def handle_lead_item_info(self, reader: PacketReader):
        builder = PacketBuilder()
        builder.write_int(0)      # nextRefreshTimes
        builder.write_varint(0)   # leadItems
        self.send_packet(builder.build(ShopCommandCode.LEAD_ITEM_INFO_NOTIFY))

    def handle_lead_buy_item(self, reader: PacketReader):
        self._handle_direct_buy_list(reader, "Money")

    def handle_vip_shop_buy_item(self, reader: PacketReader):
        item_code = reader.read_string()
        count = reader.read_unsigned_byte()
        self._buy_simple_item(item_code, count, "Money")

    def handle_reward_shop_buy(self, reader: PacketReader):
        item_code = reader.read_string()
        self._buy_simple_item(item_code, 1, "Reward")

    def handle_var_shop_buy(self, reader: PacketReader):
        shop_id = reader.read_string()
        kind = reader.read_int()
        item_code = reader.read_string()
        self.log(f"VarShopBuy: shop={shop_id}, kind={kind}, item={item_code}")
        self._buy_simple_item(item_code, 1, "Gold")
        builder = PacketBuilder()
        self.send_packet(builder.build(ShopCommandCode.VAR_SHOP_BUY_ANSWER))

    def _handle_direct_buy_list(self, reader: PacketReader, currency: str):
        items = self._read_buy_items(reader)
        if reader.remaining() > 0:
            reader.read_string()
        if reader.remaining() >= 2:
            reader.read_short()
        for item in items:
            self._buy_simple_item(item["itemCode"], item["count"], currency)

    def _buy_simple_item(self, item_code: str, count: int, currency: str):
        try:
            definition = self._definition(item_code)
            unit_price = 0
            if currency == "Money":
                unit_price = self._premium_price(definition) or 0
            elif currency == "Gold":
                unit_price = int((definition or {}).get("BuyPrice") or 0)
            result = self.get_db().purchase_items(
                self.role_name,
                [{"item_code": item_code, "count": max(1, int(count)), "unit_price": unit_price}],
                "Money" if currency in ("Money", "Reward") else "Gold",
                1,
            )
            if not result.get("Success"):
                self._send_buy_error(result.get("ErrorMsg", "Compra recusada"))
                return
            bought = [{"item_id": row.get("ItemId", ""), "item_code": row["ItemCode"], "count": row["ItemCount"]} for row in result["Added"]]
            if currency == "Gold":
                self.player_data["gold"] = result["NewCurrency"]
                self.session._send_gold_change(-result["Spent"])
            elif hasattr(self.session, "_send_money_change"):
                self.player_data["money"] = result["NewCurrency"]
                self.session._send_money_change(-result["Spent"])
            self._sync_bag(bought)
            self._send_buy_result(bought)
        except Exception as exc:
            self.log(f"Compra simples recusada: {exc}")

    def _read_byte_array(self, reader):
        return [reader.read_byte() for _ in range(reader.read_varint())]

    def _read_buy_items(self, reader):
        result = []
        for _ in range(reader.read_varint()):
            size = reader.read_unsigned_short()
            if size <= 0:
                continue
            result.append({
                "itemCode": reader.read_string(),
                "count": reader.read_unsigned_byte(),
                "buyMode": reader.read_byte(),
            })
        return result

    @classmethod
    def _load_catalog(cls):
        if cls._catalog is None:
            with open(os.path.join(GAME_RESOURCES_DIR, "decoded", "isp.json"), "r", encoding="utf-8") as handle:
                data = json.load(handle)
            cls._catalog = {str(row.get("kind")): set(row.get("items", [])) for row in data.get("itemList", [])}
        return cls._catalog

    def _allowed_items_for_npc(self, npc_id, menu_indexes):
        try:
            map_id = self.player_data.get("mapId", "a1")
            with open(os.path.join(GAME_RESOURCES_DIR, "decoded", f"m{map_id}.json"), "r", encoding="utf-8") as handle:
                data = json.load(handle)
            simple_id = npc_id.split("@")[0]
            node = next(n for n in data.get("npcList", []) if n.get("id") == simple_id)
            # Handle menu index -1 like NpcHandler: skip first index if it's -1
            resolved_indexes = list(menu_indexes)
            if resolved_indexes and resolved_indexes[0] == -1:
                resolved_indexes = resolved_indexes[1:]
            for index in resolved_indexes:
                if index >= 0:
                    node = node.get("menus", [])[index]
            params = node.get("functionPara", {})
            kind = params.get("kind") or params.get("shopKind") or params.get("shop")
            return self._load_catalog().get(str(kind), set())
        except Exception:
            return set()

    def _definition(self, code):
        from inventory_manager import InventoryManager
        return InventoryManager(self.get_db()).get_item_definition(code)

    def _premium_price(self, definition):
        if not definition:
            return None
        raw = definition.get("ExtraDataJson")
        try:
            data = json.loads(raw) if isinstance(raw, str) else raw or {}
            value = data.get("moneyPrice", data.get("premiumPrice"))
            return int(value) if value is not None and int(value) >= 0 else None
        except Exception:
            return None

    def _sync_bag(self, added):
        from inventory_manager import InventoryManager
        items = InventoryManager(self.get_db()).load_inventory(self.role_name, 1)
        self.session._send_bag_check(1, items)
        if added:
            self.session._send_item_added_notify(added)

    def _send_buy_result(self, bought):
        for item in bought:
            builder = PacketBuilder()
            builder.write_string(item["item_code"])
            builder.write_unsigned_byte(int(item["count"]))
            self.send_packet(builder.build(ShopCommandCode.SHOP_BUY_ITEM_ANSWER))

    def _send_buy_error(self, error_msg):
        self.log(f"ShopBuy recusado: {error_msg}")

    def _send_sell_result(self):
        builder = PacketBuilder()
        self.send_packet(builder.build(ShopCommandCode.SHOP_SELL_ITEM_ANSWER))

    def _send_sell_error(self, error_msg):
        self.log(f"ShopSell recusado: {error_msg}")
