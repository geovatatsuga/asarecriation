"""
Attribute calculation for the local Crystal Saga server.
"""

from __future__ import annotations

import json
from typing import Dict, Iterable

from attribute_enums import AttributeCode as AC


class AttributeCalculator:
    def __init__(self, db):
        self.db = db

    def calculate_equipment_attributes(self, role_name: str) -> Dict[int, float]:
        rows = self.db.execute_query(
            """
            SELECT inv.ItemCode, inv.EnhanceLevel, inv.ExtraData, inv.ExtraDataJson,
                   item_def.ExtraDataJson AS DefinitionExtraDataJson
            FROM TB_RoleInventory inv
            LEFT JOIN TB_ItemDefinition item_def ON item_def.ItemCode = inv.ItemCode
            WHERE inv.RoleName=? AND inv.BagIndex=10
            """,
            (role_name,),
        )
        result: Dict[int, float] = {}
        for row in rows:
            row_lower = {k.lower(): v for k, v in row.items()}
            enhance = int(row_lower.get("enhancelevel") or 0)
            item_json = self._loads(row_lower.get("definitionextradatajson")) or {}
            if not item_json:
                from item_config_loader import item_config
                item_json = item_config.get_item(str(row_lower.get("itemcode") or "")) or {}
            inv_json = self._loads(row_lower.get("extradata")) or self._loads(row_lower.get("extradatajson")) or {}
            for attr, value in self._iter_attrs(item_json):
                bonus = float(value) * (1.0 + min(enhance, 20) * 0.005)
                result[attr] = result.get(attr, 0.0) + bonus
            for attr, value in self._iter_attrs(inv_json):
                result[attr] = result.get(attr, 0.0) + float(value)
        return result

    def build_player_attributes(self, player_data: dict, equip_attrs: dict):
        strength = int(player_data.get("strength", 10))
        wisdom = int(player_data.get("wisdom", 10))
        agility = int(player_data.get("agility", 10))
        vitality = int(player_data.get("vitality", 10))

        strength += int(equip_attrs.get(AC.STRENGTH_ADD_VALUE, 0) + equip_attrs.get(AC.ALL_ATTR_ADD_VALUE, 0))
        wisdom += int(equip_attrs.get(AC.WISDOM_ADD_VALUE, 0) + equip_attrs.get(AC.ALL_ATTR_ADD_VALUE, 0))
        agility += int(equip_attrs.get(AC.AGILITY_ADD_VALUE, 0) + equip_attrs.get(AC.ALL_ATTR_ADD_VALUE, 0))
        vitality += int(equip_attrs.get(AC.VITALITY_ADD_VALUE, 0) + equip_attrs.get(AC.ALL_ATTR_ADD_VALUE, 0))

        hp_max = 100 + vitality * 10
        mp_max = 50 + wisdom * 6
        physical_attack = 8 + strength * 2 + agility * 0.5
        magic_attack = 8 + wisdom * 2
        physical_defense = 4 + vitality + strength // 2
        magic_defense = 4 + wisdom + vitality // 2
        hit_value = 50 + agility * 2
        dodge_value = 10 + agility
        crit_value = 5 + agility // 2

        hp_max = self._apply(equip_attrs, hp_max, AC.HP_MAX_ADD_BASE_VALUE, AC.HP_MAX_ADD_RATE, AC.HP_MAX_ADD_EXTRA_VALUE)
        mp_max = self._apply(equip_attrs, mp_max, AC.MP_MAX_ADD_BASE_VALUE, AC.MP_MAX_ADD_RATE, AC.MP_MAX_ADD_EXTRA_VALUE)
        physical_attack = self._apply(equip_attrs, physical_attack, AC.PHYSICAL_ATTACK_ADD_BASE_VALUE, AC.PHYSICAL_ATTACK_ADD_RATE, AC.PHYSICAL_ATTACK_ADD_EXTRA_VALUE)
        magic_attack = self._apply(equip_attrs, magic_attack, AC.MAGIC_ATTACK_ADD_BASE_VALUE, AC.MAGIC_ATTACK_ADD_RATE, AC.MAGIC_ATTACK_ADD_EXTRA_VALUE)
        physical_defense = self._apply(equip_attrs, physical_defense, AC.PHYSICAL_DEFENSE_ADD_BASE_VALUE, AC.PHYSICAL_DEFENSE_ADD_RATE, AC.PHYSICAL_DEFENSE_ADD_EXTRA_VALUE)
        magic_defense = self._apply(equip_attrs, magic_defense, AC.MAGIC_DEFENSE_ADD_BASE_VALUE, AC.MAGIC_DEFENSE_ADD_RATE, AC.MAGIC_DEFENSE_ADD_EXTRA_VALUE)

        current_hp = min(float(player_data.get("hp", hp_max)), hp_max)
        current_mp = min(int(player_data.get("mp", mp_max)), int(mp_max))
        attrs = {
            "strength": strength,
            "wisdom": wisdom,
            "agility": agility,
            "vitality": vitality,
            "hp": current_hp,
            "hpMax": hp_max,
            "mp": current_mp,
            "mpMax": int(mp_max),
            "sp": int(player_data.get("sp", 0)),
            "spMax": int(100 + agility * 2 + equip_attrs.get(AC.SP_MAX_ADD_BASE_VALUE, 0)),
            "xp": int(player_data.get("xp", 0)),
            "xpMax": int(player_data.get("xpMax", 100)),
            "physicalAttack": physical_attack,
            "physicalDefense": int(physical_defense),
            "physicalReduceRate": float(equip_attrs.get(AC.PHYSICAL_REDUCE_RATE_ADD_VALUE, 0.0)),
            "magicAttack": magic_attack,
            "magicDefense": int(magic_defense),
            "magicReduceRate": float(equip_attrs.get(AC.MAGIC_REDUCE_RATE_ADD_VALUE, 0.0)),
            "hitValue": int(hit_value + equip_attrs.get(AC.HIT_VALUE_ADD_VALUE, 0)),
            "hitRate": 0.95 + float(equip_attrs.get(AC.HIT_RATE_ADD_VALUE, 0.0)),
            "dodgeValue": int(dodge_value + equip_attrs.get(AC.DODGE_VALUE_ADD_VALUE, 0)),
            "dodgeRate": 0.05 + float(equip_attrs.get(AC.DODGE_RATE_ADD_VALUE, 0.0)),
            "critValue": int(crit_value + equip_attrs.get(AC.CRIT_VALUE_ADD_VALUE, 0)),
            "critRate": 0.05 + float(equip_attrs.get(AC.CRIT_RATE_ADD_VALUE, 0.0)),
            "luckyAttack": int(equip_attrs.get(AC.LUCKY_ATTACK_ADD_VALUE, 0)),
            "luckyDefense": int(equip_attrs.get(AC.LUCKY_DEFENSE_ADD_VALUE, 0)),
            "critDamageMul": 1.5 + float(equip_attrs.get(AC.CRIT_DAMAGE_MUL_ADD_VALUE, 0.0)),
            "toughValue": int(equip_attrs.get(AC.TOUGH_VALUE_ADD_VALUE, 0)),
            "pierceAttack": int(equip_attrs.get(AC.PIERCE_ATTACK_ADD_VALUE, 0)),
            "pierceDefense": int(equip_attrs.get(AC.PIERCE_DEFENSE_ADD_VALUE, 0)),
            "singTimeModifier": max(0.2, 1.0 / max(0.2, 1.0 + float(equip_attrs.get(AC.SING_SPEED_ADD_RATE, 0.0)))),
            "castTimeModifier": max(0.2, 1.0 / max(0.2, 1.0 + float(equip_attrs.get(AC.CAST_SPEED_ADD_RATE, 0.0)))),
            "singTimeReduceMS": int(equip_attrs.get(AC.SING_TIME_REDUCEMS_ADD_VALUE, 0)),
            "walkSpeed": int(player_data.get("walkSpeed", 200) + equip_attrs.get(AC.WALK_SPEED_ADD_VALUE, 0)),
            "hpHealValue": int(equip_attrs.get(AC.HP_HEAL_VALUE_ADD_VALUE, 0)),
            "mpHealValue": int(equip_attrs.get(AC.MP_HEAL_VALUE_ADD_VALUE, 0)),
            "spHealValue": int(equip_attrs.get(AC.SP_HEAL_VALUE_ADD_VALUE, 0)),
            "cureValue": int(equip_attrs.get(AC.CURE_VALUE_ADD_VALUE, 0)),
        }
        for i in range(1, 6):
            attrs[f"element{i}Attack"] = int(equip_attrs.get(getattr(AC, f"ELEMENT{i}_ATTACK_ADD_BASE_VALUE"), 0))
            attrs[f"element{i}Defense"] = int(equip_attrs.get(getattr(AC, f"ELEMENT{i}_DEFENSE_ADD_BASE_VALUE"), 0))
        attrs.update({"lot": 0, "loa": 0, "loh": 0})
        return attrs, {
            "physical_attack": int(physical_attack),
            "physical_defense": int(physical_defense),
            "hp": int(current_hp),
            "hp_max": hp_max,
        }

    def _apply(self, attrs: dict, base: float, base_code: int, rate_code: int, extra_code: int) -> float:
        return base * (1.0 + float(attrs.get(rate_code, 0.0))) + float(attrs.get(base_code, 0.0)) + float(attrs.get(extra_code, 0.0))

    def _loads(self, value):
        if not value:
            return None
        if isinstance(value, dict) or isinstance(value, list):
            return value
        try:
            return json.loads(value)
        except Exception:
            return None

    def _iter_attrs(self, data) -> Iterable[tuple[int, float]]:
        if not isinstance(data, dict):
            return []
        attrs = []
        props = data.get("properties") if isinstance(data.get("properties"), dict) else {}
        for source in (
            data.get("baseAttributes"),
            data.get("BaseAttributes"),
            data.get("baseAttr"),
            data.get("extAttr"),
            data.get("attr"),
            props.get("baseAttr"),
            props.get("extAttr"),
            props.get("attr"),
        ):
            if isinstance(source, dict):
                attrs.extend((int(k), float(v)) for k, v in source.items())
            elif isinstance(source, list):
                for item in source:
                    if isinstance(item, dict) and "attr" in item:
                        attrs.append((int(item.get("attr")), float(item.get("value", 0))))
        return attrs
