from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import WingSpiritCommandCode
from servers.world_server import write_transportable_object


class WingSpiritHandler(BaseHandler):
    @classmethod
    def get_handlers(cls):
        return {
            WingSpiritCommandCode.PLAYER_WING_SPIRIT_REQUEST: 'handle_wing_spirit',
        }

    def handle_wing_spirit(self, reader: PacketReader):
        """Handle PLAYER_WING_SPIRIT_REQUEST (12544)
        
        AS Field order:
        - equipmentId: string
        - spiritType: ubyte (0=Oceano, 1=Terra, 2=Céu, 3=Deus)
        - doType: ubyte (0=push/activate, 1=upgrade, etc.)
        """
        try:
            equipment_id = reader.read_string()
            spirit_type = reader.read_unsigned_byte()
            do_type = reader.read_unsigned_byte()
            
            self.log(f"PLAYER_WING_SPIRIT_REQUEST: equipmentId={equipment_id}, spiritType={spirit_type}, doType={do_type}")
            
            if not self.player_data:
                self.log("❌ Player data not loaded")
                self._send_wing_spirit_answer(do_type, False, {})
                return
            
            # TODO: Implement actual wing spirit logic
            # - Validate equipment exists and is equipped
            # - Check wing spirit rules from config (idc.json has wingSpiritName_0-3)
            # - Consume materials if needed
            # - Update equipment wingSpiritMap/wingSpiritSkills
            # - Persist to database
            
            # For now, return success with empty equipmentInfo (null transportable object)
            # PLAYER_WING_SPIRIT_ANSWER: [doType:ubyte, isSucceed:boolean, equipmentInfo:GameItemFullInfo]
            self._send_wing_spirit_answer(do_type, True, {})
            
        except Exception as e:
            self.log(f"Error handling wing spirit: {e}")
            import traceback
            traceback.print_exc()
            try:
                self._send_wing_spirit_answer(0, False, {})
            except Exception:
                pass

    def _send_wing_spirit_answer(self, do_type: int, is_succeed: bool, equipment_info: dict):
        """Send PLAYER_WING_SPIRIT_ANSWER (12545)
        
        AS Field order:
        - doType: ubyte
        - isSucceed: boolean
        - equipmentInfo: GameItemFullInfo (transportable object)
        """
        builder = PacketBuilder()
        builder.write_unsigned_byte(do_type)
        builder.write_bool(is_succeed)
        
        # Write equipmentInfo as transportable object (GameItemFullInfo)
        # If empty/null, write length=0
        if equipment_info:
            def write_equipment_info_raw(b: PacketBuilder):
                # GameItemFullInfo structure:
                # itemId, itemCode, expiredTimeLeftInHour, canTrade, equipmentInfo, ...
                b.write_string(equipment_info.get('itemId', ''))
                b.write_string(equipment_info.get('itemCode', ''))
                b.write_int(equipment_info.get('expiredTimeLeftInHour', 0))
                b.write_bool(equipment_info.get('canTrade', True))
                # equipmentInfo (ItemEquipmentInfo) - nested transportable
                # For now write empty (length=0)
                b.write_unsigned_short(0)
                # rideInfo, expendableInfo, petInfo, genieInfo, elementInfo, devilInfo - all empty
                for _ in range(6):
                    b.write_unsigned_short(0)
            
            write_transportable_object(builder, write_equipment_info_raw)
        else:
            # Null transportable object
            builder.write_unsigned_short(0)
        
        self.send_packet(builder.build(WingSpiritCommandCode.PLAYER_WING_SPIRIT_ANSWER))
        self.log(f"📤 PLAYER_WING_SPIRIT_ANSWER: doType={do_type}, success={is_succeed}")