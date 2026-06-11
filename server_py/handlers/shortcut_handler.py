from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from typing import Dict

class ShortcutHandler(BaseHandler):
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {}
