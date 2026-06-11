import sys
sys.path.insert(0, "/c/Users/jeova/Downloads/Converted on 2022-06-04/server_py")
from unittest.mock import patch
from types import SimpleNamespace

class FakeInventoryManager:
    removed = []
    bought_item = None
    def __init__(self, db):
        self.db = db
    def load_inventory(self, role_name, bag_index):
        if self.bought_item is not None:
            return [self.bought_item]
        if self.removed:
            return []
        return [SimpleNamespace(slot_index=0, item_code='pot_hpmp', item_id='item-1')]
    def get_item_definition(self, item_code):
        return {'ItemType': 1, 'BuyPrice': 10, 'ExtraDataJson': '{"hpAddFixed": 30, "mpAddFixed": 20, "cooldownMs": 2000}'}
    def remove_item(self, role_name, bag_index, slot_index, count):
        self.removed.append((role_name, bag_index, slot_index, count))
        return {'success': True}

with patch('inventory_manager.InventoryManager', FakeInventoryManager):
    from handlers.inventory_handler import InventoryHandler
    print('Import OK')
