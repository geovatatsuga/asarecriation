import unittest

from gameplay.buff_runtime import (
    apply_buff,
    dispel,
    expire_buffs,
    normalize_buff,
    normalize_triggers,
)


class BuffRuntimeTests(unittest.TestCase):
    def test_stronger_cover_level_replaces_weaker_and_weaker_is_blocked(self):
        active = {}
        apply_buff(active, {"buffId": "10", "coverFlag": 5, "coverLevel": 2})
        result = apply_buff(active, {"buffId": "11", "coverFlag": 5, "coverLevel": 3})
        self.assertEqual(result.action, "replaced")
        self.assertEqual(result.removed, (10,))
        blocked = apply_buff(active, {"buffId": "12", "coverFlag": 5, "coverLevel": 1})
        self.assertEqual(blocked.reason, "weaker_cover_level")
        self.assertEqual(set(active), {11})

    def test_refresh_and_stack_policies(self):
        active = {}
        definition = {
            "buffId": 20, "coverFlag": 20, "durationInSec": 5,
            "stackPolicy": "refresh",
        }
        apply_buff(active, definition, now=1)
        result = apply_buff(active, definition, now=4)
        self.assertEqual(result.action, "refreshed")
        self.assertEqual(active[20]["expiresAt"], 9)

        stack = {"buffId": 21, "maxStack": 2, "stackPolicy": "stack"}
        apply_buff(active, stack)
        apply_buff(active, stack)
        apply_buff(active, stack)
        self.assertEqual(active[21]["stackCount"], 2)

    def test_debuff_immunity_and_no_immune_override(self):
        active = {}
        blocked = apply_buff(active, {"buffId": 30, "isDebuff": True}, debuff_immune=True)
        self.assertEqual(blocked.reason, "immune")
        accepted = apply_buff(
            active, {"buffId": 31, "isDebuff": True, "noImmune": True}, debuff_immune=True
        )
        self.assertTrue(accepted.applied)

    def test_dispel_respects_kind_no_remove_limit_and_force(self):
        active = {
            1: normalize_buff({"buffId": 1, "isDebuff": True, "coverLevel": 2}),
            2: normalize_buff({"buffId": 2, "isDebuff": True, "coverLevel": 1, "noRemove": True}),
            3: normalize_buff({"buffId": 3, "isDebuff": False}),
        }
        self.assertEqual(dispel(active, debuffs_only=True), (1,))
        self.assertEqual(set(active), {2, 3})
        self.assertEqual(dispel(active, debuffs_only=True, force=True), (2,))

    def test_normalizes_all_trigger_families(self):
        triggers = normalize_triggers({
            "onTimer": {"firstTimeInSec": 1, "repeatTimeInSec": 2, "doMacro": {"addHp": -1}},
            "onAttack": {"chance": 0.25, "macroToTarget": {"addBuffs": [4]}},
            "onUnderAttack": {"macroToSelf": {"addHp": 5}},
        })
        self.assertEqual([item["event"] for item in triggers], ["timer", "attack", "under_attack"])
        self.assertEqual(triggers[0]["repeatInterval"], 2)
        self.assertEqual(triggers[1]["chance"], 0.25)

    def test_expiry_ignores_permanent_buffs(self):
        active = {}
        apply_buff(active, {"buffId": 40, "durationInSec": 5}, now=10)
        apply_buff(active, {"buffId": 41, "durationInSec": 0}, now=10)
        self.assertEqual(expire_buffs(active, 15), (40,))
        self.assertEqual(set(active), {41})


if __name__ == "__main__":
    unittest.main()
