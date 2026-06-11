"""Thread-safe scheduler for authoritative combat casts and cooldowns."""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass, field
import heapq
import itertools
import threading
import time
from typing import Any, Callable, Hashable, Optional


Clock = Callable[[], float]
Callback = Callable[["CombatEvent"], None]


@dataclass(order=True)
class CombatEvent:
    due_at: float
    sequence: int
    actor_id: Hashable = field(compare=False)
    skill_sn: Hashable = field(compare=False)
    kind: str = field(compare=False)
    callback: Callback = field(compare=False, repr=False)
    tick: int = field(default=0, compare=False)
    tick_count: int = field(default=0, compare=False)
    payload: Any = field(default=None, compare=False)
    cancelled: bool = field(default=False, compare=False)


class CombatScheduler:
    """Schedules casts/channel ticks and owns combat cooldown state.

    Time values are seconds. ``run_due`` is intentionally driven by the caller,
    allowing the world loop to remain authoritative and tests to use a fake clock.
    """

    def __init__(self, clock: Optional[Clock] = None, event_log_limit: int = 1000):
        if event_log_limit < 0:
            raise ValueError("event_log_limit must be >= 0")
        self._clock = clock or time.monotonic
        self._lock = threading.RLock()
        self._queue: list[CombatEvent] = []
        self._sequence = itertools.count()
        self._events_by_cast: dict[tuple[Hashable, Hashable], set[int]] = {}
        self._events_by_sequence: dict[int, CombatEvent] = {}
        self._cooldowns: dict[tuple[Hashable, str, Hashable], float] = {}
        self._event_log = deque(maxlen=event_log_limit)

    def now(self) -> float:
        return float(self._clock())

    def schedule_cast(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        cast_delay: float,
        callback: Callback,
        payload: Any = None,
    ) -> CombatEvent:
        return self._schedule(actor_id, skill_sn, "cast", cast_delay, callback, payload)

    def schedule_skill_cost(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        delay: float,
        callback: Callback,
        payload: Any = None,
    ) -> CombatEvent:
        return self._schedule(actor_id, skill_sn, "skill_cost", delay, callback, payload)

    def schedule_key_times(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        key_times: list[float] | tuple[float, ...],
        callback: Callback,
        payload: Any = None,
        kind: str = "cast_key",
    ) -> list[CombatEvent]:
        if not key_times:
            raise ValueError("key_times must not be empty")
        tick_count = len(key_times)
        return [
            self._schedule(
                actor_id,
                skill_sn,
                kind,
                float(delay),
                callback,
                payload,
                tick=tick + 1,
                tick_count=tick_count,
            )
            for tick, delay in enumerate(key_times)
        ]

    def schedule_channel(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        tick_interval: float,
        tick_count: int,
        callback: Callback,
        payload: Any = None,
        initial_delay: Optional[float] = None,
    ) -> list[CombatEvent]:
        if tick_interval <= 0:
            raise ValueError("tick_interval must be > 0")
        if tick_count < 1:
            raise ValueError("tick_count must be >= 1")
        first_delay = tick_interval if initial_delay is None else initial_delay
        if first_delay < 0:
            raise ValueError("initial_delay must be >= 0")
        return [
            self._schedule(
                actor_id,
                skill_sn,
                "channel_tick",
                first_delay + tick_interval * tick,
                callback,
                payload,
                tick=tick + 1,
                tick_count=tick_count,
            )
            for tick in range(tick_count)
        ]

    def cancel(self, actor_id: Hashable, skill_sn: Optional[Hashable] = None) -> int:
        """Cancel pending events for an actor, optionally for one cast/skill serial."""
        with self._lock:
            keys = (
                [(actor_id, skill_sn)]
                if skill_sn is not None
                else [key for key in self._events_by_cast if key[0] == actor_id]
            )
            cancelled = 0
            for key in keys:
                for sequence in self._events_by_cast.pop(key, set()):
                    event = self._events_by_sequence.pop(sequence, None)
                    if event is not None and not event.cancelled:
                        event.cancelled = True
                        cancelled += 1
                        self._log_locked("cancel", event)
            return cancelled

    def run_due(self, now: Optional[float] = None, max_events: Optional[int] = None) -> int:
        """Run due callbacks in deterministic due-time/insertion order."""
        if max_events is not None and max_events < 0:
            raise ValueError("max_events must be >= 0")
        deadline = self.now() if now is None else float(now)
        ready: list[CombatEvent] = []
        with self._lock:
            while self._queue and self._queue[0].due_at <= deadline:
                if max_events is not None and len(ready) >= max_events:
                    break
                event = heapq.heappop(self._queue)
                self._unlink_locked(event)
                if not event.cancelled:
                    ready.append(event)
                    self._log_locked("execute", event)
        for event in ready:
            event.callback(event)
        return len(ready)

    def start_cooldowns(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        skill_seconds: float = 0,
        group: Optional[Hashable] = None,
        group_seconds: float = 0,
        global_seconds: float = 0,
        now: Optional[float] = None,
    ) -> None:
        current = self.now() if now is None else float(now)
        with self._lock:
            self._set_cooldown_locked(actor_id, "skill", skill_sn, current, skill_seconds)
            if group is not None:
                self._set_cooldown_locked(actor_id, "group", group, current, group_seconds)
            self._set_cooldown_locked(actor_id, "global", "*", current, global_seconds)

    def cooldown_remaining(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        group: Optional[Hashable] = None,
        now: Optional[float] = None,
    ) -> float:
        current = self.now() if now is None else float(now)
        keys = [(actor_id, "skill", skill_sn), (actor_id, "global", "*")]
        if group is not None:
            keys.append((actor_id, "group", group))
        with self._lock:
            remaining = max((self._cooldowns.get(key, current) - current for key in keys), default=0)
            return max(0.0, remaining)

    def is_ready(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        group: Optional[Hashable] = None,
        now: Optional[float] = None,
    ) -> bool:
        return self.cooldown_remaining(actor_id, skill_sn, group, now) <= 0

    def prune_cooldowns(self, now: Optional[float] = None) -> int:
        current = self.now() if now is None else float(now)
        with self._lock:
            expired = [key for key, expires_at in self._cooldowns.items() if expires_at <= current]
            for key in expired:
                del self._cooldowns[key]
            return len(expired)

    def pending_count(self) -> int:
        with self._lock:
            return len(self._events_by_sequence)

    def event_log(self) -> list[dict[str, Any]]:
        with self._lock:
            return list(self._event_log)

    def _schedule(
        self,
        actor_id: Hashable,
        skill_sn: Hashable,
        kind: str,
        delay: float,
        callback: Callback,
        payload: Any,
        tick: int = 0,
        tick_count: int = 0,
    ) -> CombatEvent:
        if delay < 0:
            raise ValueError("delay must be >= 0")
        if not callable(callback):
            raise TypeError("callback must be callable")
        with self._lock:
            event = CombatEvent(
                due_at=self.now() + float(delay),
                sequence=next(self._sequence),
                actor_id=actor_id,
                skill_sn=skill_sn,
                kind=kind,
                callback=callback,
                tick=tick,
                tick_count=tick_count,
                payload=payload,
            )
            heapq.heappush(self._queue, event)
            self._events_by_sequence[event.sequence] = event
            self._events_by_cast.setdefault((actor_id, skill_sn), set()).add(event.sequence)
            self._log_locked("schedule", event)
            return event

    def _unlink_locked(self, event: CombatEvent) -> None:
        self._events_by_sequence.pop(event.sequence, None)
        key = (event.actor_id, event.skill_sn)
        sequences = self._events_by_cast.get(key)
        if sequences is not None:
            sequences.discard(event.sequence)
            if not sequences:
                del self._events_by_cast[key]

    def _set_cooldown_locked(
        self,
        actor_id: Hashable,
        kind: str,
        key: Hashable,
        current: float,
        duration: float,
    ) -> None:
        if duration < 0:
            raise ValueError("cooldown duration must be >= 0")
        if duration:
            cooldown_key = (actor_id, kind, key)
            self._cooldowns[cooldown_key] = max(
                self._cooldowns.get(cooldown_key, current), current + float(duration)
            )

    def _log_locked(self, action: str, event: CombatEvent) -> None:
        self._event_log.append(
            {
                "action": action,
                "actor_id": event.actor_id,
                "skill_sn": event.skill_sn,
                "kind": event.kind,
                "due_at": event.due_at,
                "sequence": event.sequence,
                "tick": event.tick,
                "tick_count": event.tick_count,
            }
        )
