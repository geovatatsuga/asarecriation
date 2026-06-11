from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from typing import Dict

class AttributeHandler(BaseHandler):
    PLAYER_ASSIGN_ATTR_REQUEST = 690

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_ASSIGN_ATTR_REQUEST: 'handle_assign_attr',
        }

    def handle_assign_attr(self, reader: PacketReader):
        try:
            str_add = reader.read_int()
            wis_add = reader.read_int()
            agi_add = reader.read_int()
            vit_add = reader.read_int()
            
            self.log(f"PLAYER_ASSIGN_ATTR_REQUEST: str=+{str_add}, wis=+{wis_add}, agi=+{agi_add}, vit=+{vit_add}")
            
            if not self.player_data:
                return
                
            total_allocated = str_add + wis_add + agi_add + vit_add
            free_pt = int(self.player_data.get('freeAttrPt', 0))
            
            if total_allocated <= 0:
                self.log(f"❌ Nao ha pontos para distribuir")
                return
                
            if total_allocated > free_pt:
                self.log(f"❌ Pontos insuficientes: necessita {total_allocated}, possui {free_pt}")
                return
                
            # Update attributes
            self.player_data['strength'] = int(self.player_data.get('strength', 10)) + str_add
            self.player_data['wisdom'] = int(self.player_data.get('wisdom', 10)) + wis_add
            self.player_data['agility'] = int(self.player_data.get('agility', 10)) + agi_add
            self.player_data['vitality'] = int(self.player_data.get('vitality', 10)) + vit_add
            self.player_data['freeAttrPt'] = free_pt - total_allocated
            
            # Persist in DB
            db = self.get_db()
            if db:
                db.execute_non_query(
                    """
                    UPDATE TB_Role SET AttrForce=?, AttrSpirit=?, AttrAgility=?, AttrVitality=?, AttrRemainPoints=?
                    WHERE Name=?
                    """,
                    (
                        self.player_data['strength'],
                        self.player_data['wisdom'],
                        self.player_data['agility'],
                        self.player_data['vitality'],
                        self.player_data['freeAttrPt'],
                        self.role_name
                    )
                )
                
            # Notify points change
            self.session._send_ext_attr_int_change(7, -total_allocated, self.player_data['freeAttrPt'])
            
            # Recalculate attributes and notify client
            self.session._send_player_attributes()
            self.log(f"Attributes assigned successfully! Remaining free points: {self.player_data['freeAttrPt']}")
            
        except Exception as e:
            self.log(f"Error distributing attributes: {e}")
