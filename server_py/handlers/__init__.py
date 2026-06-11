"""
Asa de Cristal - Packet Handlers
Handlers modulares para processamento de pacotes do World Server

Arquitetura:
- BaseHandler: Classe base com acesso a session e server
- Handlers específicos por domínio (auth, inventory, shop, movement, etc)
- Cada handler registra seus comandos automaticamente
- HandlerRegistry: Sistema de dispatch centralizado
"""

from .base_handler import BaseHandler
from .registry import HandlerRegistry, get_handler_registry
from .world_handler import WorldHandler
from .inventory_handler import InventoryHandler
from .shop_handler import ShopHandler
from .movement_handler import MovementHandler
from .role_handler import RoleHandler

__all__ = [
    'BaseHandler',
    'HandlerRegistry',
    'get_handler_registry',
    'WorldHandler',
    'InventoryHandler',
    'ShopHandler',
    'MovementHandler',
    'RoleHandler',
]
