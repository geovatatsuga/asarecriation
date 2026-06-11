from typing import Dict

from .base_handler import BaseHandler
from protocol.commands import PlayerCommandCode
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder


FREE_ATTR_PT_CODE = 7


class PlayerHandler(BaseHandler):
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            PlayerCommandCode.PLAYER_ASSIGN_ATTR_REQUEST: "handle_assign_attr",
            PlayerCommandCode.PLAYER_REBIRTH_REQUEST: "handle_rebirth",
            PlayerCommandCode.PLAYER_SIT_REQUEST: "handle_sit",
        }

    def handle_assign_attr(self, reader: PacketReader):
        try:
            str_added = max(0, reader.read_int())
            wis_added = max(0, reader.read_int())
            agi_added = max(0, reader.read_int())
            vit_added = max(0, reader.read_int())
            total = str_added + wis_added + agi_added + vit_added
            if total <= 0 or not self.player_data:
                return

            free_points = int(self.player_data.get("freeAttrPt", 0))
            if total > free_points:
                self.log(f"AssignAttr recusado: pedido={total}, livre={free_points}")
                return

            updates = {
                "strength": ("AttrForce", str_added),
                "wisdom": ("AttrSpirit", wis_added),
                "agility": ("AttrAgility", agi_added),
                "vitality": ("AttrVitality", vit_added),
            }
            for key, (_, value) in updates.items():
                self.player_data[key] = int(self.player_data.get(key, 10)) + value
            self.player_data["freeAttrPt"] = free_points - total

            self.get_db().execute_non_query(
                """
                UPDATE TB_Role
                SET AttrForce=?, AttrSpirit=?, AttrAgility=?, AttrVitality=?, AttrRemainPoints=?
                WHERE Name=?
                """,
                (
                    self.player_data["strength"],
                    self.player_data["wisdom"],
                    self.player_data["agility"],
                    self.player_data["vitality"],
                    self.player_data["freeAttrPt"],
                    self.role_name,
                ),
            )
            self._send_ext_attr_int_change(FREE_ATTR_PT_CODE, -total, self.player_data["freeAttrPt"])
            self.session._send_player_attributes()
            self.log(
                "AssignAttr OK: "
                f"str+{str_added} wis+{wis_added} agi+{agi_added} vit+{vit_added}; "
                f"free={self.player_data['freeAttrPt']}"
            )
        except Exception as e:
            self.log(f"Erro ao distribuir atributos: {e}")
            import traceback
            traceback.print_exc()

    def _send_ext_attr_int_change(self, attr: int, changed: int, current: int):
        builder = PacketBuilder()
        builder.write_byte(attr)
        builder.write_int(changed)
        builder.write_int(current)
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY))

    def handle_rebirth(self, reader: PacketReader):
        try:
            rebirth_mode = reader.read_byte()
            self.log(f"PLAYER_REBIRTH_REQUEST: mode={rebirth_mode}")
            if not self.player_data:
                return
            if not self.player_data.get('isDead'):
                self.log("PLAYER_REBIRTH_REQUEST ignorado: jogador nao esta morto")
                return
            
            # Reset states
            self.player_data['isDead'] = False
            hp_max = float(self.player_data.get('hpMax', 100))
            mp_max = float(self.player_data.get('mpMax', 50))
            self.player_data['hp'] = hp_max
            self.player_data['mp'] = mp_max
            
            # Always revive at the current map's default portal. The client only
            # moves immediately on PlayerRebirthNotify when mapId is unchanged.
            from servers.world_server import MAP_ENTRIES
            map_id = self.player_data.get('mapId') or "a1"
            entries = MAP_ENTRIES.get(map_id, {})
            entry = entries.get('default')
            if not entry and entries:
                entry = next(iter(entries.values()))
            entry = entry or {"x": 1024, "y": 2048}
            pos_x = int(entry.get('x', 1024))
            pos_y = int(entry.get('y', 2048))
            
            self.player_data['mapId'] = map_id
            self.player_data['posX'] = pos_x
            self.player_data['posY'] = pos_y
            
            # Save to Database
            self.get_db().execute_non_query(
                "UPDATE TB_Role SET IsDead=0, HP=?, MP=?, MapId=?, PosX=?, PosY=? WHERE Name=?",
                (int(hp_max), int(mp_max), map_id, pos_x, pos_y, self.role_name)
            )
            
            # Send PlayerRebirthNotify (cmd 568)
            notify = PacketBuilder()
            notify.write_string(map_id)
            notify.write_short(pos_x)
            notify.write_short(pos_y)
            notify.write_int(0) # expLost
            notify.write_int(0) # moneyLost
            self.send_packet(notify.build(PlayerCommandCode.PLAYER_REBIRTH_NOTIFY))
            remote = PacketBuilder()
            remote.write_string(self.role_name)
            remote.write_string(map_id)
            remote.write_short(pos_x)
            remote.write_short(pos_y)
            self.server.broadcast_to_map(map_id, remote.build(809), exclude_session=self.session)
            self.server.set_combat_status(self.session, False)
            
            # Send PLAYER_HP_CHANGE_NOTIFY (cmd 550) to sync full HP
            hp_notify = PacketBuilder()
            hp_notify.write_double(float(hp_max)) # change (positive)
            hp_notify.write_double(float(hp_max)) # current
            hp_notify.write_string("basic")
            hp_notify.write_bool(False)
            hp_notify.write_bool(False)
            self.send_packet(hp_notify.build(550))
            
            # Send PLAYER_MP_CHANGE_NOTIFY (cmd 552) to sync full MP
            mp_notify = PacketBuilder()
            mp_notify.write_short(int(mp_max)) # change (positive)
            mp_notify.write_int(int(mp_max)) # current
            mp_notify.write_string("")
            self.send_packet(mp_notify.build(552))
            
            self.log(
                f"Rebirth successful for player {self.role_name} "
                f"at current-map portal {map_id} ({pos_x}, {pos_y}), requested_mode={rebirth_mode}"
            )
            
        except Exception as e:
            self.log(f"Erro ao processar rebirth: {e}")

    def handle_sit(self, reader: PacketReader):
        try:
            sit = reader.read_bool()
            self.log(f"PLAYER_SIT_REQUEST: sit={sit}")
            if not self.player_data:
                return
            
            self.player_data['isSitting'] = sit
            
            # Save to database
            self.get_db().execute_non_query(
                "UPDATE TB_Role SET IsSitting=? WHERE Name=?",
                (1 if sit else 0, self.role_name)
            )
            
            # Send PlayerSitCheckNotify (cmd 584)
            notify = PacketBuilder()
            notify.write_bool(sit)
            self.send_packet(notify.build(PlayerCommandCode.PLAYER_SIT_CHECK_NOTIFY))
            remote = PacketBuilder()
            remote.write_string(self.role_name)
            remote.write_bool(sit)
            self.server.broadcast_to_map(self.player_data.get('mapId'), remote.build(810), exclude_session=self.session)
            
            self.log(f"Sit status updated to {sit} for player {self.role_name}")
            
        except Exception as e:
            self.log(f"Erro ao processar sit request: {e}")
