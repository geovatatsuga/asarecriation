"""Conservative resolver for legacy skill and buff combat definitions."""

import math
import random


ATTR_MAP = {
    "90": ("allAttributes", "flat"),
    "100": ("strength", "flat"), "101": ("strength", "rate"),
    "110": ("wisdom", "flat"), "111": ("wisdom", "rate"),
    "120": ("agility", "flat"), "121": ("agility", "rate"),
    "130": ("vitality", "flat"), "131": ("vitality", "rate"),
    "140": ("physicalAttack", "flat"), "141": ("physicalAttack", "rate"), "142": ("physicalAttack", "flat"),
    "150": ("magicAttack", "flat"), "151": ("magicAttack", "rate"), "152": ("magicAttack", "flat"),
    "160": ("physicalDefense", "flat"), "161": ("physicalDefense", "rate"), "162": ("physicalDefense", "flat"),
    "170": ("magicDefense", "flat"), "171": ("magicDefense", "rate"), "172": ("magicDefense", "flat"),
    "180": ("physicalReduceRate", "flat"), "190": ("magicReduceRate", "flat"),
    "200": ("hpMax", "flat"), "201": ("hpMax", "rate"), "202": ("hpMax", "flat"),
    "210": ("mpMax", "flat"), "211": ("mpMax", "rate"), "212": ("mpMax", "flat"),
    "230": ("hitValue", "flat"), "231": ("hitRate", "flat"),
    "240": ("dodgeValue", "flat"), "241": ("dodgeRate", "flat"),
    "250": ("critValue", "flat"), "251": ("critRate", "flat"),
    "260": ("luckyAttack", "flat"), "261": ("luckyDefense", "flat"),
    "270": ("critDamageMul", "flat"), "280": ("toughValue", "flat"),
    "290": ("physicalPenetration", "flat"), "291": ("pierceDefense", "flat"), "293": ("magicPenetration", "flat"),
    "300": ("castSpeed", "rate"), "320": ("walkSpeed", "flat"), "321": ("walkSpeed", "rate"), "322": ("walkSpeed", "set"),
    "310": ("singSpeed", "rate"), "311": ("singTimeReduceMs", "flat"),
    "330": ("hpRegen", "flat"), "340": ("mpRegen", "flat"),
    "360": ("healingPower", "flat"), "361": ("healingBonusRate", "flat"), "362": ("healingPower", "flat"),
    "380": ("roleExpMul", "flat"), "390": ("petExpMul", "flat"), "400": ("itemDropChanceMul", "flat"),
    "410": ("physicalReduceToHpRate", "flat"), "420": ("magicReduceToHpRate", "flat"),
}

ATTACK_ATTRIBUTES = {
    11: ("physicalAttack", "physical"),
    12: ("magicAttack", "magical"),
    13: ("elementalAttack", "elemental"),
}

STATUS_CANNOT_MOVE = 1 | 4
STATUS_CANNOT_USE_SKILL = 256 | 512 | 1024 | 2048


def _number(value, default=0.0):
    try:
        return float(value)
    except (TypeError, ValueError):
        return float(default)


def _rate(value, default=0.0):
    value = _number(value, default)
    return value / 100.0 if abs(value) > 1.0 else value


def skill_level_definition(skill, level=1):
    levels = skill.get("levelInfo") or skill.get("levels") or []
    if isinstance(levels, list) and levels:
        return levels[min(max(int(level), 1), len(levels)) - 1]
    return skill


def aggregate_buffs(player_data):
    attrs, status = {}, 0
    for buff in player_data.get("activeBuffs", {}).values():
        status |= int(buff.get("resultStatus") or 0)
        for code, value in (buff.get("resultAttr") or {}).items():
            attrs[str(code)] = attrs.get(str(code), 0.0) + _number(value)
    return attrs, status


