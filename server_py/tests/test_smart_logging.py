import json
import os
import tempfile
import unittest
from unittest.mock import patch


class Session:
    role_name = "hero"
    account_id = "account:hero"
    player_data = {"mapId": "a1", "posX": 10, "posY": 20, "hp": 0, "isDead": True}


class SmartLoggingTests(unittest.TestCase):
    def make_logger(self, root):
        import smart_logging
        with patch.object(smart_logging, "LOG_DIR", root):
            return smart_logging.SmartLogger()

    def test_exception_report_contains_session_context_and_deduplicates(self):
        with tempfile.TemporaryDirectory() as root:
            logger = self.make_logger(root)
            session = Session()
            logger.log("TEST", "UseSkill basic", session=session)
            try:
                raise ValueError("boom")
            except ValueError as exc:
                first = logger.exception("TEST", exc, session=session, command=545)
            try:
                raise ValueError("boom")
            except ValueError as exc:
                second = logger.exception("TEST", exc, session=session, command=545)

            self.assertEqual(first, second)
            reports = os.listdir(os.path.join(root, "errors"))
            self.assertEqual(len(reports), 1)

    def test_metrics_allow_dynamic_counters_and_write_cache_summary(self):
        with tempfile.TemporaryDirectory() as root:
            logger = self.make_logger(root)
            logger.count("packets_sent", 3)
            logger.count("http_requests", 2)
            logger.count("http_cache_hits", 1)
            logger.write_metrics(tick_ms=12.5, sessions=1)
            logger.count("new_counter_added_later", 7)
            logger.write_metrics(tick_ms=2.5, sessions=0)
            metrics_dir = os.path.join(root, "metrics")
            jsonl = next(name for name in os.listdir(metrics_dir) if name.endswith(".jsonl"))
            with open(os.path.join(metrics_dir, jsonl), encoding="utf-8") as file:
                rows = [json.loads(line) for line in file]
            with open(os.path.join(metrics_dir, "cache_summary.json"), encoding="utf-8") as file:
                summary = json.load(file)
            self.assertEqual(rows[0]["packets_sent"], 3)
            self.assertEqual(rows[1]["new_counter_added_later"], 7)
            self.assertEqual(summary["cache_hit_rate_percent"], 50.0)


if __name__ == "__main__":
    unittest.main()
