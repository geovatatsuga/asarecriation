from typing import Dict
from .base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import PlayerCommandCode
from gameplay.combat_rules import STATUS_CANNOT_MOVE, effective_attribute, has_status

def write_map_point(builder: PacketBuilder, x: int, y: int):
    """Escreve um MapPoint (TransportableObject) no builder"""
    builder.write_unsigned_short(4)
    builder.write_short(x)
    builder.write_short(y)

class MovementHandler(BaseHandler):
    
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            PlayerCommandCode.PLAYER_MOVE_REQ: 'handle_player_move',
            PlayerCommandCode.PLAYER_ENTER_MAP_REQ: 'handle_enter_map',
        }
    
    def handle_player_move(self, reader: PacketReader):
        """
        Movimento do jogador (cmd 519)
        Request: mapId:string, pathArrayReversed:array(MapPoint)
        """
        try:
            map_id = reader.read_string()
            path_count = reader.read_varint()
            
            path_points = []
            for _ in range(path_count):
                obj_len = reader.read_unsigned_short()
                if obj_len == 0:
                    continue
                x = reader.read_short()
                y = reader.read_short()
                path_points.append((x, y))
            
            path_points.reverse()
            
            self.log(f"PlayerMove: map={map_id}, path={path_points}")
            
            if not path_points:
                return
            if self.player_data and has_status(self.player_data, STATUS_CANNOT_MOVE):
                self._send_position_check(
                    self.player_data.get('mapId', map_id),
                    int(self.player_data.get('posX', 0)),
                    int(self.player_data.get('posY', 0)),
                )
                return
            
            dest_x, dest_y = path_points[-1]
            
            if self.player_data:
                self.player_data['posX'] = dest_x
                self.player_data['posY'] = dest_y
            
            self._send_position_check(map_id, dest_x, dest_y, path_points)
            self._broadcast_remote_position(map_id, dest_x, dest_y, path_points)
            
        except Exception as e:
            self.log(f"Erro no movimento: {e}")
            import traceback
            traceback.print_exc()
    
    def _send_position_check(self, map_id: str, x: int, y: int, path: list = None):
        """
        Envia PlayerPositionCheckNotify (cmd 520)
        """
        builder = PacketBuilder()
        
        builder.write_string(map_id)
        
        write_map_point(builder, x, y)
        
        walk_speed = effective_attribute(self.player_data, 'walkSpeed', 200) if self.player_data else 200
        builder.write_short(int(walk_speed))
        
        if path:
            reversed_path = list(reversed(path))
            builder.write_varint(len(reversed_path))
            for px, py in reversed_path:
                write_map_point(builder, px, py)
        else:
            builder.write_varint(0)
        
        builder.write_byte(0)
        
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_POSITION_CHECK_NOTIFY))
        self.log(f"✅ PositionCheck enviado: ({x}, {y})")
    
    def _broadcast_remote_position(self, map_id: str, x: int, y: int, path: list):
        builder = PacketBuilder()
        builder.write_string(self.role_name)
        builder.write_string(map_id)
        write_map_point(builder, x, y)
        builder.write_short(int(self.player_data.get('walkSpeed', 200)))
        reversed_path = list(reversed(path or []))
        builder.write_varint(len(reversed_path))
        for px, py in reversed_path:
            write_map_point(builder, px, py)
        builder.write_byte(0)
        self.server.broadcast_to_map(map_id, builder.build(772), exclude_session=self.session)

    def handle_enter_map(self, reader: PacketReader):
        """
        Jogador solicitou entrar em outro mapa via saída (cmd 517)
        """
        try:
            from_map_id = reader.read_string()
            from_exit_id = reader.read_string()
            
            self.log(f"🚪 EnterMapRequest: fromMap={from_map_id}, exitId={from_exit_id}")
            
            from servers.world_server import MAP_EXITS, MAP_ENTRIES
            exit_config = MAP_EXITS.get(from_map_id, {}).get(from_exit_id)
            
            if not exit_config:
                self.log(f"❌ Saída não encontrada: {from_map_id}/{from_exit_id}")
                self._send_enter_map_failure(f"Exit '{from_exit_id}' not found")
                return
            
            to_map_id = exit_config.get('toMap')
            to_entry_id = exit_config.get('toEntry', 'default')
            
            entry_config = MAP_ENTRIES.get(to_map_id, {}).get(to_entry_id)
            if not entry_config:
                entry_config = MAP_ENTRIES.get(to_map_id, {}).get('default', {"x": 1024, "y": 2048})
            
            spawn_x = entry_config.get('x', 1024)
            spawn_y = entry_config.get('y', 2048)
            
            self.log(f"📍 Destino: map={to_map_id}, pos=({spawn_x}, {spawn_y})")
            
            old_map_id = self.player_data.get('mapId') if self.player_data else from_map_id
            self.server.announce_player_left_map(self.session, old_map_id)
            if self.player_data:
                self.player_data['mapId'] = to_map_id
                self.player_data['posX'] = spawn_x
                self.player_data['posY'] = spawn_y
            
            self._send_enter_map_success(to_map_id, spawn_x, spawn_y)
            self.server.announce_player_entered_map(self.session)
            
        except Exception as e:
            self.log(f"❌ Erro ao processar enter map: {e}")
            import traceback
            traceback.print_exc()
            self._send_enter_map_failure("Internal server error")
    
    def _send_enter_map_success(self, map_id: str, x: int, y: int, line_index: int = 0):
        """Envia PlayerEnterMapAnswer (cmd 518) com sucesso"""
        builder = PacketBuilder()
        builder.write_string(map_id)
        write_map_point(builder, x, y)
        builder.write_string("")
        builder.write_byte(line_index)
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_ENTER_MAP_ANSWER))
        self.log(f"✅ EnterMapAnswer: map={map_id}, pos=({x}, {y})")
    
    def _send_enter_map_failure(self, reason: str):
        """Envia PlayerEnterMapAnswer (cmd 518) com falha"""
        builder = PacketBuilder()
        builder.write_string("")
        builder.write_unsigned_short(0)
        builder.write_string(reason)
        builder.write_byte(0)
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_ENTER_MAP_ANSWER))
        self.log(f"❌ EnterMapAnswer (falha): {reason}")
