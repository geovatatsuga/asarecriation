import json
import os
from collections import defaultdict
from typing import Any, Dict, Iterable, List, Optional

from config import GAME_RESOURCES_DIR


class GameResourceService:
    """Lazy access to decoded client resource catalogs, grouped by domain."""

    DEFAULT_CATALOGS = {
        "skills": ("isc.json",),
        "buffs": ("ibc.json",),
        "items": ("iie.json", "iix.json"),
        "shops": ("isp.json",),
        "tasks": ("itl.json",),
        "system": ("iss.json",),
        "equipment_models": ("iem.json",),
        "resource_models": ("irm.json",),
    }

    def __init__(self, decoded_dir: Optional[str] = None, catalogs: Optional[Dict[str, Iterable[str]]] = None):
        self.decoded_dir = decoded_dir or os.path.join(GAME_RESOURCES_DIR, "decoded")
        self.catalogs = {
            name: tuple(files)
            for name, files in (catalogs or self.DEFAULT_CATALOGS).items()
        }
        self._json_cache: Dict[str, Any] = {}
        self._domain_cache: Dict[str, List[Any]] = {}
        self._code_indexes: Dict[str, Dict[str, Dict[str, Any]]] = {}
        self._buff_index: Optional[Dict[int, Dict[str, Any]]] = None

    def load_json(self, filename: str) -> Any:
        if filename not in self._json_cache:
            path = os.path.join(self.decoded_dir, filename)
            with open(path, "r", encoding="utf-8") as handle:
                self._json_cache[filename] = json.load(handle)
        return self._json_cache[filename]

    def domain(self, name: str) -> List[Any]:
        if name not in self._domain_cache:
            loaded = []
            for filename in self.catalogs.get(name, ()):
                path = os.path.join(self.decoded_dir, filename)
                if os.path.exists(path):
                    loaded.append(self.load_json(filename))
            self._domain_cache[name] = loaded
        return self._domain_cache[name]

    def index_by_code(self, domain: str) -> Dict[str, Dict[str, Any]]:
        if domain not in self._code_indexes:
            index: Dict[str, Dict[str, Any]] = {}
            for catalog in self.domain(domain):
                self._walk_code_objects(catalog, index)
            self._code_indexes[domain] = index
        return self._code_indexes[domain]

    def item(self, code: str) -> Dict[str, Any]:
        return self.index_by_code("items").get(str(code), {})

    def skill(self, code: str) -> Dict[str, Any]:
        return self.index_by_code("skills").get(str(code), {})

    def buff(self, buff_id: int) -> Dict[str, Any]:
        if self._buff_index is None:
            found: Dict[int, Dict[str, Any]] = {}
            for catalog in self.domain("buffs"):
                self._walk_buff_objects(catalog, found)
            self._buff_index = found
        return self._buff_index.get(int(buff_id), {})

    def shop_items(self) -> List[Dict[str, Any]]:
        for catalog in self.domain("shops"):
            if isinstance(catalog, dict) and isinstance(catalog.get("itemList"), list):
                return catalog["itemList"]
        return []

    def audit_domains(self, keywords: Iterable[str], max_examples: int = 8) -> Dict[str, Dict[str, Any]]:
        results = {
            keyword: {"file_count": 0, "files": [], "examples": []}
            for keyword in keywords
        }
        if not os.path.isdir(self.decoded_dir):
            return results
        for filename in sorted(os.listdir(self.decoded_dir)):
            if not filename.endswith(".json"):
                continue
            path = os.path.join(self.decoded_dir, filename)
            try:
                with open(path, "r", encoding="utf-8", errors="ignore") as handle:
                    text = handle.read()
            except OSError:
                continue
            lowered = text.lower()
            for keyword in results:
                if keyword.lower() in lowered or keyword.lower() in filename.lower():
                    bucket = results[keyword]
                    bucket["file_count"] += 1
                    bucket["files"].append(filename)
                    if len(bucket["examples"]) < max_examples:
                        bucket["examples"].append(filename)
        return results

    def loaded_files(self) -> List[str]:
        return sorted(self._json_cache)

    def _walk_code_objects(self, value: Any, index: Dict[str, Dict[str, Any]]) -> None:
        if isinstance(value, list):
            for item in value:
                self._walk_code_objects(item, index)
        elif isinstance(value, dict):
            code = value.get("code") or value.get("skillCode")
            if code:
                index[str(code)] = value
            for child in value.values():
                self._walk_code_objects(child, index)

    def _walk_buff_objects(self, value: Any, index: Dict[int, Dict[str, Any]]) -> None:
        if isinstance(value, list):
            for item in value:
                self._walk_buff_objects(item, index)
        elif isinstance(value, dict):
            if value.get("buffId") is not None:
                index[int(value["buffId"])] = value
            for child in value.values():
                self._walk_buff_objects(child, index)
