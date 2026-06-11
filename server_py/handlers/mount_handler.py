from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import PlayerCommandCode
from typing import Dict

class MountHandler(BaseHandler):
    PLAYER_INVITE_RIDE_REQUEST = 598
    PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY = 599
    PLAYER_PROCESS_INVITE_RIDE_REQUEST_REPLY = 600
    PLAYER_RIDE_STATE_CHECK_NOTIFY = 594
    PLAYER_ADD_RIDE_EXP_REQUEST = 605

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_INVITE_RIDE_REQUEST: 'handle_invite_ride',
            cls.PLAYER_PROCESS_INVITE_RIDE_REQUEST_REPLY: 'handle_invite_reply',
            cls.PLAYER_ADD_RIDE_EXP_REQUEST: 'handle_add_ride_exp',
        }

    def handle_invite_ride(self, reader: PacketReader):
        try:
            target_name = reader.read_string()
            self.log(f"PLAYER_INVITE_RIDE_REQUEST: from={self.role_name} to={target_name}")
            
            # Find target session
            target_session = self.server.sessions.get(target_name)
            if not target_session:
                self.log(f"Target player '{target_name}' not online")
                return
                
            # Send PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY (cmd 599) to target
            notify = PacketBuilder()
            notify.write_string(self.role_name)
            target_session.send_packet(notify.build(self.PLAYER_RECEIVE_INVITE_RIDE_REQUEST_NOTIFY))
            self.log(f"Invite ride notify sent to {target_name}")
            
        except Exception as e:
            self.log(f"Error in invite ride: {e}")

    def handle_invite_reply(self, reader: PacketReader):
        try:
            inviter_name = reader.read_string()
            reply = reader.read_bool()
            self.log(f"PLAYER_PROCESS_INVITE_RIDE_REQUEST_REPLY: by={self.role_name} to={inviter_name} reply={reply}")
            
            if not reply:
                return
                
            inviter_session = self.server.sessions.get(inviter_name)
            if not inviter_session or not inviter_session.player_data or not self.player_data:
                return
                
            # Link guest to host mount
            inviter_session.player_data['rideGuestPlayerIds'] = [self.role_name]
            self.player_data['rideMasterPlayerId'] = inviter_name
            self.player_data['rideCode'] = inviter_session.player_data.get('rideCode', '')
            
            # Broadcast state check update (cmd 594) for both players to the map
            for session in [inviter_session, self.session]:
                state_notify = PacketBuilder()
                state_notify.write_string(session.role_name)
                state_notify.write_bool(True) # isRiding
                # Send to all players on the map
                self.server.broadcast_to_map(session.player_data.get('mapId', 'a1'), state_notify.build(self.PLAYER_RIDE_STATE_CHECK_NOTIFY))
                
            self.log(f"Double ride established: {self.role_name} joined {inviter_name}'s mount")
            
        except Exception as e:
            self.log(f"Error in invite ride reply: {e}")

    def handle_add_ride_exp(self, reader: PacketReader):
        try:
            bag_index = reader.read_byte()
            slot_index = reader.read_short()
            item_count = reader.read_int()
            self.log(f"PLAYER_ADD_RIDE_EXP_REQUEST: bag={bag_index}, slot={slot_index}, count={item_count}")
            
            if not self.player_data:
                return
                
            # Deduct the item from inventory, and add EXP to mount (simple progression mock)
            # Add exp notify and speed adjustment
            current_speed = int(self.player_data.get('walkSpeed', 200))
            new_speed = current_speed + 10
            self.player_data['walkSpeed'] = new_speed
            
            # Notify speed update
            self.session._send_player_attributes()
            self.log(f"Mount fed. WalkSpeed increased to {new_speed}")
            
        except Exception as e:
            self.log(f"Error adding ride exp: {e}")
