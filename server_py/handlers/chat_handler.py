import time
from typing import Dict
from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder


# Canais de chat conforme AS (PlayerSendMsgRequest.as / PlayerReceiveMsgNotify.as)
# request: scope:byte, content:string, toRoleName:string
# notify:  fromName:string, fromUserType:ubyte, fromTime:string, scope:byte, content:string
CHAT_CHANNEL_LOCAL = 0    # Mapa local (todos no mesmo map_id)
CHAT_CHANNEL_WORLD = 1    # Grito/mundo (TODOS os jogadores online)
CHAT_CHANNEL_WHISPER = 5  # Sussurro (apenas alvo)
CHAT_CHANNEL_SYSTEM = 6   # Sistema (apenas o próprio jogador)


class ChatHandler(BaseHandler):
    PLAYER_SEND_MSG_REQUEST = 673
    PLAYER_RECEIVE_MSG_NOTIFY = 674

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_SEND_MSG_REQUEST: 'handle_send_msg',
        }

    def _build_receive_notify(self, from_name: str, from_user_type: int, scope: int, content: str) -> bytes:
        """
        Constrói PlayerReceiveMsgNotify (cmd 674) conforme o AS:
        [fromName:string, fromUserType:ubyte, fromTime:string, scope:byte, content:string]
        """
        current_time = time.strftime('%H:%M:%S')
        builder = PacketBuilder()
        builder.write_string(from_name)
        builder.write_unsigned_byte(from_user_type)   # fromUserType:ubyte (0=normal, 1=GM, etc.)
        builder.write_string(current_time)             # fromTime:string
        builder.write_byte(scope)                      # scope:byte (canal)
        builder.write_string(content)                  # content:string
        return builder.build(self.PLAYER_RECEIVE_MSG_NOTIFY)

    def handle_send_msg(self, reader: PacketReader):
        """
        Processa PlayerSendMsgRequest (cmd 673):
        [scope:byte, content:string, toRoleName:string]
        """
        try:
            scope = reader.read_byte()        # scope:byte
            content = reader.read_string()    # content:string
            to_name = reader.read_string()    # toRoleName:string

            self.log(f"Chat: scope={scope}, to='{to_name}', content='{content}'")

            if not self.player_data:
                return

            from_name = self.role_name
            # fromUserType: 0=normal, 1=GM
            from_user_type = 1 if self.player_data.get('isGM', False) else 0

            packet_data = self._build_receive_notify(from_name, from_user_type, scope, content)

            if scope == CHAT_CHANNEL_WHISPER:
                # Sussurro: envia ao remetente + ao alvo se online
                self.send_packet(packet_data)
                target_session = self.server.sessions.get(to_name)
                if target_session:
                    target_session.send_packet(packet_data)
                else:
                    # Alvo offline — envia mensagem de sistema ao remetente
                    sys_packet = self._build_receive_notify(
                        "Sistema", 0, CHAT_CHANNEL_SYSTEM,
                        f"O jogador '{to_name}' está offline."
                    )
                    self.send_packet(sys_packet)

            elif scope == CHAT_CHANNEL_SYSTEM:
                # Sistema: apenas para o próprio jogador
                self.send_packet(packet_data)

            elif scope == CHAT_CHANNEL_WORLD:
                # Grito/mundo: envia a TODOS os jogadores online
                for sess in list(self.server.sessions.values()):
                    if sess.player_data:
                        sess.send_packet(packet_data)

            else:
                # Canal local (0) e demais canais: apenas jogadores no mesmo mapa
                map_id = self.player_data.get('mapId', '')
                for sess in list(self.server.sessions.values()):
                    if sess.player_data and sess.player_data.get('mapId') == map_id:
                        sess.send_packet(packet_data)

        except Exception as e:
            self.log(f"Erro ao processar mensagem de chat: {e}")
            import traceback
            traceback.print_exc()
