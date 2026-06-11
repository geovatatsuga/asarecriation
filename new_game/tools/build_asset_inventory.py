from __future__ import annotations

import json
from collections import Counter, defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
NEW_GAME = ROOT / "new_game"
DECODED = ROOT / "server_py" / "game_resources" / "decoded"
RES = ROOT / "server_py" / "game_resources" / "res"
MANIFEST = ROOT / "server_py" / "game_resources" / "decoded_resource_manifest.json"
OUT_JSON = NEW_GAME / "docs" / "asset_inventory.json"
OUT_MD = NEW_GAME / "docs" / "asset_inventory.md"


def load_json(path: Path):
    with path.open("r", encoding="utf-8") as file:
        return json.load(file)


def classify(resource_id: str, ext: str) -> str:
    rid = resource_id.lower()
    if rid.startswith("ma") or rid in {"map"}:
        return "maps"
    if rid.startswith(("p", "c")) and ext == ".lib":
        return "characters_or_creatures"
    if rid.startswith(("s", "b", "i")) and ext in {".lib", ".img"}:
        return "icons_effects_or_items"
    if rid.startswith("ou"):
        return "job_portraits"
    if rid in {"ipm", "iem", "ihc", "iie", "iss", "idc", "idv", "itl", "itp"}:
        return "core_config"
    if ext == ".json":
        return "config_json"
    if ext == ".lib":
        return "packed_visual_lib"
    if ext == ".img":
        return "image_blob"
    return "other"


def main() -> None:
    manifest = load_json(MANIFEST)
    manifest_resources = {}
    for resource in manifest.get("resources", []):
        rid = resource.get("id")
        if rid:
            manifest_resources[rid] = resource

    decoded_files = []
    category_counts = Counter()
    extension_counts = Counter()
    total_size = 0

    for path in sorted(DECODED.iterdir()):
        if not path.is_file():
            continue
        rid = path.stem
        ext = path.suffix.lower() or "<none>"
        size = path.stat().st_size
        total_size += size
        extension_counts[ext] += 1
        category = classify(rid, path.suffix.lower())
        category_counts[category] += 1
        decoded_files.append(
            {
                "id": rid,
                "file": str(path.relative_to(ROOT)),
                "extension": ext,
                "size": size,
                "category": category,
                "manifest": manifest_resources.get(rid, {}),
            }
        )

    res_groups = []
    for group in manifest.get("resGroups", []):
        res_groups.append(
            {
                "groupId": group.get("groupId"),
                "remark": group.get("remark"),
                "count": len(group.get("resList", [])),
                "resList": group.get("resList", []),
            }
        )

    first_import = [
        "iss",
        "ipm",
        "ihc",
        "iie",
        "idc",
        "idv",
        "ma1",
        "ma2",
        "map",
        "ou0",
        "ou1",
        "ou2",
        "ou3",
        "ou4",
        "ou5",
        "ou6",
    ]

    inventory = {
        "generatedFrom": str(ROOT),
        "decodedDir": str(DECODED.relative_to(ROOT)),
        "resDir": str(RES.relative_to(ROOT)),
        "manifest": str(MANIFEST.relative_to(ROOT)),
        "summary": {
            "decodedFiles": len(decoded_files),
            "totalDecodedBytes": total_size,
            "extensions": dict(extension_counts),
            "categories": dict(category_counts),
        },
        "resGroups": res_groups,
        "firstImportCandidates": [
            item for item in decoded_files if item["id"] in first_import
        ],
        "files": decoded_files,
    }

    OUT_JSON.write_text(json.dumps(inventory, ensure_ascii=False, indent=2), encoding="utf-8")

    lines = [
        "# Asset Inventory",
        "",
        "Inventario gerado a partir dos recursos decodificados do cliente Flash.",
        "",
        "## Resumo",
        "",
        f"- Arquivos decodificados: {len(decoded_files)}",
        f"- Tamanho total decodificado: {total_size / 1024 / 1024:.2f} MB",
        "",
        "## Categorias",
        "",
    ]
    for category, count in category_counts.most_common():
        lines.append(f"- `{category}`: {count}")
    lines.extend(["", "## Extensoes", ""])
    for ext, count in extension_counts.most_common():
        lines.append(f"- `{ext}`: {count}")
    lines.extend(["", "## Grupos De Carregamento Do Cliente", ""])
    for group in res_groups:
        lines.append(f"- `{group['groupId']}`: {group['count']} recursos")
    lines.extend(["", "## Primeiros Candidatos Para Importar No Godot", ""])
    for item in inventory["firstImportCandidates"]:
        size_kb = item["size"] / 1024
        lines.append(f"- `{item['id']}` -> `{item['file']}` ({item['category']}, {size_kb:.1f} KB)")
    lines.extend(
        [
            "",
            "## Proxima Leitura Recomendada",
            "",
            "1. Entender `ma1.json` e `ma2.json` para escolher um mapa pequeno de teste.",
            "2. Entender `ipm.json` para renderizar um personagem base.",
            "3. Investigar `.lib`/`.img` para converter sprites para PNG ou atlas Godot.",
            "4. Criar importador apenas de leitura, copiando assets para `client_godot/assets/legacy`.",
        ]
    )
    OUT_MD.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(OUT_JSON)
    print(OUT_MD)


if __name__ == "__main__":
    main()
