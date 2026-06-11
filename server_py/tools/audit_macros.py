"""Audit the legacy resource DSL and report implementation coverage."""

import json
import os
import sys
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from config import GAME_RESOURCES_DIR
from gameplay.macro_engine import MacroEngine


MACRO_KEYS = {"doMacro", "elseDoMacro", "functionPara", "onTimer", "onTimer2", "onAttack", "onUnderAttack"}


def walk(value, operations, conditions):
    if isinstance(value, list):
        for child in value:
            walk(child, operations, conditions)
        return
    if not isinstance(value, dict):
        return
    for key, child in value.items():
        if key in ("ifCondition", "condition") and isinstance(child, dict):
            conditions.update(child.keys())
        if key in MACRO_KEYS and isinstance(child, dict):
            operations.update(child.keys())
        walk(child, operations, conditions)


def main():
    operations, conditions = Counter(), Counter()
    files = 0
    root = os.path.join(GAME_RESOURCES_DIR, "decoded")
    for base, _, names in os.walk(root):
        for name in names:
            if not name.endswith(".json"):
                continue
            try:
                with open(os.path.join(base, name), "r", encoding="utf-8") as handle:
                    walk(json.load(handle), operations, conditions)
                files += 1
            except Exception:
                pass

    supported = set(MacroEngine().handlers)
    unsupported = [(key, count) for key, count in operations.most_common() if key not in supported]
    covered = sum(count for key, count in operations.items() if key in supported)
    total = sum(operations.values())
    print(f"files={files} operations={total} covered={covered} coverage={(covered / total * 100 if total else 0):.2f}%")
    print("\nTop unsupported operations:")
    for key, count in unsupported[:40]:
        print(f"{count:7}  {key}")
    print("\nTop conditions:")
    for key, count in conditions.most_common(30):
        print(f"{count:7}  {key}")


if __name__ == "__main__":
    main()
