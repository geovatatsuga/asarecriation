"""Programmatic audit for combat, skill, buff and sync coverage.

The audit is intentionally read-only. It compares legacy resource data against
the currently implemented gameplay vocabulary and scans Python sources for
packet commands used by combat synchronization.
"""

from __future__ import annotations

import argparse
import ast
import json
import os
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, Iterable, Mapping

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from config import GAME_RESOURCES_DIR
from gameplay.buff_runtime import TRIGGER_NAMES, normalize_trigger
from gameplay.combat_rules import ATTR_MAP
from gameplay.macro_engine import MacroEngine
from protocol import commands as command_module


SUPPORTED_RESULT_KEYS = {
    "addBuffs",
    "attack1Attr",
    "attack1AttrMultiply",
    "attack2Attr",
    "attack2AttrMultiply",
    "attackAdded",
    "breakSingChance",
    "buffIds",
    "chance",
    "condition",
    "damage2hp",
    "damageAdded",
    "damageAttr",
    "damageAttrMultiply",
    "damageFixed",
    "displaceChance",
    "displacePixel",
    "doMacro",
    "enabled",
    "fixedHitRate",
    "hp%<=",
    "hpAddByAttr",
    "hpAddByAttrMultiply",
    "hpAddFixed",
    "ignoreTargetDefenseChance",
    "ignoreTargetDefenseRate",
    "instantDeathChance",
    "isSysTrap",
    "keepSpace",
    "mpAddByAttr",
    "mpAddByAttrMultiply",
    "mpAddFixed",
    "onHitToSelf",
    "onHitToTarget",
    "scripts",
    "addThreatRate",
    "addThreatValue",
    "targetCircleRadius",
    "weaknessType",
    "trapCode",
}

RESULT_CONTAINER_KEYS = {
    "default",
    "failure",
    "success",
    "resultRule",
    "toGround",
    "toSelf",
    "toTarget",
    "toOther",
    "onHit",
    "onMiss",
    "onKill",
    "macroToSelf",
    "macroToOther",
    "macroToTarget",
}

RESULT_MACRO_KEYS = {
    "doMacro",
    "onHitToSelf",
    "onHitToTarget",
    "scripts",
}

COMBAT_SYNC_CODES = {
    545, 547, 548, 549, 550, 551, 552, 553, 560, 561, 562, 565, 568, 569, 570,
    578, 658, 659, 689, 769, 770, 801, 803, 804, 805, 806, 807, 808, 865,
    1281, 1283, 1285, 1286,
}


def load_json(path: Path) -> Any:
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


def walk(value: Any) -> Iterable[Any]:
    yield value
    if isinstance(value, Mapping):
        for child in value.values():
            yield from walk(child)
    elif isinstance(value, list):
        for child in value:
            yield from walk(child)


def iter_skill_defs(resource: Any) -> Iterable[Mapping[str, Any]]:
    for node in walk(resource):
        if isinstance(node, Mapping) and isinstance(node.get("levelInfo"), list):
            yield node


def iter_buff_defs(resource: Any) -> Iterable[Mapping[str, Any]]:
    for node in walk(resource):
        if isinstance(node, Mapping) and "buffId" in node:
            yield node


def is_numeric_key(key: Any) -> bool:
    return isinstance(key, str) and key.lstrip("-").isdigit()


def collect_result_keys(value: Any, keys: Counter[str]) -> None:
    if isinstance(value, list):
        for child in value:
            collect_result_keys(child, keys)
        return
    if not isinstance(value, Mapping):
        return
    for key, child in value.items():
        if not is_numeric_key(key) and key not in RESULT_CONTAINER_KEYS:
            keys[str(key)] += 1
        if key not in RESULT_MACRO_KEYS:
            collect_result_keys(child, keys)


def summarize_counter(counter: Counter[str], limit: int = 30) -> list[dict[str, Any]]:
    return [{"name": key, "count": count} for key, count in counter.most_common(limit)]


def analyze_skill_resource(resource: Any, path: str = "<memory>") -> dict[str, Any]:
    skills = list(iter_skill_defs(resource))
    cast_fields: Counter[str] = Counter()
    result_keys: Counter[str] = Counter()
    level_count = cast_levels = result_levels = 0
    skill_cast = skill_result = skill_visual_fly = 0

    for skill in skills:
        levels = skill.get("levelInfo") or []
        has_cast = bool(skill.get("castRule"))
        has_result = bool(skill.get("resultRule"))
        visual = skill.get("visual") or {}
        if isinstance(visual, Mapping) and visual.get("fly"):
            skill_visual_fly += 1
        for level in levels:
            if not isinstance(level, Mapping):
                continue
            level_count += 1
            cast = level.get("castRule") or skill.get("castRule") or {}
            result = level.get("resultRule") or skill.get("resultRule") or {}
            if cast:
                cast_levels += 1
                has_cast = True
                cast_fields.update(str(key) for key in cast)
            if result:
                result_levels += 1
                has_result = True
                collect_result_keys(result, result_keys)
        skill_cast += int(has_cast)
        skill_result += int(has_result)

    supported = Counter({key: result_keys[key] for key in result_keys if key in SUPPORTED_RESULT_KEYS})
    unsupported = Counter({key: result_keys[key] for key in result_keys if key not in SUPPORTED_RESULT_KEYS})
    total_result_keys = sum(result_keys.values())
    covered_result_keys = sum(supported.values())
    return {
        "available": True,
        "path": path,
        "skills": len(skills),
        "levels": level_count,
        "skillsWithCastRule": skill_cast,
        "skillsWithResultRule": skill_result,
        "levelsWithCastRule": cast_levels,
        "levelsWithResultRule": result_levels,
        "skillsWithVisualFly": skill_visual_fly,
        "castFields": summarize_counter(cast_fields, 40),
        "resultEffects": {
            "totalKeys": total_result_keys,
            "supportedKeys": covered_result_keys,
            "coveragePercent": round((covered_result_keys / total_result_keys * 100) if total_result_keys else 0, 2),
            "supported": summarize_counter(supported, 40),
            "unknown": summarize_counter(unsupported, 60),
        },
    }


