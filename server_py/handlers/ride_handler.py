from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from servers.world_server import write_transportable_object
from typing import Dict

class RideHandler(BaseHandler):
    PLAYER_RIDE_REQUEST = 593
    PLAYER_RIDE_STATE_CHECK_NOTIFY = 594
    PLAYER_SET_USING_RIDE_REQUEST = 602
    PLAYER_USING_RIDE_CHECK_NOTIFY = 603

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_RIDE_REQUEST: 'handle_ride_request',
            cls.PLAYER_SET_USING_RIDE_REQUEST: 'handle_set_using_ride',
        }

    def handle_ride_request(self, reader: PacketReader):
        try:
            is_riding = reader.read_bool()
            self.log(f"PLAYER_RIDE_REQUEST: is_riding={is_riding}")
            
            if not self.player_data:
                return
                
            self.player_data['isRiding'] = is_riding
            
            ride_code = self.player_data.get('rideCode', 'r01') if is_riding else ''
            master_id = self.role_name if is_riding else ''
            
            # Update walkSpeed
            base_speed = 200
            if is_riding:
                self.player_data['walkSpeed'] = base_speed + 150
            else:
                self.player_data['walkSpeed'] = base_speed
                
            # Persist speed/ride state in DB
            db = self.get_db()
            if db:
                db.execute_non_query(
                    "UPDATE TB_Role SET WalkSpeed=?, RideCode=? WHERE Name=?",
                    (self.player_data['walkSpeed'], ride_code, self.role_name)
                )
            
            # Broadcast PLAYER_RIDE_STATE_CHECK_NOTIFY = 594
            # rideCode:string, rideMasterPlayerId:string, rideGuestPlayerIds:array(string)
            notify = PacketBuilder()
            notify.write_string(ride_code)
            notify.write_string(master_id)
            notify.write_varint(0) # no guests
            
            packet_data = notify.build(self.PLAYER_RIDE_STATE_CHECK_NOTIFY)
            
            # Broadcast to same map
            map_id = self.player_data.get('mapId', 'a1')
            for sess in self.server.sessions.values():
                if sess.player_data and sess.player_data.get('mapId') == map_id:
                    sess.send_packet(packet_data)
                    
            # Refresh player attributes
            self.session._send_player_attributes()
            self.log(f"Ride state updated for {self.role_name}: is_riding={is_riding}, speed={self.player_data['walkSpeed']}")
            
        except Exception as e:
            self.log(f"Error handling ride request: {e}")

    def handle_set_using_ride(self, reader: PacketReader):
        try:
            ride_id = reader.read_string()
            self.log(f"PLAYER_SET_USING_RIDE_REQUEST: ride_id={ride_id}")
            
            if not self.player_data:
                return
                
            self.player_data['rideCode'] = ride_id
            
            db = self.get_db()
            if db:
                db.execute_non_query(
                    "UPDATE TB_Role SET RideCode=? WHERE Name=?",
                    (ride_id, self.role_name)
                )
                
            # Send PLAYER_USING_RIDE_CHECK_NOTIFY = 603
            # usingRide: RideBriefInfo
            builder = PacketBuilder()
            
            def write_ride_brief(b):
                b.write_string(ride_id) # rideId
                b.write_string(ride_id) # rideCode
                
            write_transportable_object(builder, write_ride_brief)
            self.send_packet(builder.build(self.PLAYER_USING_RIDE_CHECK_NOTIFY))
            self.log(f"Active ride set to {ride_id}")
            
        except Exception as e:
            self.log(f"Error setting active ride: {e}")
