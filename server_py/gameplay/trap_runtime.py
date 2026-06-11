"""Runtime isolado para armadilhas e invocacoes temporarias de combate."""

from dataclasses import dataclass, field
import math
from typing import Callable, Dict, Iterable, List, Optional


def _number(value, default=0.0):
    try:
        return float(value)
    except (TypeError, ValueError):
        return float(default)


def _string(value, default=""):
    if value is None:
        return default
    return str(value)


def _first(mapping, *keys, default=None):
    if not isinstance(mapping, dict):
        return default
    for key in keys:
        if key in mapping and mapping[key] is not None:
            return mapping[key]
    return default


def _macro_from(value):
    if not isinstance(value, dict):
        return None
    return (
        value.get("doMacro")
        or value.get("macro")
        or value.get("onTrigger")
        or value.get("onTick")
        or (value.get("onTimer") or {}).get("doMacro")
    )


@dataclass
class TrapInstance:
    instance_id: str
    code: str
    map_id: str
    owner_id: str
    x: float
    y: float
    radius: float = 80.0
    damage: float = 0.0
    macro: object = None
    created_at: float = 0.0
    expires_at: Optional[float] = None
    tick_interval: float = 1.0
    next_tick_at: float = 0.0
    trigger_once: bool = False
    triggered_targets: set = field(default_factory=set)
    source: dict = field(default_factory=dict)

    def active_at(self, now: float) -> bool:
        return self.expires_at is None or now < self.expires_at

    def contains(self, target) -> bool:
        tx = _number(getattr(target, "x", None), _number(getattr(target, "posX", 0)))
        ty = _number(getattr(target, "y", None), _number(getattr(target, "posY", 0)))
        return math.hypot(tx - self.x, ty - self.y) <= self.radius


@dataclass
class SummonInstance:
    instance_id: str
    code: str
    map_id: str
    owner_id: str
    x: float
    y: float
    mob_def: dict
    created_at: float = 0.0
    expires_at: Optional[float] = None
    source: dict = field(default_factory=dict)

    def active_at(self, now: float) -> bool:
        return self.expires_at is None or now < self.expires_at


@dataclass
class TrapEvent:
    kind: str
    instance_id: str
    payload: dict = field(default_factory=dict)