def effective_attribute(player_data, name, default=0):
    base = _number(player_data.get(name, default))
    attrs, _ = aggregate_buffs(player_data)
    if name in {"strength", "wisdom", "agility", "vitality"} and "90" in attrs:
        base += attrs["90"]
    for code, (mapped_name, mode) in ATTR_MAP.items():
        if mapped_name == name and code in attrs:
            value = attrs[code]
            if mode == "rate":
                base *= 1.0 + _rate(value)
            elif mode == "set":
                base = value
            else:
                base += value
    return max(0.0, base)


def has_status(player_data, mask):
    return bool(aggregate_buffs(player_data)[1] & mask)


def buff_modifier(player_data, code):
    return _number(aggregate_buffs(player_data)[0].get(str(code), 0))


def distance_to(player_data, x, y):
    return math.hypot(_number(player_data.get("posX")) - _number(x), _number(player_data.get("posY")) - _number(y))


def within_range(source, target, maximum, minimum=0):
    distance = distance_to(source, target.get("posX", 0), target.get("posY", 0))
    return _number(minimum) <= distance <= _number(maximum)


def is_valid_target(attacker, target, target_mode=None):
    if not target or target.get("dead") or _number(target.get("hp", 1)) <= 0:
        return False
    if attacker.get("mapId") is not None and target.get("mapId") is not None:
        if str(attacker["mapId"]) != str(target["mapId"]):
            return False
    same = attacker is target or (
        attacker.get("roleId") is not None and attacker.get("roleId") == target.get("roleId")
    )
    mode = str(target_mode or "").lower()
    if mode in {"self", "toself"}:
        return same
    if mode in {"enemy", "hostile", "totarget"}:
        return not same
    return True


def roll_hit_critical(attacker, defender, rng=None):
    rng = rng or random
    accuracy = _rate(attacker.get("hitRate", attacker.get("accuracyRate", 0.85)), 0.85)
    accuracy += _rate(buff_modifier(attacker, 231))
    dodge = _rate(defender.get("dodgeRate", defender.get("evasionRate", 0)))
    hit_rate = max(0.05, min(0.99, accuracy - dodge))
    crit_rate = _rate(attacker.get("critRate", 0.05), 0.05) + _rate(buff_modifier(attacker, 251))
    crit_resist = _rate(defender.get("critResistRate", defender.get("criticalResistRate", 0)))
    crit_rate = max(0.0, min(0.95, crit_rate - crit_resist))
    hit = rng.random() <= hit_rate
    return hit, hit and rng.random() <= crit_rate


def mitigate_damage(
    raw,
    attacker,
    defender,
    magical=False,
    critical=False,
    damage_type=None,
    ignore_defense_rate=0,
):
    damage_type = damage_type or ("magical" if magical else "physical")
    if damage_type == "elemental":
        defense_key, reduce_key, penetration_key = "elementalDefense", "elementalReduceRate", "elementalPenetration"
    elif damage_type == "magical":
        defense_key, reduce_key, penetration_key = "magicDefense", "magicReduceRate", "magicPenetration"
    else:
        defense_key, reduce_key, penetration_key = "physicalDefense", "physicalReduceRate", "physicalPenetration"

    defense = effective_attribute(defender, defense_key, defender.get("defense", 0))
    defense *= max(0.0, 1.0 - max(0.0, min(1.0, _rate(ignore_defense_rate))))
    penetration = _number(attacker.get(penetration_key, attacker.get("penetration", 0))) + buff_modifier(attacker, 290)
    penetration_rate = _rate(attacker.get(f"{penetration_key}Rate", attacker.get("penetrationRate", 0)))
    defense = max(0.0, defense * max(0.0, 1.0 - penetration_rate) - penetration)
    reduction = _rate(defender.get(reduce_key, defender.get("damageReduceRate", 0)))
    damage = max(1.0, _number(raw) - defense) * max(0.0, 1.0 - min(0.95, reduction))
    if critical:
        damage *= max(1.0, _number(attacker.get("critDamageMul", 1.5), 1.5) + buff_modifier(attacker, 270))
    return max(1, int(damage))


