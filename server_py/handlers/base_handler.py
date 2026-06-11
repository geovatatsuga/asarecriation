from typing import TYPE_CHECKING, Dict, Callable, Optional
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder

if TYPE_CHECKING:
    from servers.world_server import WorldClientSession, WorldServer


class BaseHandler:
    
    def __init__(self, session: 'WorldClientSession'):
        self.session = session
        self.server = session.server
    
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {}
    
    def log(self, message: str):
        self.session.log(message)
    
    def send_packet(self, data: bytes):
        self.session.send_packet(data)
    
    def get_db(self):
        return self.server._get_db()
    
    @property
    def player_data(self) -> Optional[dict]:
        return self.session.player_data
    
    @player_data.setter
    def player_data(self, value: dict):
        self.session.player_data = value
    
    @property
    def role_name(self) -> str:
        return self.player_data.get('name', '') if self.player_data else ''
    
    @property
    def account_id(self) -> str:
        return self.session.account_id
    
    def build_packet(self, command_code: int) -> PacketBuilder:
        builder = PacketBuilder()
        builder._command_code = command_code
        return builder
    
    def send_simple_response(self, command_code: int, success: bool, message: str = ""):
        builder = PacketBuilder()
        builder.write_bool(success)
        builder.write_string(message)
        self.send_packet(builder.build(command_code))
