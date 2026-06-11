import json
import os


class ItemConfigLoader:
    _instance = None
    _items_cache = {}

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._load_items()
        return cls._instance

    def _load_items(self):
        try:
            server_dir = os.path.dirname(__file__)
            candidates = [
                os.path.join(server_dir, "..", "downloader", "out", "iie.txt"),
                os.path.join(server_dir, "game_resources", "decoded", "iie.json"),
            ]
            iie_path = next((path for path in candidates if os.path.isfile(path)), None)
            if not iie_path:
                raise FileNotFoundError("Nenhuma definicao de itens iie encontrada")

            with open(iie_path, "r", encoding="utf-8") as file:
                items_list = json.load(file)

            for item in items_list:
                item_code = item.get("code")
                if item_code:
                    self._items_cache[item_code] = item

            print(f"Item Config Loader: {len(self._items_cache)} itens carregados")
        except Exception as exc:
            print(f"Erro ao carregar definicoes de itens: {exc}")
            self._items_cache = {}

    def get_item(self, item_code: str) -> dict:
        return self._items_cache.get(item_code)

    def get_model_code(self, item_code: str) -> str:
        item = self.get_item(item_code)
        if item and "properties" in item:
            return item["properties"].get("modelCode", "")
        return ""


item_config = ItemConfigLoader()
