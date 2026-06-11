import os
import sys
import unittest


SERVER_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if SERVER_ROOT not in sys.path:
    sys.path.insert(0, SERVER_ROOT)

from player_data_manager import PlayerDataManager


class FakeDb:
    def __init__(self, task_rows=None):
        self.task_rows = task_rows or []
        self.updated_tasks = []
        self.removed_tasks = []

    def execute_query(self, query, params=()):
        return self.task_rows

    def call_procedure(self, name, params):
        if name == "SP_UpdateTaskStatus":
            self.updated_tasks.append(params)

    def remove_task_status(self, role_name, task_id):
        self.removed_tasks.append((role_name, task_id))


class PlayerDataManagerTaskRecorderTests(unittest.TestCase):
    def test_new_role_starts_on_goddess_first_task(self):
        db = FakeDb()
        manager = PlayerDataManager(db)

        recorder = manager._load_task_recorder("Hero")

        self.assertEqual(recorder["doingTasks"], [4999])
        self.assertEqual(recorder["doingAllocators"], {18: 4999})
        self.assertEqual(recorder["doneTasks"], {})
        self.assertEqual(db.updated_tasks, [("Hero", 4999, "D", 18, 0)])

    def test_legacy_seed_that_skipped_goddess_is_repaired(self):
        db = FakeDb(
            [
                {
                    "TaskId": 4999,
                    "TaskStatus": "C",
                    "AllocatorId": 0,
                    "CompletedCount": 1,
                },
                {
                    "TaskId": 5000,
                    "TaskStatus": "D",
                    "AllocatorId": 18,
                    "CompletedCount": 0,
                },
            ]
        )
        manager = PlayerDataManager(db)

        recorder = manager._load_task_recorder("Hero")

        self.assertEqual(recorder["doingTasks"], [4999])
        self.assertEqual(recorder["doingAllocators"], {18: 4999})
        self.assertEqual(recorder["doneTasks"], {})
        self.assertEqual(db.updated_tasks, [("Hero", 4999, "D", 18, 0)])
        self.assertEqual(db.removed_tasks, [("Hero", 5000)])


if __name__ == "__main__":
    unittest.main()
