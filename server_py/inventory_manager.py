from typing import Dict, List, Optional, Any
from dataclasses import dataclass
import uuid

@dataclass
class ItemInfo:
    inventory_id: int
    slot_index: int
    item_id: str
    item_code: str
    item_count: int
    is_bound: bool = False
    enhance_level: int = 0
    durability: int = 100
    max_durability: int = 100
    renew_rule_index: int = 0
    extra_data: Optional[str] = None

@dataclass
class BagInfo:
    bag_index: int
    capacity: int
    items: List[ItemInfo]

class InventoryManager:
    
    def __init__(self, db):
        self.db = db
    
    def load_inventory(self, role_name: str, bag_index: int = None) -> List[ItemInfo]:
        """
        Carrega inventário do jogador do banco de dados.
        
        Args:
            role_name: Nome do personagem
            bag_index: Índice da bag (None = todas)
            
        Returns:
            Lista de ItemInfo
        """
        try:
            if bag_index is not None:
                query = """SELECT InventoryID, SlotIndex, ItemId, ItemCode, ItemCount, IsBound, EnhanceLevel,
                                  Durability, MaxDurability, RenewRuleIndex, ExtraData
                           FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=?"""
                results = self.db.execute_query(query, (role_name, bag_index))
            else:
                query = """SELECT InventoryID, SlotIndex, ItemId, ItemCode, ItemCount, IsBound, EnhanceLevel,
                                  Durability, MaxDurability, RenewRuleIndex, ExtraData
                           FROM TB_RoleInventory WHERE RoleName=?"""
                results = self.db.execute_query(query, (role_name,))
        except Exception as e:
            return []
        
        if not results:
            return []
        
        items = []
        for row in results:
            if 'SlotIndex' in row:
                items.append(ItemInfo(
                    inventory_id=row.get('InventoryID', 0),
                    slot_index=row['SlotIndex'],
                    item_id=row['ItemId'],
                    item_code=row['ItemCode'],
                    item_count=row['ItemCount'],
                    is_bound=bool(row.get('IsBound', False)),
                    enhance_level=row.get('EnhanceLevel', 0),
                    durability=int(row.get('Durability') if row.get('Durability') is not None else 100),
                    max_durability=int(row.get('MaxDurability') if row.get('MaxDurability') is not None else 100),
                    renew_rule_index=int(row.get('RenewRuleIndex') if row.get('RenewRuleIndex') is not None else 0),
                    extra_data=row.get('ExtraData')
                ))
        
        return items
    
    def add_item(self, role_name: str, item_code: str, count: int = 1, bag_index: int = 1) -> Dict[str, Any]:
        """
        Adiciona item ao inventário.
        
        Args:
            role_name: Nome do personagem
            item_code: Código do item
            count: Quantidade
            bag_index: Índice da bag
            
        Returns:
            Dict com Success, ErrorMsg, SlotIndex, ItemId
        """
        result = self.db.execute_proc('SP_AddItemToInventory', {
            'RoleName': role_name,
            'ItemCode': item_code,
            'ItemCount': count,
            'BagIndex': bag_index
        })
        
        if result and len(result) > 0:
            return {
                'success': bool(result[0].get('Success', False)),
                'error': result[0].get('ErrorMsg', ''),
                'slot_index': result[0].get('SlotIndex'),
                'item_id': result[0].get('ItemId')
            }
        
        return {'success': False, 'error': 'Erro desconhecido'}
    
    def move_item(self, role_name: str, bag_index: int, from_slot: int, to_slot: int) -> Dict[str, Any]:
        """
        Move item de um slot para outro.
        
        Args:
            role_name: Nome do personagem
            bag_index: Índice da bag
            from_slot: Slot de origem
            to_slot: Slot de destino
            
        Returns:
            Dict com Success, ErrorMsg
        """
        result = self.db.execute_proc('SP_MoveInventoryItem', {
            'RoleName': role_name,
            'BagIndex': bag_index,
            'FromSlot': from_slot,
            'ToSlot': to_slot
        })
        
        if result and len(result) > 0:
            return {
                'success': bool(result[0].get('Success', False)),
                'error': result[0].get('ErrorMsg', '')
            }
        
        return {'success': False, 'error': 'Erro desconhecido'}
    
    def use_item(self, role_name: str, bag_index: int, slot_index: int, use_count: int = 1) -> Dict[str, Any]:
        """
        Usa um item do inventário.
        
        Args:
            role_name: Nome do personagem
            bag_index: Índice da bag
            slot_index: Slot do item
            use_count: Quantidade a usar
            
        Returns:
            Dict com Success, ErrorMsg, ItemCode, EffectScript, RemainingCount
        """
        result = self.db.execute_proc('SP_UseItem', {
            'RoleName': role_name,
            'BagIndex': bag_index,
            'SlotIndex': slot_index,
            'UseCount': use_count
        })
        
        if result and len(result) > 0:
            return {
                'success': bool(result[0].get('Success', False)),
                'error': result[0].get('ErrorMsg', ''),
                'item_code': result[0].get('ItemCode'),
                'effect_script': result[0].get('EffectScript'),
                'remaining_count': result[0].get('RemainingCount', 0)
            }
        
        return {'success': False, 'error': 'Erro desconhecido'}
    
    def remove_item(self, role_name: str, bag_index: int, slot_index: int, count: int = None) -> Dict[str, Any]:
        """
        Remove item do inventário.
        
        Args:
            role_name: Nome do personagem
            bag_index: Índice da bag
            slot_index: Slot do item
            count: Quantidade a remover (None = tudo)
            
        Returns:
            Dict com Success, ErrorMsg, RemainingCount
        """
        params = {
            'RoleName': role_name,
            'BagIndex': bag_index,
            'SlotIndex': slot_index
        }
        if count is not None:
            params['RemoveCount'] = count
        
        result = self.db.execute_proc('SP_RemoveItem', params)
        
        if result and len(result) > 0:
            return {
                'success': bool(result[0].get('Success', False)),
                'error': result[0].get('ErrorMsg', ''),
                'remaining_count': result[0].get('RemainingCount', 0)
            }
        
        return {'success': False, 'error': 'Erro desconhecido'}
    
    def get_item_at_slot(self, role_name: str, bag_index: int, slot_index: int) -> Optional[ItemInfo]:
        """
        Retorna item em um slot específico.
        """
        items = self.load_inventory(role_name, bag_index)
        for item in items:
            if item.slot_index == slot_index:
                return item
        return None
    
    def get_item_definition(self, item_code: str) -> Optional[Dict[str, Any]]:
        """
        Busca definição de item pelo código.
        
        Args:
            item_code: Código único do item (ex: 'n006', 'bq200d')
            
        Returns:
            Dict com informações do item ou None se não encontrado
        """
        try:
            result = self.db.execute_query(
                "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                (item_code,)
            )
            
            if result and len(result) > 0:
                definition = result[0]
                from item_config_loader import item_config
                resource_definition = item_config.get_item(item_code)
                if resource_definition:
                    definition = {**resource_definition, **definition}
                    definition.setdefault('ItemType', resource_definition.get('type'))
                    definition.setdefault('ItemSubType', resource_definition.get('subtype'))
                    definition.setdefault('BuyPrice', resource_definition.get('goldPrice', 0))
                    definition.setdefault('SellPrice', resource_definition.get('recycleGoldPrice', 0))
                return definition
            
            from item_config_loader import item_config
            resource_definition = item_config.get_item(item_code)
            if not resource_definition:
                return None
            return {
                **resource_definition,
                'ItemCode': item_code,
                'ItemType': resource_definition.get('type'),
                'ItemSubType': resource_definition.get('subtype'),
                'BuyPrice': resource_definition.get('goldPrice', 0),
                'SellPrice': resource_definition.get('recycleGoldPrice', 0),
            }
        except Exception as e:
            print(f"[InventoryManager] Erro ao buscar item {item_code}: {e}")
            return None
    
    def get_item_price(self, item_code: str) -> tuple:
        """
        Retorna preços do item (compra, venda).
        
        Returns:
            (buy_price, sell_price) ou (0, 0) se não encontrado
        """
        item_def = self.get_item_definition(item_code)
        if item_def:
            return (item_def.get('BuyPrice', 0) or 0, item_def.get('SellPrice', 0) or 0)
        return (0, 0)
    
    def equip_item(self, role_name: str, from_bag: int, from_slot: int, 
                   to_bag: int, to_slot: int) -> Dict[str, Any]:
        """
        Move item de inventário para slot de equipamento (ou vice-versa).
        Trata troca se já houver item no destino.
        
        Args:
            role_name: Nome do personagem
            from_bag: Bag de origem (1 = inventário, 10+ = equipamento)
            from_slot: Slot de origem
            to_bag: Bag de destino
            to_slot: Slot de destino
            
        Returns:
            Dict com success, error, swapped_item (se houve troca)
        """
        result = self.db.execute_proc('SP_EquipItem', {
            'RoleName': role_name,
            'FromBag': from_bag,
            'FromSlot': from_slot,
            'ToBag': to_bag,
            'ToSlot': to_slot
        })
        
        if result and len(result) > 0:
            return {
                'success': bool(result[0].get('Success', False)),
                'error': result[0].get('ErrorMsg'),
                'swapped_item': result[0].get('SwappedItemCode')
            }
        
        return {'success': False, 'error': 'Erro desconhecido'}
    
    def find_empty_slot(self, role_name: str, bag_index: int, capacity: int = 42) -> Optional[int]:
        """
        Encontra o primeiro slot vazio em uma bag.
        
        Args:
            role_name: Nome do personagem
            bag_index: Índice da bag
            capacity: Capacidade máxima da bag
            
        Returns:
            Índice do slot vazio ou None se bag está cheia
        """
        items = self.load_inventory(role_name, bag_index)
        occupied_slots = {item.slot_index for item in items}
        
        for slot in range(capacity):
            if slot not in occupied_slots:
                return slot
        
        return None