def calculate_healing(raw, healer, target=None, critical=False):
    target = target or healer
    outgoing = _rate(healer.get("healingBonusRate", healer.get("healBonusRate", 0)))
    incoming = _rate(target.get("healingReceivedRate", target.get("healReceivedRate", 0)))
    healing = max(0.0, _number(raw) + _number(healer.get("healingPower", 0)))
    healing *= max(0.0, 1.0 + outgoing) * max(0.0, 1.0 + incoming)
    if critical:
        healing *= max(1.0, _number(healer.get("healCritDamageMul", healer.get("critDamageMul", 1.5)), 1.5))
    return max(0, int(healing))


def cast_rule(skill, level=1):
    definition = skill_level_definition(skill, level)
    return definition.get("castRule") or skill.get("castRule") or {}


def result_rule(skill, level=1):
    definition = skill_level_definition(skill, level)
    return definition.get("resultRule") or skill.get("resultRule") or {}


def _walk_effects(node):
    if isinstance(node, list):
        for value in node:
            yield from _walk_effects(value)
    elif isinstance(node, dict):
        effect_keys = {
            "attack1Attr", "attack1AttrMultiply", "attackAdded", "hpAddFixed",
            "hpAddByAttr", "buffIds", "addBuffs", "scripts", "doMacro",
            "onHitToTarget", "onHitToSelf", "damage2hp", "trapCode",
            "displaceChance", "breakSingChance",
            "fixedHitRate", "ignoreTargetDefenseRate", "ignoreTargetDefenseChance",
            "displacePixel", "addThreatRate", "addThreatValue",
            "targetCircleRadius", "mpAddByAttr", "mpAddByAttrMultiply", "mpAddFixed",
            "enabled", "condition", "hp%<=", "weaknessType", "instantDeathChance",
            "keepSpace", "isSysTrap",
        }
        if effect_keys.intersection(node):
            yield node
        else:
            for value in node.values():
                yield from _walk_effects(value)


def iter_effects(rule, target_kind="toTarget"):
    target = rule.get(target_kind) if isinstance(rule, dict) else None
    if target is None and target_kind == "toTarget":
        target = rule
    yield from _walk_effects(target or {})


def _effect_damage(effect, attacker):
    attr_code = int(_number(effect.get("attack1Attr", 11), 11))
    attr_name, damage_type = ATTACK_ATTRIBUTES.get(attr_code, ("physicalAttack", "physical"))
    attack = effective_attribute(attacker, attr_name, attacker.get("attack", 10))
    multiplier = _number(effect.get("attack1AttrMultiply", 0))
    damage = attack * multiplier
    if effect.get("attack2Attr") is not None:
        attr2_code = int(_number(effect.get("attack2Attr", 11), 11))
        attr2_name, damage_type = ATTACK_ATTRIBUTES.get(attr2_code, (attr_name, damage_type))
        damage += effective_attribute(attacker, attr2_name, attacker.get("attack", 10)) * _number(effect.get("attack2AttrMultiply", 0))
    if effect.get("damageAttr") is not None:
        attr3_code = int(_number(effect.get("damageAttr", 11), 11))
        attr3_name, damage_type = ATTACK_ATTRIBUTES.get(attr3_code, (attr_name, damage_type))
        damage += effective_attribute(attacker, attr3_name, attacker.get("attack", 10)) * _number(effect.get("damageAttrMultiply", 0))
    damage += _number(effect.get("attackAdded", effect.get("damageFixed", 0)))
    damage += _number(effect.get("damageAdded", 0))
    return damage, damage_type


def _legacy_attr_name(attr_code, default_name):
    code = int(_number(attr_code, 0))
    if code in ATTACK_ATTRIBUTES:
        return ATTACK_ATTRIBUTES[code][0]
    return {
        8: "hpMax",
        9: "mpMax",
        10: "spMax",
    }.get(code, default_name)


