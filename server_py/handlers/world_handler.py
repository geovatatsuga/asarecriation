from typing import Dict
import time
from .base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import WorldCommandCode


class WorldHandler(BaseHandler):

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            WorldCommandCode.WORLD_LOGIN_REQ: 'handle_world_login',
            WorldCommandCode.WORLD_LOGOUT_REQ: 'handle_world_logout',
            WorldCommandCode.WORLD_PING_ECHO: 'handle_ping',
            WorldCommandCode.WORLD_CLIENT_SAVE_CONFIG_NOTIFY: 'handle_client_save_config',
            12081: 'handle_robot_action',
            WorldCommandCode.PVE_MAPS_REQ: 'handle_pve_maps',
        }
    
    def handle_bag_capacity_request(self, reader: PacketReader):
        try:
            raw_data = reader.data[reader.pos:] if hasattr(reader, 'data') else b''
            bag_index = reader.read_byte() if reader.remaining() >= 1 else 1
            self.log(f"BagCapacityRequest: bag={bag_index} (raw: {raw_data.hex()})")
            
            capacity = 36
            if bag_index == 2:
                capacity = 3
            elif bag_index == 3:
                capacity = 3
            
            builder = PacketBuilder()
            builder.write_byte(bag_index)
            builder.write_short(capacity)
            self.send_packet(builder.build(5896))
        except Exception as e:
            self.log(f"Erro no BagCapacityRequest: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_world_login(self, reader: PacketReader):
        try:
            ticket = reader.read_string()
            server_id = reader.read_short()
            
            self.log(f"WorldLogin: ticket={ticket[:20]}..., server={server_id}")
            
            account_data = self.server.get_account_by_ticket(ticket)
            
            if account_data:
                self.session.account_id = str(account_data.get('AccountUID', ticket))
                self.session.session_id = ticket
            else:
                self.session.account_id = ticket
                self.session.session_id = ticket
            
            builder = PacketBuilder()
            builder.write_bool(True)
            builder.write_string("")
            
            self.send_packet(builder.build(WorldCommandCode.WORLD_LOGIN_ANSWER))
            self.log(f"✅ WorldLogin OK - account_id={self.session.account_id}")
            
        except Exception as e:
            self.log(f"Erro no world login: {e}")
            import traceback
            traceback.print_exc()

    def handle_world_logout(self, reader: PacketReader):
        """World logout request (cmd 35 - WORLD_LOGOUT_REQ)"""
        try:
            self.log("WorldLogout request received")
            
            # Save player data before logout
            if self.player_data and self.role_name:
                try:
                    self.get_db().save_player_data(self.role_name, self.player_data)
                    self.log(f"Player data saved for {self.role_name}")
                except Exception as e:
                    self.log(f"Erro ao salvar dados do jogador: {e}")
            
            # Send logout answer
            builder = PacketBuilder()
            builder.write_bool(True)
            self.send_packet(builder.build(WorldCommandCode.WORLD_LOGOUT_ANSWER))
            
            # Mark session for cleanup
            if hasattr(self.session, 'mark_for_cleanup'):
                self.session.mark_for_cleanup()
            
            self.log("✅ WorldLogout processed")
            
        except Exception as e:
            self.log(f"Erro no world logout: {e}")
            import traceback
            traceback.print_exc()

    def handle_ping(self, reader: PacketReader):
        timestamp = reader.read_int() if reader.remaining() >= 4 else int(time.time() * 1000)
        
        builder = PacketBuilder()
        builder.write_int(timestamp)
        self.send_packet(builder.build(WorldCommandCode.WORLD_PING_ECHO))
    
    def handle_client_save_config(self, reader: PacketReader):
        try:
            config_json = reader.read_string()
            self.log(f"ClientSaveConfig: {len(config_json)} bytes de config")
        except Exception as e:
            self.log(f"Erro ao processar client config: {e}")
    
    def handle_robot_action(self, reader: PacketReader):
        try:
            action = reader.read_byte()
            self.log(f"RobotAction: action={action}")
        except Exception as e:
            self.log(f"Erro ao processar robot action: {e}")
    
    def handle_pve_maps(self, reader: PacketReader):
        builder = PacketBuilder()
        builder.write_varint(0)
        self.send_packet(builder.build(WorldCommandCode.PVE_MAPS_ANSWER))
