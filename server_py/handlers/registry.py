from typing import Dict, Type, Callable, TYPE_CHECKING
from protocol.packet_reader import PacketReader

if TYPE_CHECKING:
    from servers.world_server import WorldSession
    from handlers.base_handler import BaseHandler


class HandlerRegistry:
    
    def __init__(self):
        self._handlers: Dict[int, tuple] = {}
        self._instances: Dict[int, dict] = {}
    
    def register_handler(self, handler_class: Type['BaseHandler']):
        handlers = handler_class.get_handlers()
        for cmd_id, method_name in handlers.items():
            if cmd_id in self._handlers:
                existing = self._handlers[cmd_id]
                print(f"[WARN] Comando {cmd_id} já registrado em {existing[0].__name__}, sobrescrevendo com {handler_class.__name__}")
            self._handlers[cmd_id] = (handler_class, method_name)
            print(f"[HandlerRegistry] Registrado: cmd {cmd_id} -> {handler_class.__name__}.{method_name}")
    
    def can_handle(self, command: int) -> bool:
        return command in self._handlers
    
    def dispatch(self, command: int, session: 'WorldSession', reader: PacketReader) -> bool:
        if command not in self._handlers:
            return False
        
        handler_class, method_name = self._handlers[command]
        handler = self._get_handler_instance(session, handler_class)
        method = getattr(handler, method_name)
        method(reader)
        
        return True
    
    def _get_handler_instance(self, session: 'WorldSession', handler_class: Type['BaseHandler']):
        session_id = id(session)
        
        if session_id not in self._instances:
            self._instances[session_id] = {}
        
        if handler_class not in self._instances[session_id]:
            self._instances[session_id][handler_class] = handler_class(session)
        
        return self._instances[session_id][handler_class]
    
    def cleanup_session(self, session: 'WorldSession'):
        session_id = id(session)
        if session_id in self._instances:
            del self._instances[session_id]
    
    def get_registered_commands(self) -> Dict[int, str]:
        return {
            cmd: f"{h[0].__name__}.{h[1]}"
            for cmd, h in self._handlers.items()
        }


_global_registry: HandlerRegistry = None


def get_handler_registry() -> HandlerRegistry:
    global _global_registry
    if _global_registry is None:
        _global_registry = HandlerRegistry()
        _register_all_handlers(_global_registry)
    return _global_registry


def _register_all_handlers(registry: HandlerRegistry):
    from handlers.shop_handler import ShopHandler
    from handlers.inventory_handler import InventoryHandler
    from handlers.movement_handler import MovementHandler
    from handlers.role_handler import RoleHandler
    from handlers.world_handler import WorldHandler
    from handlers.task_handler import TaskHandler
    from handlers.player_handler import PlayerHandler
    from handlers.npc_handler import NpcHandler
    from handlers.combat_handler import CombatHandler
    from handlers.shortcut_handler import ShortcutHandler
    from handlers.skill_handler import SkillHandler
    from handlers.loot_manager import LootManager
    from handlers.chat_handler import ChatHandler
    from handlers.ride_handler import RideHandler
    from handlers.pet_handler import PetHandler
    from handlers.attribute_handler import AttributeHandler
    from handlers.mount_handler import MountHandler
    from handlers.team_handler import TeamHandler
    from handlers.advanced_item_handler import AdvancedItemHandler
    from handlers.wing_spirit_handler import WingSpiritHandler
    from handlers.farm_handler import FarmHandler

    registry.register_handler(ShopHandler)
    registry.register_handler(InventoryHandler)
    registry.register_handler(MovementHandler)
    registry.register_handler(RoleHandler)
    registry.register_handler(WorldHandler)
    registry.register_handler(TaskHandler)
    registry.register_handler(PlayerHandler)
    registry.register_handler(NpcHandler)
    registry.register_handler(CombatHandler)
    registry.register_handler(ShortcutHandler)
    registry.register_handler(SkillHandler)
    registry.register_handler(LootManager)
    registry.register_handler(ChatHandler)
    registry.register_handler(RideHandler)
    registry.register_handler(PetHandler)
    registry.register_handler(AttributeHandler)
    registry.register_handler(MountHandler)
    registry.register_handler(TeamHandler)
    registry.register_handler(AdvancedItemHandler)
    registry.register_handler(WingSpiritHandler)
    registry.register_handler(FarmHandler)

    print(f"[HandlerRegistry] Total: {len(registry._handlers)} comandos registrados")