class TrapRuntime:
    """Mantem traps/summons por mapa e resolve ticks sem depender de handlers."""

    DEFAULT_TRAP_DURATION = 8.0
    DEFAULT_SUMMON_DURATION = 30.0

    def __init__(self, map_id: str):
        self.map_id = map_id
        self.traps: Dict[str, TrapInstance] = {}
        self.summons: Dict[str, SummonInstance] = {}
        self._next_trap_id = 1
        self._next_summon_id = 1

    def release_trap(
        self,
        trap_code,
        owner_id,
        x,
        y,
        definition=None,
        now: float = 0.0,
        sys_trap: bool = False,
    ) -> TrapInstance:
        definition = definition or {}
        code = _string(trap_code)
        instance_id = f"trap_{self.map_id}_{self._next_trap_id}"
        self._next_trap_id += 1
        duration = _number(
            _first(definition, "durationInSec", "duration", "lifeTimeInSec", "lifeTime", default=self.DEFAULT_TRAP_DURATION),
            self.DEFAULT_TRAP_DURATION,
        )
        interval = max(
            0.05,
            _number(_first(definition, "tickIntervalInSec", "repeatTimeInSec", "intervalInSec", "interval", default=1), 1),
        )
        radius = max(
            1.0,
            _number(_first(definition, "radius", "triggerRadius", "areaRadius", "range", default=80), 80),
        )
        damage = _number(_first(definition, "damage", "attackAdded", "hpDamage", default=0), 0)
        first_delay = _number(_first(definition, "firstTimeInSec", "firstDelay", default=0), 0)
        trap = TrapInstance(
            instance_id=instance_id,
            code=code,
            map_id=self.map_id,
            owner_id=_string(owner_id),
            x=_number(x),
            y=_number(y),
            radius=radius,
            damage=damage,
            macro=_macro_from(definition),
            created_at=now,
            expires_at=None if duration <= 0 else now + duration,
            tick_interval=interval,
            next_tick_at=now + max(0.0, first_delay),
            trigger_once=bool(_first(definition, "triggerOnce", "once", default=False)),
            source={**definition, "sysTrap": bool(sys_trap)},
        )
        self.traps[instance_id] = trap
        return trap

    def release_sys_trap(self, trap_code, owner_id, x, y, definition=None, now: float = 0.0) -> TrapInstance:
        return self.release_trap(trap_code, owner_id, x, y, definition, now, sys_trap=True)

    def release_summon(
        self,
        monster_code,
        owner_id,
        x,
        y,
        mob_definitions=None,
        definition=None,
        now: float = 0.0,
    ) -> SummonInstance:
        definition = definition or {}
        mob_definitions = mob_definitions or {}
        code = _string(monster_code)
        mob_def = dict(mob_definitions.get(code) or definition.get("mobDef") or {"code": code, "hp": 100, "level": 1})
        instance_id = f"summon_{self.map_id}_{self._next_summon_id}"
        self._next_summon_id += 1
        duration = _number(
            _first(definition, "durationInSec", "duration", "lifeTimeInSec", "lifeTime", default=self.DEFAULT_SUMMON_DURATION),
            self.DEFAULT_SUMMON_DURATION,
        )
        summon = SummonInstance(
            instance_id=instance_id,
            code=code,
            map_id=self.map_id,
            owner_id=_string(owner_id),
            x=_number(x),
            y=_number(y),
            mob_def=mob_def,
            created_at=now,
            expires_at=None if duration <= 0 else now + duration,
            source=definition,
        )
        self.summons[instance_id] = summon
        return summon

    def release_from_macro(
        self,
        macro,
        owner_id,
        x,
        y,
        mob_definitions=None,
        now: float = 0.0,
    ) -> List[TrapEvent]:
        events: List[TrapEvent] = []
        for op in _as_list((macro or {}).get("trapCode")):
            trap = self.release_trap(op, owner_id, x, y, now=now)
            events.append(TrapEvent("trap_released", trap.instance_id, {"trap": trap}))
        for op in _as_list((macro or {}).get("releaseTrap")):
            code, definition = _code_and_definition(op)
            trap = self.release_trap(code, owner_id, x, y, definition, now)
            events.append(TrapEvent("trap_released", trap.instance_id, {"trap": trap}))
        for op in _as_list((macro or {}).get("releaseSysTrap")):
            code, definition = _code_and_definition(op)
            trap = self.release_sys_trap(code, owner_id, x, y, definition, now)
            events.append(TrapEvent("trap_released", trap.instance_id, {"trap": trap}))
        for op in _as_list((macro or {}).get("releaseMonster")):
            code, definition = _code_and_definition(op)
            summon = self.release_summon(code, owner_id, x, y, mob_definitions, definition, now)
            events.append(TrapEvent("summon_spawned", summon.instance_id, {"summon": summon}))
        return events

    def tick(
        self,
        now: float,
        targets: Iterable = (),
        macro_executor: Optional[Callable[[object, TrapInstance, object], None]] = None,
    ) -> List[TrapEvent]:
        events: List[TrapEvent] = []
        for trap in list(self.traps.values()):
            if not trap.active_at(now):
                del self.traps[trap.instance_id]
                events.append(TrapEvent("trap_expired", trap.instance_id, {"trap": trap}))
                continue
            if now < trap.next_tick_at:
                continue
            trap.next_tick_at = now + trap.tick_interval
            touched = [target for target in targets if _target_alive(target) and trap.contains(target)]
            if not touched:
                continue
            events.append(TrapEvent("trap_triggered", trap.instance_id, {"trap": trap, "targets": touched}))
            for target in touched:
                target_id = _target_id(target)
                if trap.trigger_once and target_id in trap.triggered_targets:
                    continue
                trap.triggered_targets.add(target_id)
                if trap.damage:
                    _apply_damage(target, trap.damage)
                    events.append(TrapEvent("damage", trap.instance_id, {"target": target, "amount": int(trap.damage)}))
                if trap.macro is not None:
                    if macro_executor:
                        macro_executor(trap.macro, trap, target)
                    events.append(TrapEvent("macro", trap.instance_id, {"target": target, "macro": trap.macro}))
            if trap.trigger_once:
                del self.traps[trap.instance_id]
                events.append(TrapEvent("trap_expired", trap.instance_id, {"trap": trap}))
        for summon in list(self.summons.values()):
            if not summon.active_at(now):
                del self.summons[summon.instance_id]
                events.append(TrapEvent("summon_expired", summon.instance_id, {"summon": summon}))
        return events


def _as_list(value):
    if value is None:
        return []
    return value if isinstance(value, list) else [value]


def _code_and_definition(value):
    if isinstance(value, dict):
        code = _first(value, "code", "trapCode", "sysTrapCode", "monsterCode", "mobCode", "id", default="")
        return code, value
    return value, {}


def _target_id(target):
    return _string(
        getattr(target, "instance_id", None)
        or getattr(target, "role_name", None)
        or getattr(target, "id", None)
        or id(target)
    )


def _target_alive(target):
    if bool(getattr(target, "is_dead", False)):
        return False
    hp = getattr(target, "hp", None)
    if hp is None and hasattr(target, "player_data"):
        hp = target.player_data.get("hp")
    return _number(hp, 1) > 0


def _apply_damage(target, amount):
    if hasattr(target, "hp"):
        target.hp = max(0, _number(target.hp) - _number(amount))
        if target.hp <= 0 and hasattr(target, "is_dead"):
            target.is_dead = True
        return
    if hasattr(target, "player_data"):
        target.player_data["hp"] = max(0, _number(target.player_data.get("hp", 0)) - _number(amount))
        if target.player_data["hp"] <= 0:
            target.player_data["isDead"] = True