def analyze_skills(decoded_dir: Path) -> dict[str, Any]:
    skill_path = decoded_dir / "isc.json"
    if not skill_path.exists():
        return {"available": False, "path": str(skill_path)}
    return analyze_skill_resource(load_json(skill_path), str(skill_path))


def analyze_buff_resource(resource: Any, path: str = "<memory>") -> dict[str, Any]:
    buffs = list(iter_buff_defs(resource))

    result_attr_codes: Counter[str] = Counter()
    result_status_values: Counter[str] = Counter()
    trigger_counts: Counter[str] = Counter()
    normalized_triggers: Counter[str] = Counter()
    unknown_trigger_fields: Counter[str] = Counter()
    known_trigger_fields = {
        "chance",
        "doMacro",
        "firstTimeInSec",
        "macro",
        "macroToOther",
        "macroToSelf",
        "macroToTarget",
        "repeatTimeInSec",
    }

    for buff in buffs:
        for code in (buff.get("resultAttr") or {}):
            result_attr_codes[str(code)] += 1
        if buff.get("resultStatus") not in (None, "", 0, "0"):
            result_status_values[str(buff.get("resultStatus"))] += 1
        for name in TRIGGER_NAMES:
            trigger = buff.get(name)
            if isinstance(trigger, Mapping):
                trigger_counts[name] += 1
                normalized = normalize_trigger(name, trigger)
                if normalized:
                    normalized_triggers[name] += 1
                for key in trigger:
                    if key not in known_trigger_fields:
                        unknown_trigger_fields[str(key)] += 1

    supported_attr_codes = Counter({k: v for k, v in result_attr_codes.items() if k in ATTR_MAP})
    unknown_attr_codes = Counter({k: v for k, v in result_attr_codes.items() if k not in ATTR_MAP})
    return {
        "available": True,
        "path": path,
        "buffs": len(buffs),
        "withResultAttr": sum(1 for buff in buffs if buff.get("resultAttr")),
        "withResultStatus": sum(1 for buff in buffs if buff.get("resultStatus") not in (None, "", 0, "0")),
        "withTimersOrTriggers": sum(1 for buff in buffs if any(buff.get(name) for name in TRIGGER_NAMES)),
        "triggerCounts": dict(trigger_counts),
        "normalizedTriggerCounts": dict(normalized_triggers),
        "resultAttr": {
            "totalCodes": sum(result_attr_codes.values()),
            "supportedCodes": sum(supported_attr_codes.values()),
            "coveragePercent": round((sum(supported_attr_codes.values()) / sum(result_attr_codes.values()) * 100) if result_attr_codes else 0, 2),
            "supported": summarize_counter(supported_attr_codes, 40),
            "unknown": summarize_counter(unknown_attr_codes, 60),
        },
        "resultStatusValues": summarize_counter(result_status_values, 40),
        "unknownTriggerFields": summarize_counter(unknown_trigger_fields, 40),
    }


def analyze_buffs(decoded_dir: Path) -> dict[str, Any]:
    path = decoded_dir / "ibc.json"
    if not path.exists():
        return {"available": False, "path": str(path)}
    return analyze_buff_resource(load_json(path), str(path))


def command_lookup() -> dict[str, int]:
    lookup: dict[str, int] = {}
    for obj in vars(command_module).values():
        if isinstance(obj, type) and hasattr(obj, "__members__"):
            for name, member in obj.__members__.items():
                lookup[f"{obj.__name__}.{name}"] = int(member)
                lookup[name] = int(member)
    return lookup


def resolve_build_arg(expr: str, lookup: Mapping[str, int]) -> int | None:
    text = expr.strip()
    try:
        return int(ast.literal_eval(text))
    except Exception:
        pass
    if text in lookup:
        return lookup[text]
    if "." in text and text.split(".")[-1] in lookup:
        return lookup[text.split(".")[-1]]
    return None


