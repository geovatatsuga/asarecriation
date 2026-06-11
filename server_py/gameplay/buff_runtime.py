"""Pure runtime rules for legacy buff definitions.

The module deliberately does not send packets or mutate a world server.  It
normalizes resource data and applies deterministic stacking/dispel decisions to
an ``activeBuffs``-compatible mapping.
"""

from dataclasses import dataclass, field
from typing import Any, Mapping, MutableMapping


STACK_REPLACE = "replace"
STACK_REFRESH = "refresh"
STACK_KEEP_STRONGEST = "keep_strongest"
STACK_STACK = "stack"

TRIGGER_NAMES = ("onTimer", "onTimer2", "onAttack", "onUnderAttack")


def _integer(value: Any, default: int = 0) -> int:
    try:
        return int(value)
    except (TypeError, ValueError):
        return default


def _number(value: Any, default: float = 0.0) -> float:
    try:
        return float(value)
    except (TypeError, ValueError):
        return default


def _macro_from_trigger(trigger: Mapping[str, Any]) -> Any:
    for key in ("doMacro", "macroToSelf", "macroToTarget", "macro"):
        if trigger.get(key):
            return trigger[key]
    return None


def normalize_trigger(name: str, trigger: Any) -> dict[str, Any] | None:
    """Normalize timer and combat triggers into one scheduler-friendly shape."""
    if not isinstance(trigger, Mapping):
        return None
    macro = _macro_from_trigger(trigger)
    if not macro:
        return None
    first = max(0.0, _number(trigger.get("firstTimeInSec"), 0.0))
    repeat = max(0.0, _number(trigger.get("repeatTimeInSec"), 0.0))
    return {
        "event": (
            "timer"
            if name.startswith("onTimer")
            else {"onAttack": "attack", "onUnderAttack": "under_attack"}[name]
        ),
        "source": name,
        "firstDelay": first,
        "repeatInterval": repeat,
        "macro": macro,
        "chance": max(0.0, min(1.0, _number(trigger.get("chance"), 1.0))),
    }


def normalize_triggers(config: Mapping[str, Any]) -> list[dict[str, Any]]:
    return [
        normalized
        for name in TRIGGER_NAMES
        if (normalized := normalize_trigger(name, config.get(name))) is not None
    ]


def normalize_buff(config: Mapping[str, Any]) -> dict[str, Any]:
    buff_id = _integer(config.get("buffId"))
    duration = max(0.0, _number(config.get("durationInSec"), 0.0))
    max_stack = max(1, _integer(config.get("maxStack"), 1))
    policy = str(config.get("stackPolicy") or "").lower()
    if policy not in {STACK_REPLACE, STACK_REFRESH, STACK_KEEP_STRONGEST, STACK_STACK}:
        policy = STACK_STACK if max_stack > 1 else STACK_KEEP_STRONGEST
    return {
        **dict(config),
        "buffId": buff_id,
        "coverFlag": _integer(config.get("coverFlag"), buff_id),
        "coverLevel": _integer(config.get("coverLevel"), 1),
        "durationInSec": duration,
        "maxStack": max_stack,
        "stackPolicy": policy,
        "isDebuff": bool(config.get("isDebuff", False)),
        "noImmune": bool(config.get("noImmune", False)),
        "noRemove": bool(config.get("noRemove", False)),
        "resultStatus": _integer(config.get("resultStatus"), 0),
        "triggers": normalize_triggers(config),
    }


@dataclass(frozen=True)
class BuffResult:
    action: str
    buff_id: int
    removed: tuple[int, ...] = ()
    reason: str = ""
    instance: Mapping[str, Any] | None = field(default=None, compare=False)

    @property
    def applied(self) -> bool:
        return self.action in {"applied", "replaced", "refreshed", "stacked"}


def has_debuff_immunity(active: Mapping[int, Mapping[str, Any]]) -> bool:
    """Return whether active state explicitly grants generic debuff immunity."""
    return any(
        bool(buff.get("debuffImmune") or buff.get("immuneDebuffs"))
        for buff in active.values()
    )


