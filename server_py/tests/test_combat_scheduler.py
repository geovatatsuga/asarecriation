import threading
import unittest

from gameplay.combat_scheduler import CombatScheduler


class FakeClock:
    def __init__(self):
        self.value = 0.0

    def __call__(self):
        return self.value

    def advance(self, seconds):
        self.value += seconds


class CombatSchedulerTests(unittest.TestCase):
    def setUp(self):
        self.clock = FakeClock()
        self.scheduler = CombatScheduler(clock=self.clock, event_log_limit=20)

    def test_cast_executes_only_when_due(self):
        calls = []
        self.scheduler.schedule_cast(1, "fireball-1", 2, lambda event: calls.append(event.kind))
        self.assertEqual(self.scheduler.run_due(), 0)
        self.clock.advance(2)
        self.assertEqual(self.scheduler.run_due(), 1)
        self.assertEqual(calls, ["cast"])

    def test_channel_ticks_execute_in_order(self):
        ticks = []
        self.scheduler.schedule_channel(
            1, "beam-1", tick_interval=0.5, tick_count=3, callback=lambda event: ticks.append(event.tick)
        )
        self.clock.advance(1.5)
        self.assertEqual(self.scheduler.run_due(), 3)
        self.assertEqual(ticks, [1, 2, 3])

    def test_cancel_by_skill_and_actor(self):
        calls = []
        self.scheduler.schedule_cast(1, "a", 1, lambda event: calls.append(event.skill_sn))
        self.scheduler.schedule_channel(1, "b", 1, 2, lambda event: calls.append(event.skill_sn))
        self.scheduler.schedule_cast(2, "c", 1, lambda event: calls.append(event.skill_sn))
        self.assertEqual(self.scheduler.cancel(1, "a"), 1)
        self.assertEqual(self.scheduler.cancel(1), 2)
        self.clock.advance(2)
        self.scheduler.run_due()
        self.assertEqual(calls, ["c"])
        self.assertEqual(self.scheduler.pending_count(), 0)

    def test_global_group_and_skill_cooldowns(self):
        self.scheduler.start_cooldowns(
            1, "fireball", skill_seconds=5, group="magic", group_seconds=3, global_seconds=1
        )
        self.assertEqual(self.scheduler.cooldown_remaining(1, "fireball", "magic"), 5)
        self.assertEqual(self.scheduler.cooldown_remaining(1, "ice", "magic"), 3)
        self.assertEqual(self.scheduler.cooldown_remaining(1, "slash"), 1)
        self.clock.advance(3)
        self.assertTrue(self.scheduler.is_ready(1, "ice", "magic"))
        self.assertFalse(self.scheduler.is_ready(1, "fireball", "magic"))

    def test_callbacks_run_outside_lock_and_can_schedule(self):
        calls = []

        def first(event):
            calls.append("first")
            self.scheduler.schedule_cast(1, "second", 0, lambda nested: calls.append("second"))

        self.scheduler.schedule_cast(1, "first", 0, first)
        self.assertEqual(self.scheduler.run_due(), 1)
        self.assertEqual(self.scheduler.run_due(), 1)
        self.assertEqual(calls, ["first", "second"])

    def test_event_log_is_bounded(self):
        scheduler = CombatScheduler(clock=self.clock, event_log_limit=3)
        for index in range(4):
            scheduler.schedule_cast(1, index, 0, lambda event: None)
        self.assertEqual(len(scheduler.event_log()), 3)
        self.assertEqual([entry["skill_sn"] for entry in scheduler.event_log()], [1, 2, 3])

    def test_thread_safe_scheduling_and_cancel(self):
        barrier = threading.Barrier(5)

        def worker(index):
            barrier.wait()
            for serial in range(50):
                self.scheduler.schedule_cast(index, serial, 1, lambda event: None)
            self.scheduler.cancel(index)

        threads = [threading.Thread(target=worker, args=(index,)) for index in range(4)]
        for thread in threads:
            thread.start()
        barrier.wait()
        for thread in threads:
            thread.join()
        self.assertEqual(self.scheduler.pending_count(), 0)


if __name__ == "__main__":
    unittest.main()
