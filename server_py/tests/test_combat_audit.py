import unittest

from tools.audit_combat_completion import (
    analyze_buff_resource,
    analyze_skill_resource,
    analyze_sync_texts,
)


class CombatAuditTests(unittest.TestCase):
    def test_report_counts_skill_result_and_buff_coverage(self):
        skills = analyze_skill_resource(
            {
                "skills": [
                    {
                        "code": "s1",
                        "visual": {"fly": "fx01"},
                        "levelInfo": [
                            {
                                "castRule": {"range": 300, "coldTime": 1000},
                                "resultRule": {
                                    "toTarget": {
                                        "0": {
                                            "attack1Attr": 11,
                                            "attack1AttrMultiply": 1,
                                            "unknownLegacyEffect": 7,
                                        }
                                    }
                                },
                            }
                        ],
                    }
                ]
            }
        )
        buffs = analyze_buff_resource(
            {
                "buffs": [
                    {
                        "buffId": 1,
                        "resultAttr": {"141": 0.5, "999": 10},
                        "resultStatus": 256,
                        "onTimer": {
                            "firstTimeInSec": 1,
                            "repeatTimeInSec": 2,
                            "doMacro": {"addHp": 1},
                            "legacyTimerFlag": True,
                        },
                    }
                ]
            }
        )

        self.assertEqual(skills["skills"], 1)
        self.assertEqual(skills["levelsWithCastRule"], 1)
        self.assertEqual(skills["levelsWithResultRule"], 1)
        self.assertEqual(skills["skillsWithVisualFly"], 1)
        unknown_effects = {item["name"]: item["count"] for item in skills["resultEffects"]["unknown"]}
        self.assertEqual(unknown_effects["unknownLegacyEffect"], 1)
        self.assertGreater(skills["resultEffects"]["coveragePercent"], 0)

        self.assertEqual(buffs["buffs"], 1)
        self.assertEqual(buffs["withResultAttr"], 1)
        self.assertEqual(buffs["withResultStatus"], 1)
        self.assertEqual(buffs["triggerCounts"]["onTimer"], 1)
        self.assertEqual(buffs["normalizedTriggerCounts"]["onTimer"], 1)
        unknown_attrs = {item["name"]: item["count"] for item in buffs["resultAttr"]["unknown"]}
        self.assertEqual(unknown_attrs["999"], 1)
        unknown_trigger_fields = {item["name"]: item["count"] for item in buffs["unknownTriggerFields"]}
        self.assertEqual(unknown_trigger_fields["legacyTimerFlag"], 1)

    def test_report_lists_combat_sync_commands_from_sources(self):
        report = analyze_sync_texts(
            {
                "handlers/combat_handler.py": "\n".join(
                    [
                        "from protocol.commands import PlayerCommandCode",
                        "builder.build(PlayerCommandCode.PLAYER_HP_CHANGE_NOTIFY)",
                        "builder.build(801)",
                        "builder.build(dynamic_command)",
                    ]
                )
            }
        )

        commands = {item["code"]: item for item in report["combatSyncCommands"]}
        self.assertIn(550, commands)
        self.assertIn(801, commands)
        self.assertEqual(commands[550]["count"], 1)
        unresolved = {item["name"]: item["count"] for item in report["unresolvedBuildArgs"]}
        self.assertEqual(unresolved["dynamic_command"], 1)


if __name__ == "__main__":
    unittest.main()