def analyze_sync_texts(files: Mapping[str, str], source_root: Path | None = None) -> dict[str, Any]:
    lookup = command_lookup()
    pattern = re.compile(r"\.build\(([^)\n]+)\)")
    command_names = {value: key for key, value in lookup.items() if "." in key}
    observed: dict[int, dict[str, Any]] = {}
    unresolved: Counter[str] = Counter()
    source_root = source_root or Path(".")

    for file_name, text in files.items():
        lines = text.splitlines()
        for line_no, line in enumerate(lines, 1):
            for match in pattern.finditer(line):
                expr = match.group(1).strip()
                code = resolve_build_arg(expr, lookup)
                if code is None:
                    unresolved[expr] += 1
                    continue
                item = observed.setdefault(
                    code,
                    {
                        "code": code,
                        "name": command_names.get(code, ""),
                        "count": 0,
                        "combatSync": code in COMBAT_SYNC_CODES,
                        "locations": [],
                    },
                )
                item["count"] += 1
                if len(item["locations"]) < 8:
                    item["locations"].append(f"{file_name}:{line_no}")

    return {
        "totalBuildCalls": sum(item["count"] for item in observed.values()) + sum(unresolved.values()),
        "resolvedBuildCalls": sum(item["count"] for item in observed.values()),
        "combatSyncCommands": sorted(
            (item for item in observed.values() if item["combatSync"]),
            key=lambda item: item["code"],
        ),
        "allCommands": sorted(observed.values(), key=lambda item: item["code"]),
        "unresolvedBuildArgs": summarize_counter(unresolved, 40),
    }


def analyze_sync_commands(source_root: Path) -> dict[str, Any]:

    scan_roots = ["handlers", "servers", "gameplay", "map_manager.py"]
    files: list[Path] = []
    for item in scan_roots:
        path = source_root / item
        if path.is_file():
            files.append(path)
        elif path.is_dir():
            files.extend(path.rglob("*.py"))

    texts = {}
    for file_path in files:
        try:
            texts[str(file_path.relative_to(source_root))] = file_path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
    return analyze_sync_texts(texts, source_root)


def analyze_macro_engine() -> dict[str, Any]:
    engine = MacroEngine()
    return {
        "supportedOperations": sorted(engine.handlers),
        "supportedConditions": [
            "hasAnyBuff",
            "hitChance",
            "roleLevel<=",
            "roleLevel>=",
            "sysCond.hitChance",
        ],
    }


def build_report(project_root: str | Path | None = None, decoded_dir: str | Path | None = None) -> dict[str, Any]:
    source_root = Path(project_root or Path(__file__).resolve().parents[1]).resolve()
    decoded = Path(decoded_dir or Path(GAME_RESOURCES_DIR) / "decoded").resolve()
    return {
        "paths": {
            "sourceRoot": str(source_root),
            "decodedResources": str(decoded),
        },
        "skills": analyze_skills(decoded),
        "buffs": analyze_buffs(decoded),
        "macroEngine": analyze_macro_engine(),
        "syncCommands": analyze_sync_commands(source_root),
    }


def format_text(report: Mapping[str, Any]) -> str:
    lines = []
    skills = report["skills"]
    buffs = report["buffs"]
    sync = report["syncCommands"]
    lines.append("Combat completion audit")
    lines.append(f"resources={report['paths']['decodedResources']}")
    if skills.get("available"):
        result = skills["resultEffects"]
        lines.append(
            "skills="
            f"{skills['skills']} levels={skills['levels']} "
            f"castLevels={skills['levelsWithCastRule']} resultLevels={skills['levelsWithResultRule']} "
            f"resultCoverage={result['coveragePercent']}%"
        )
        lines.append("unknown result effect keys:")
        for item in result["unknown"][:20]:
            lines.append(f"  {item['count']:6} {item['name']}")
    if buffs.get("available"):
        attr = buffs["resultAttr"]
        lines.append(
            "buffs="
            f"{buffs['buffs']} resultAttr={buffs['withResultAttr']} "
            f"resultStatus={buffs['withResultStatus']} triggers={buffs['withTimersOrTriggers']} "
            f"attrCoverage={attr['coveragePercent']}%"
        )
        lines.append("unknown resultAttr codes:")
        for item in attr["unknown"][:20]:
            lines.append(f"  {item['count']:6} {item['name']}")
    lines.append(
        f"syncBuildCalls={sync['totalBuildCalls']} resolved={sync['resolvedBuildCalls']} "
        f"combatSyncCommands={len(sync['combatSyncCommands'])}"
    )
    for item in sync["combatSyncCommands"][:30]:
        name = f" {item['name']}" if item["name"] else ""
        lines.append(f"  {item['code']:5}{name} x{item['count']}")
    return "\n".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project-root", default=None)
    parser.add_argument("--decoded-dir", default=None)
    parser.add_argument("--format", choices=("text", "json"), default="text")
    args = parser.parse_args(argv)

    report = build_report(args.project_root, args.decoded_dir)
    if args.format == "json":
        print(json.dumps(report, ensure_ascii=False, indent=2, sort_keys=True))
    else:
        print(format_text(report))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
