import json
import os
import sys
import tempfile
import unittest
from unittest.mock import patch

SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from gameplay.resource_index import ResourceIndex


class ResourceIndexTest(unittest.TestCase):
    def test_basic_attacks_follow_flash_job_index_order(self):
        with tempfile.TemporaryDirectory() as tmp:
            decoded = os.path.join(tmp, "decoded")
            os.makedirs(decoded)
            job_skill = {
                "paladin": [{"code": "xj1"}, {"code": "z00"}],
                "elf": [{"code": "xj2"}, {"code": "z20"}],
                "killer": [{"code": "xj3"}, {"code": "z40"}],
                "fairy": [{"code": "xj4"}, {"code": "z60"}],
                "priest": [{"code": "xj5"}, {"code": "z80"}],
                "trainer": [{"code": "xj6"}, {"code": "za0"}],
                "druid": [{"code": "xj7"}, {"code": "da0"}],
            }
            with open(os.path.join(decoded, "isc.json"), "w", encoding="utf-8") as handle:
                json.dump({"jobSkill": job_skill}, handle)

            with patch("gameplay.resource_index.GAME_RESOURCES_DIR", tmp):
                index = ResourceIndex()

        self.assertEqual(
            [index.basic_attack_for_job_code(job_code) for job_code in range(7)],
            ["xj1", "xj2", "xj3", "xj4", "xj5", "xj6", "xj7"],
        )
        for skill_code in ["xj1", "xj2", "xj3", "xj4", "xj5", "xj6", "xj7"]:
            self.assertTrue(index.is_basic_attack(skill_code))
        self.assertIn("z60", index.skills_for_job_code(3))


if __name__ == "__main__":
    unittest.main()
