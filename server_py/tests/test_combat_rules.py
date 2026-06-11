import random
import unittest

from gameplay.combat_rules import (
    calculate_healing,
    distance_to,
    effective_attribute,
    is_valid_target,
    iter_effects,
    mitigate_damage,
    resolve_effects,
    roll_hit_critical,
    within_range,
)


class CombatRulesTests(unittest.TestCase):
    def test_buff_rate_changes_attack(self):
        player = {"physicalAttack": 100, "activeBuffs": {1: {"resultAttr": {"141": 0.5}}}}
        self.assertEqual(effective_attribute(player, "physicalAttack"), 150)

    def test_percent_style_buff_rate_is_normalized(self):
        player = {"physicalAttack": 100, "activeBuffs": {1: {"resultAttr": {"141": 50}}}}
        self.assertEqual(effective_attribute(player, "physicalAttack"), 150)

    def test_distance_and_range(self):
        source = {"posX": 0, "posY": 0}
        target = {"posX": 3, "posY": 4}
        self.assertEqual(distance_to(source, 3, 4), 5)
        self.assertTrue(within_range(source, target, 5))
        self.assertFalse(within_range(source, target, 4))

    def test_target_validation_checks_life_map_and_mode(self):
        actor = {"roleId": 1, "mapId": "a", "hp": 10}
        enemy = {"roleId": 2, "mapId": "a", "hp": 10}
        self.assertTrue(is_valid_target(actor, enemy, "enemy"))
        self.assertFalse(is_valid_target(actor, actor, "enemy"))
        self.assertFalse(is_valid_target(actor, {**enemy, "mapId": "b"}, "enemy"))
        self.assertFalse(is_valid_target(actor, {**enemy, "hp": 0}, "enemy"))

    def test_damage_uses_defense_reduction_and_critical(self):
        attacker = {"critDamageMul": 1.5, "activeBuffs": {}}
        defender = {"physicalDefense": 20, "physicalReduceRate": 0.25, "activeBuffs": {}}
        self.assertEqual(mitigate_damage(100, attacker, defender), 60)
        self.assertEqual(mitigate_damage(100, attacker, defender, critical=True), 90)

    def test_penetration_and_elemental_damage(self):
        attacker = {"elementalPenetration": 10, "activeBuffs": {}}
        defender = {"elementalDefense": 30, "elementalReduceRate": 0.25, "activeBuffs": {}}
        self.assertEqual(mitigate_damage(100, attacker, defender, damage_type="elemental"), 60)

    def test_damage_can_ignore_target_defense(self):
        attacker = {"activeBuffs": {}}
        defender = {"physicalDefense": 50, "activeBuffs": {}}
        self.assertEqual(mitigate_damage(100, attacker, defender), 50)
        self.assertEqual(mitigate_damage(100, attacker, defender, ignore_defense_rate=0.5), 75)

    def test_hit_crit_respect_accuracy_evasion_and_resist(self):
        hit, critical = roll_hit_critical(
            {"hitRate": 100, "critRate": 100, "activeBuffs": {}},
            {"dodgeRate": 0, "critResistRate": 100},
            random.Random(1),
        )
        self.assertTrue(hit)
        self.assertFalse(critical)

    def test_hit_roll_is_bounded(self):
        hit, critical = roll_hit_critical(
            {"critRate": 0, "activeBuffs": {}},
            {"dodgeRate": 100},
            random.Random(1),
        )
        self.assertFalse(hit)
        self.assertFalse(critical)

    def test_healing_applies_outgoing_incoming_and_power(self):
        healer = {"healingPower": 20, "healingBonusRate": 0.5}
        target = {"healingReceivedRate": 0.25}
        self.assertEqual(calculate_healing(100, healer, target), 225)

    def test_iter_effects_walks_all_numbered_and_list_blocks(self):
        rule = {"toTarget": {"0": {"0": {"attackAdded": 10}}, "1": [{"hpAddFixed": 5}]}}
        effects = list(iter_effects(rule))
        self.assertEqual(len(effects), 2)

    def test_resolve_effects_combines_all_blocks_and_types(self):
        skill = {
            "resultRule": {
                "toTarget": {
                    "0": {"0": {"attack1Attr": 11, "attack1AttrMultiply": 1}},
                    "1": {"0": {"attack1Attr": 12, "attack1AttrMultiply": 2, "buffIds": ["7"]}},
                    "2": {"0": {"attack1Attr": 13, "attackAdded": 20, "scripts": {"addHp": 1}}},
                }
            }
        }
        attacker = {"physicalAttack": 100, "magicAttack": 50, "elementalAttack": 10, "activeBuffs": {}}
        target = {"physicalDefense": 10, "magicDefense": 20, "elementalDefense": 5, "activeBuffs": {}}
        result = resolve_effects(skill, attacker, rng=random.Random(1), target_data=target)
        self.assertEqual(result["damageByType"], {"physical": 90, "magical": 80, "elemental": 15})
        self.assertEqual(result["damage"], 185)
        self.assertEqual(result["buffs"], [7])
        self.assertEqual(result["macros"], [{"addHp": 1}])

    def test_resolve_effects_applies_ignore_defense_and_returns_hit_metadata(self):
        skill = {
            "resultRule": {
                "toTarget": {
                    "default": {
                        "0": {
                            "attack1Attr": 11,
                            "attack1AttrMultiply": 1,
                            "fixedHitRate": 1,
                            "ignoreTargetDefenseChance": 1,
                            "ignoreTargetDefenseRate": 0.5,
                        }
                    }
                }
            }
        }
        attacker = {"physicalAttack": 100, "activeBuffs": {}}
        target = {"physicalDefense": 50, "activeBuffs": {}}
        result = resolve_effects(skill, attacker, rng=random.Random(1), target_data=target)

        self.assertEqual(result["damage"], 75)
        self.assertEqual(result["fixedHitRate"], 1)
        self.assertEqual(result["ignoreTargetDefenseRate"], 0.5)

    def test_resolve_effects_returns_threat_displacement_radius_and_mp(self):
        skill = {
            "resultRule": {
                "toSelf": {
                    "0": {"mpAddByAttr": 9, "mpAddByAttrMultiply": 0.1},
                    "1": {"targetCircleRadius": 120},
                },
                "toTarget": {
                    "default": {
                        "0": {
                            "attack1Attr": 11,
                            "attack1AttrMultiply": 1,
                            "addThreatRate": 0.2,
                            "addThreatValue": 15,
                            "displaceChance": 1,
                            "displacePixel": -300,
                            "targetCircleRadius": 80,
                        }
                    }
                },
            }
        }
        attacker = {"physicalAttack": 100, "mpMax": 500, "activeBuffs": {}}
        target = {"physicalDefense": 10, "activeBuffs": {}}

        self_result = resolve_effects(skill, attacker, "toSelf", rng=random.Random(1), target_data=target)
        target_result = resolve_effects(skill, attacker, rng=random.Random(1), target_data=target)

        self.assertEqual(self_result["mpRestore"], 50)
        self.assertEqual(self_result["targetCircleRadius"], 120)
        self.assertEqual(target_result["damage"], 90)
        self.assertEqual(target_result["threat"], {"rate": 0.2, "value": 33})
        self.assertEqual(target_result["displacePixel"], -300)
        self.assertEqual(target_result["displacements"], [{"pixel": -300, "chance": 1.0}])
        self.assertEqual(target_result["targetCircleRadius"], 80)

    def test_resolve_effects_conditions_weakness_instant_death_and_sys_trap(self):
        skill = {
            "resultRule": {
                "toTarget": {
                    "0": {"enabled": False, "damageAdded": 999},
                    "1": {"condition": {"hp%<=": 50}, "damageAdded": 20},
                    "2": {"weaknessType": [50001], "damageAdded": 30},
                    "3": {"instantDeathChance": 1, "keepSpace": 60, "isSysTrap": True, "trapCode": "sys01"},
                }
            }
        }
        attacker = {"physicalAttack": 0, "activeBuffs": {}}
        target = {"hp": 40, "hpMax": 100, "weaknessType": [50001], "activeBuffs": {}}

        result = resolve_effects(skill, attacker, rng=random.Random(1), target_data=target)

        self.assertEqual(result["damage"], 50)
        self.assertTrue(result["instantDeath"])
        self.assertEqual(result["keepSpace"], 60)
        self.assertEqual(result["sysTraps"], ["sys01"])
        self.assertEqual(result["traps"], [])


if __name__ == "__main__":
    unittest.main()
