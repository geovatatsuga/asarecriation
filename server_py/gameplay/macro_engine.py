import random
from collections import Counter
from dataclasses import dataclass


class MacroExecutionError(Exception):
    pass


@dataclass
class MacroContext:
    server: object
    session: object = None
    target_session: object = None
    monster: object = None
    source: object = None


class MacroEngine:
    """Small, deterministic, whitelisted interpreter for resource macros."""

    MAX_DEPTH = 12
    MAX_OPERATIONS = 200

    def __init__(self, strict=False):
        self.handlers = {}
        self.strict = strict
        self.unsupported_operations = Counter()
        self.unsupported_conditions = Counter()
        self._register_core_handlers()

    def register(self, name, handler):
        self.handlers[name] = handler

    def execute(self, macro, context, depth=0, budget=None):
        if not macro:
            return
        if depth > self.MAX_DEPTH:
            raise MacroExecutionError("macro nesting limit exceeded")
        budget = budget or {"remaining": self.MAX_OPERATIONS}
        if isinstance(macro, list):
            for item in macro:
                self.execute(item, context, depth + 1, budget)
            return
        if not isinstance(macro, dict):
            return
        for operation, value in macro.items():
            budget["remaining"] -= 1
            if budget["remaining"] < 0:
                raise MacroExecutionError("macro operation budget exceeded")
            handler = self.handlers.get(operation)
            if handler:
                handler(value, context, depth, budget)
            else:
                self.unsupported_operations[operation] += 1
                if self.strict:
                    raise MacroExecutionError(f"unsupported macro operation: {operation}")

    def execute_scripts(self, scripts, context, depth=0, budget=None):
        budget = budget or {"remaining": self.MAX_OPERATIONS}
        for script in scripts or []:
            condition = script.get("ifCondition")
            matched = self.evaluate(condition, context) if condition else True
            macro = script.get("doMacro") if matched else script.get("elseDoMacro")
            self.execute(macro, context, depth + 1, budget)
            if matched and script.get("breakWhen"):
                break

    def evaluate(self, condition, context):
        if not condition:
            return True
        session = context.target_session or context.session
        pd = session.player_data if session and session.player_data else {}
        for key, value in condition.items():
            if key in ("hitChance", "sysCond") and isinstance(value, dict):
                chance = value.get("hitChance")
                if chance is not None and random.random() > float(chance):
                    return False
            elif key == "hitChance" and random.random() > float(value):
                return False
            elif key == "roleLevel>=" and int(pd.get("level", 1)) < int(value):
                return False
            elif key == "roleLevel<=" and int(pd.get("level", 1)) > int(value):
                return False
            elif key == "hasAnyBuff":
                active = pd.get("activeBuffs", {})
                if not any(int(x) in active for x in value):
                    return False
            else:
                self.unsupported_conditions[key] += 1
                if self.strict:
                    raise MacroExecutionError(f"unsupported macro condition: {key}")
        return True

    def _register_core_handlers(self):
        self.register("execScripts", lambda value, ctx, depth, budget: self.execute_scripts(value, ctx, depth, budget))
        self.register("addBuffs", self._add_buffs)
        self.register("removeBuffs", self._remove_buffs)
        self.register("clearDebuffs", self._clear_debuffs)
        self.register("addHp", self._add_hp)
        self.register("addHp%", self._add_hp_percent)
        self.register("addMp", self._add_mp)
        self.register("addMp%", self._add_mp_percent)
        self.register("addGold", self._add_gold)
        self.register("releaseTrap", lambda value, ctx, depth, budget: self._release_map_objects("releaseTrap", value, ctx))
        self.register("releaseSysTrap", lambda value, ctx, depth, budget: self._release_map_objects("releaseSysTrap", value, ctx))
        self.register("releaseMonster", lambda value, ctx, depth, budget: self._release_map_objects("releaseMonster", value, ctx))
        self.register("trapCode", lambda value, ctx, depth, budget: self._release_map_objects("trapCode", value, ctx))

    def _target(self, ctx):
        return ctx.target_session or ctx.session

    def _add_buffs(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if not target:
            return
        values = value if isinstance(value, list) else [value]
        for buff_id in values:
            ctx.server.apply_buff(target, int(buff_id), 10)

    def _remove_buffs(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if not target:
            return
        values = value if isinstance(value, list) else [value]
        active = target.player_data.setdefault("activeBuffs", {})
        removed = [int(x) for x in values if int(x) in active]
        for buff_id in removed:
            del active[buff_id]
        if removed:
            ctx.server.notify_buff_change(target, removed=removed)

    def _clear_debuffs(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if target:
            active = target.player_data.setdefault("activeBuffs", {})
            removed = [buff_id for buff_id, buff in active.items() if buff.get("isDebuff")]
            for buff_id in removed:
                del active[buff_id]
            if removed:
                ctx.server.notify_buff_change(target, removed=removed)

    def _change_vital(self, ctx, key, maximum, amount, local_command, remote):
        target = self._target(ctx)
        if not target and ctx.monster and key == "hp":
            monster = ctx.monster
            monster.hp = max(0, min(float(monster.hp_max), float(monster.hp) + float(amount)))
            return
        if not target:
            return
        pd = target.player_data
        old = float(pd.get(key, 0))
        new = max(0, min(float(pd.get(maximum, old)), old + float(amount)))
        changed = new - old
        pd[key] = new
        from protocol.packet_builder import PacketBuilder
        packet = PacketBuilder()
        if key == "hp":
            packet.write_double(changed)
            packet.write_double(new)
            packet.write_string("")
            packet.write_bool(False)
            packet.write_bool(False)
        else:
            packet.write_short(int(changed))
            packet.write_int(int(new))
            packet.write_string("")
        target.send_packet(packet.build(local_command))
        remote(target, changed, "")

    def _add_hp(self, value, ctx, depth, budget):
        self._change_vital(ctx, "hp", "hpMax", value, 550, getattr(ctx.server, "broadcast_remote_hp", lambda *args: None))

    def _add_hp_percent(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if target:
            self._add_hp(float(target.player_data.get("hpMax", 0)) * float(value) / 100.0, ctx, depth, budget)

    def _add_mp(self, value, ctx, depth, budget):
        self._change_vital(ctx, "mp", "mpMax", value, 552, getattr(ctx.server, "broadcast_remote_mp", lambda *args: None))

    def _add_mp_percent(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if target:
            self._add_mp(float(target.player_data.get("mpMax", 0)) * float(value) / 100.0, ctx, depth, budget)

    def _add_gold(self, value, ctx, depth, budget):
        target = self._target(ctx)
        if not target:
            return
        amount = int(value)
        target.player_data["gold"] = int(target.player_data.get("gold", 0)) + amount
        ctx.server._get_db().execute_non_query("UPDATE TB_Role SET Gold=Gold+? WHERE Name=?", (amount, target.role_name))
        target._send_gold_change(amount)

    def _release_map_objects(self, key, value, ctx):
        session = ctx.session or ctx.target_session
        if not session or not getattr(ctx.server, "map_manager", None):
            return
        pd = session.player_data or {}
        map_instance = ctx.server.map_manager.get_map(pd.get("mapId"))
        if not map_instance:
            return
        macro = {key: value}
        map_instance.release_from_macro(macro, session.role_name, pd.get("posX", 0), pd.get("posY", 0), server=ctx.server)
