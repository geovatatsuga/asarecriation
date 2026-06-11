"""Audit decoded client resource files for likely gameplay domains."""

import argparse
import json
import os
import sys

SERVER_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if SERVER_DIR not in sys.path:
    sys.path.insert(0, SERVER_DIR)

from gameplay.game_resource_service import GameResourceService


DEFAULT_KEYWORDS = (
    "pet",
    "artifact",
    "glyph",
    "angel",
    "cloak",
    "divine",
    "family",
    "mail",
    "rank",
    "shop",
    "kindGrow",
    "armory",
    "wardrobe",
)


def main() -> int:
    parser = argparse.ArgumentParser(description="Find decoded resource files that mention gameplay domains.")
    parser.add_argument("--decoded-dir", default=None, help="Override game_resources/decoded path.")
    parser.add_argument("--keywords", nargs="*", default=list(DEFAULT_KEYWORDS), help="Domain keywords to search.")
    parser.add_argument("--max-examples", type=int, default=8, help="Example files per keyword.")
    parser.add_argument("--json", action="store_true", help="Print machine-readable JSON.")
    args = parser.parse_args()

    service = GameResourceService(decoded_dir=args.decoded_dir)
    report = service.audit_domains(args.keywords, max_examples=args.max_examples)

    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return 0

    print("# Auditoria de recursos decodificados")
    print()
    print(f"Diretorio: {service.decoded_dir}")
    print()
    print("| Palavra | Arquivos | Exemplos |")
    print("|---|---:|---|")
    for keyword in args.keywords:
        bucket = report.get(keyword, {"file_count": 0, "examples": []})
        examples = ", ".join(bucket["examples"])
        print(f"| {keyword} | {bucket['file_count']} | {examples} |")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