def _effect_healing(effect, healer):
    healing = _number(effect.get("hpAddFixed", 0))
    by_attr = effect.get("hpAddByAttr") or {}
    if isinstance(by_attr, dict):
        for name, multiplier in by_attr.items():
            healing += effective_attribute(healer, str(name), 0) * _number(multiplier)
    elif by_attr:
        attr_name = _legacy_attr_name(by_attr, "magicAttack")
        healing += effective_attribute(healer, attr_name, 0) * _number(effect.get("hpAddByAttrMultiply", 1))
    return healing


def _effect_mp_restore(effect, player_data):
    mp = _number(effect.get("mpAddFixed", 0))
    by_attr = effect.get("mpAddByAttr") or {}
    if isinstance(by_attr, dict):
        for name, multiplier in by_attr.items():
            mp += effective_attribute(player_data, str(name), 0) * _number(multiplier)
    elif by_attr:
        attr_name = _legacy_attr_name(by_attr, "mpMax")
        mp += effective_attribute(player_data, attr_name, 0) * _number(effect.get("mpAddByAttrMultiply", 1))
    return mp


def _condition_matches(effect, target_data):
    if effect.get("enabled") is False:
        return False
    conditions = []
    if isinstance(effect.get("condition"), dict):
        conditions.append(effect["condition"])
    conditions.append(effect)
    for condition in conditions:
        if "hp%<=" not in condition:
            continue
        maximum = max(1.0, _number(target_data.get("hpMax", target_data.get("hp", 1)), 1))
        current = _number(target_data.get("hp", maximum), maximum)
        if (current / maximum * 100.0) > _number(condition.get("hp%<=")):
            return False
    weakness = effect.get("weaknessType")
    if weakness:
        required = {str(int(_number(value))) for value in (weakness if isinstance(weakness, list) else [weakness])}
        target_values = target_data.get("weaknessType") or target_data.get("weaknessTypes") or target_data.get("type")
        actual = {
            str(int(_number(value)))
            for value in (target_values if isinstance(target_values, list) else [target_values])
            if value is not None
        }
        if required and not (required & actual):
            return False
    return True