def _same_family(active: Mapping[int, Mapping[str, Any]], cover_flag: int):
    return [
        (buff_id, buff)
        for buff_id, buff in active.items()
        if _integer(buff.get("coverFlag"), _integer(buff_id)) == cover_flag
    ]


def apply_buff(
    active: MutableMapping[int, dict[str, Any]],
    config: Mapping[str, Any],
    *,
    now: float = 0.0,
    source_id: Any = None,
    debuff_immune: bool = False,
) -> BuffResult:
    """Apply a definition to active state using cover and stacking rules."""
    definition = normalize_buff(config)
    buff_id = definition["buffId"]
    if not buff_id:
        return BuffResult("blocked", buff_id, reason="invalid_buff_id")
    if definition["isDebuff"] and not definition["noImmune"] and (
        debuff_immune or has_debuff_immunity(active)
    ):
        return BuffResult("blocked", buff_id, reason="immune")

    family = _same_family(active, definition["coverFlag"])
    strongest_level = max((_integer(buff.get("coverLevel"), 1) for _, buff in family), default=-1)
    same = active.get(buff_id)
    policy = definition["stackPolicy"]

    if policy == STACK_KEEP_STRONGEST and family and definition["coverLevel"] < strongest_level:
        return BuffResult("blocked", buff_id, reason="weaker_cover_level")

    expires_at = now + definition["durationInSec"] if definition["durationInSec"] else 0.0
    instance = {
        **definition,
        "sourceId": source_id,
        "appliedAt": now,
        "expiresAt": expires_at,
        "stackCount": 1,
    }

    if same and policy in {STACK_REFRESH, STACK_KEEP_STRONGEST}:
        previous_count = max(1, _integer(same.get("stackCount"), 1))
        same.update(instance)
        same["stackCount"] = previous_count
        return BuffResult("refreshed", buff_id, instance=same)

    if same and policy == STACK_STACK:
        previous_count = max(1, _integer(same.get("stackCount"), 1))
        count = min(definition["maxStack"], previous_count + 1)
        same.update(instance)
        same["stackCount"] = count
        return BuffResult("stacked", buff_id, instance=same)

    removed = []
    if policy in {STACK_REPLACE, STACK_KEEP_STRONGEST}:
        for old_id, old in family:
            if policy == STACK_KEEP_STRONGEST and _integer(old.get("coverLevel"), 1) > definition["coverLevel"]:
                continue
            del active[old_id]
            removed.append(_integer(old_id))

    active[buff_id] = instance
    return BuffResult("replaced" if removed else "applied", buff_id, tuple(removed), instance=instance)


def dispel(
    active: MutableMapping[int, dict[str, Any]],
    *,
    debuffs_only: bool = False,
    buffs_only: bool = False,
    cover_flags: set[int] | None = None,
    limit: int | None = None,
    force: bool = False,
) -> tuple[int, ...]:
    """Remove eligible effects deterministically, weakest cover level first."""
    candidates = []
    for buff_id, buff in active.items():
        if not force and buff.get("noRemove"):
            continue
        if debuffs_only and not buff.get("isDebuff"):
            continue
        if buffs_only and buff.get("isDebuff"):
            continue
        if cover_flags is not None and _integer(buff.get("coverFlag"), _integer(buff_id)) not in cover_flags:
            continue
        candidates.append((_integer(buff.get("coverLevel"), 1), _integer(buff_id)))
    candidates.sort()
    removed = tuple(buff_id for _, buff_id in candidates[:limit] if limit is None or limit > 0)
    for buff_id in removed:
        active.pop(buff_id, None)
    return removed


def expire_buffs(active: MutableMapping[int, dict[str, Any]], now: float) -> tuple[int, ...]:
    expired = tuple(
        _integer(buff_id)
        for buff_id, buff in active.items()
        if _number(buff.get("expiresAt"), 0.0) > 0 and _number(buff.get("expiresAt")) <= now
    )
    for buff_id in expired:
        active.pop(buff_id, None)
    return expired
