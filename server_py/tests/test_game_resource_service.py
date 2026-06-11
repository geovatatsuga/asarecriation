import json
import os
import tempfile
import unittest

from gameplay.game_resource_service import GameResourceService


class GameResourceServiceTest(unittest.TestCase):
    def test_lazy_loads_only_requested_domain(self):
        with tempfile.TemporaryDirectory() as tmp:
            self._write_json(tmp, "iie.json", [{"code": "item_a", "name": "Item A"}])
            self._write_json(tmp, "isc.json", {"jobSkill": {"paladin": [{"skillCode": "sk1"}]}})
            service = GameResourceService(decoded_dir=tmp)

            self.assertEqual(service.loaded_files(), [])
            self.assertEqual(service.item("item_a")["name"], "Item A")
            self.assertEqual(service.loaded_files(), ["iie.json"])

    def test_indexes_skill_buff_and_shop_domains(self):
        with tempfile.TemporaryDirectory() as tmp:
            self._write_json(tmp, "isc.json", {"jobSkill": {"paladin": [{"skillCode": "sk1", "target": 1}]}})
            self._write_json(tmp, "ibc.json", [{"buffId": 7, "buffName": "Shield"}])
            self._write_json(tmp, "isp.json", {"itemList": [{"code": "shop_item"}]})
            service = GameResourceService(decoded_dir=tmp)

            self.assertEqual(service.skill("sk1")["target"], 1)
            self.assertEqual(service.buff(7)["buffName"], "Shield")
            self.assertEqual(service.shop_items(), [{"code": "shop_item"}])

    def test_audit_domains_finds_filename_and_content_matches(self):
        with tempfile.TemporaryDirectory() as tmp:
            self._write_json(tmp, "angel_config.json", {"name": "anything"})
            self._write_json(tmp, "misc.json", {"note": "artifact upgrade rule"})
            service = GameResourceService(decoded_dir=tmp)

            report = service.audit_domains(["angel", "artifact"])

            self.assertEqual(report["angel"]["file_count"], 1)
            self.assertEqual(report["artifact"]["file_count"], 1)

    def _write_json(self, directory, filename, value):
        with open(os.path.join(directory, filename), "w", encoding="utf-8") as handle:
            json.dump(value, handle)


if __name__ == "__main__":
    unittest.main()