def resolve_effects(skill, player_data, target_kind="toTarget", target_defense=0, level=1, rng=None, target_data=None):
    rng = rng or random
    target_data = target_data or {"physicalDefense": target_defense, "magicDefense": target_defense}
    damage, healing, mp_restore, buffs, macros, target_macros, self_macros, traps, sys_traps = 0, 0, 0, [], [], [], [], [], []
    lifesteal_rate = break_sing_chance = displace_chance = 0.0
    fixed_hit_rate = None
    ignore_defense_rate = threat_rate = threat_value = target_circle_radius = 0.0
    displace_pixel = keep_space = 0
    instant_death = False
    displacements = []
    damage_by_type = {"physical": 0, "magical": 0, "elemental": 0}
    for effect in iter_effects(result_rule(skill, level), target_kind):
        if not _condition_matches(effect, target_data):
            continue
        if rng.random() > max(0.0, min(1.0, _rate(effect.get("chance", 1), 1))):
            continue
        effect_ignore_rate = 0.0
        ignore_chance = max(0.0, min(1.0, _rate(effect.get("ignoreTargetDefenseChance", 1), 1)))
        if effect.get("ignoreTargetDefenseRate") is not None and rng.random() <= ignore_chance:
            effect_ignore_rate = max(0.0, min(1.0, _rate(effect.get("ignoreTargetDefenseRate"))))
            ignore_defense_rate = max(ignore_defense_rate, effect_ignore_rate)
        raw, damage_type = _effect_damage(effect, player_data)
        if raw:
            resolved = mitigate_damage(
                raw,
                player_data,
                target_data,
                damage_type=damage_type,
                ignore_defense_rate=effect_ignore_rate,
            )
            damage += resolved
            damage_by_type[damage_type] += resolved
            threat_value += resolved * _rate(effect.get("addThreatRate", 0))
        healing += calculate_healing(_effect_healing(effect, player_data), player_data, target_data)
        mp_restore += max(0.0, _effect_mp_restore(effect, player_data))
        ids = effect.get("buffIds") or effect.get("addBuffs") or []
        buffs.extend(ids if isinstance(ids, list) else [ids])
        macro = effect.get("scripts") or effect.get("doMacro")
        if macro:
            macros.extend(macro if isinstance(macro, list) else [macro])
        target_macro = effect.get("onHitToTarget")
        if target_macro:
            target_macros.append(target_macro)
        self_macro = effect.get("onHitToSelf")
        if self_macro:
            self_macros.append(self_macro)
        lifesteal_rate = max(lifesteal_rate, _rate(effect.get("damage2hp", 0)))
        break_sing_chance = max(break_sing_chance, _rate(effect.get("breakSingChance", 0)))
        displace_chance = max(displace_chance, _rate(effect.get("displaceChance", 0)))
        if effect.get("fixedHitRate") is not None:
            fixed_rate = max(0.0, min(1.0, _rate(effect.get("fixedHitRate"))))
            fixed_hit_rate = fixed_rate if fixed_hit_rate is None else max(fixed_hit_rate, fixed_rate)
        if effect.get("displacePixel") is not None:
            pixel = int(_number(effect.get("displacePixel")))
            displace_pixel = pixel if abs(pixel) > abs(displace_pixel) else displace_pixel
            displacements.append({"pixel": pixel, "chance": displace_chance or 1.0})
        if effect.get("keepSpace") is not None:
            keep_space = int(_number(effect.get("keepSpace")))
            displacements.append({"pixel": keep_space, "chance": displace_chance or 1.0, "kind": "keepSpace"})
        if effect.get("instantDeathChance") is not None:
            instant_death = instant_death or rng.random() <= max(0.0, min(1.0, _rate(effect.get("instantDeathChance"))))
        threat_rate = max(threat_rate, _rate(effect.get("addThreatRate", 0)))
        threat_value += _number(effect.get("addThreatValue", 0))
        target_circle_radius = max(target_circle_radius, _number(effect.get("targetCircleRadius", 0)))
        if effect.get("trapCode"):
            (sys_traps if effect.get("isSysTrap") else traps).append(str(effect["trapCode"]))
    return {
        "damage": int(damage),
        "healing": int(healing),
        "mpRestore": int(mp_restore),
        "buffs": [int(x) for x in buffs if str(x).lstrip("-").isdigit()],
        "damageByType": damage_by_type,
        "macros": macros,
        "targetMacros": target_macros,
        "selfMacros": self_macros,
        "lifestealRate": lifesteal_rate,
        "breakSingChance": break_sing_chance,
        "displaceChance": displace_chance,
        "displacePixel": int(displace_pixel),
        "keepSpace": int(keep_space),
        "displacements": displacements,
        "fixedHitRate": fixed_hit_rate,
        "instantDeath": instant_death,
        "ignoreTargetDefenseRate": ignore_defense_rate,
        "threat": {
            "rate": threat_rate,
            "value": int(threat_value),
        },
        "targetCircleRadius": int(target_circle_radius),
        "traps": traps,
        "sysTraps": sys_traps,
    }


def resolve_target_effects(skill, player_data, target_defense=0, level=1, rng=None, target_data=None):
    return resolve_effects(skill, player_data, "toTarget", target_defense, level, rng, target_data)


def area_rule(skill, level=1):
    rule = cast_rule(skill, level)
    area = rule.get("areaAttributes") or {}
    return _number(area.get("radius", 0)), int(_number(rule.get("targetNumber", 1), 1))
