from typing import Dict
from .base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import RoleCommandCode

class RoleHandler(BaseHandler):
    
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            RoleCommandCode.ROLE_LIST_REQ: 'handle_role_list',
            RoleCommandCode.ROLE_NAME_CONFIRM_REQ: 'handle_role_name_confirm',
            RoleCommandCode.CREATE_ROLE_REQ: 'handle_create_role',
            RoleCommandCode.DELETE_ROLE_REQ: 'handle_delete_role',
            RoleCommandCode.SELECT_ROLE_REQ: 'handle_select_role',
        }
    
    def handle_role_list(self, reader: PacketReader):
        """Lista de personagens (cmd 257)"""
        try:
            ss_key = reader.read_short() if reader.remaining() >= 2 else 0
            self.log(f"RoleListRequest (ssKey={ss_key})")
            
            roles = self.server.get_roles_for_account(self.session.account_id)
            self.log(f"Encontrados {len(roles)} personagens")
            
            builder = PacketBuilder()
            builder.write_varint(len(roles))
            
            for role in roles:
                role_builder = PacketBuilder()
                
                role_builder.write_string(role.get('name', ''))
                role_builder.write_byte(role.get('jobCode', 1))
                role_builder.write_byte(role.get('sex', 0))
                role_builder.write_short(role.get('level', 1))
                role_builder.write_unsigned_short(role.get('headIconIndex', 0))
                role_builder.write_byte(role.get('hairStyleIndex', 0))
                
                role_builder.write_string(str(role.get('accountId', '')))
                role_builder.write_string(str(role.get('createTime', '')))
                role_builder.write_string(str(role.get('lastPlayTime', '')))
                role_builder.write_bool(role.get('deletedFlag', False))
                role_builder.write_string(str(role.get('willDeleteTime', '')))
                
                equip = role.get('equipmentModels', {})
                role_builder.write_varint(len(equip))
                for slot, model in equip.items():
                    role_builder.write_byte(int(slot))
                    role_builder.write_string(str(model))
                
                role_builder.write_bool(role.get('hasRolePassword', False))
                
                role_data = role_builder.get_bytes()
                builder.write_short(len(role_data))
                builder.write_bytes(role_data)
            
            self.send_packet(builder.build(RoleCommandCode.ROLE_LIST_ANSWER))
            
        except Exception as e:
            self.log(f"Erro ao listar roles: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_role_name_confirm(self, reader: PacketReader):
        """Verificar nome disponível (cmd 259)"""
        try:
            name = reader.read_string()
            self.log(f"RoleNameConfirm: name={name}")
            
            available = self.server.check_role_name(name)
            
            builder = PacketBuilder()
            builder.write_bool(available)
            builder.write_string("" if available else "Nome já está em uso")
            
            self.send_packet(builder.build(RoleCommandCode.ROLE_NAME_CONFIRM_ANSWER))
            
        except Exception as e:
            self.log(f"Erro ao confirmar nome: {e}")
    
    def handle_create_role(self, reader: PacketReader):
        """Criar personagem (cmd 261)"""
        try:
            land_code = reader.read_string()
            role_size = reader.read_short()
            
            name = reader.read_string()
            job_code = reader.read_byte()
            sex = reader.read_byte()
            level = reader.read_short()
            head_icon = reader.read_unsigned_short()
            hair_style = reader.read_byte()
            
            self.log(f"CreateRole: name={name}, job={job_code}, sex={sex}")
            
            role_data = {
                'name': name,
                'jobCode': job_code,
                'sex': sex,
                'level': 1,
                'headIconIndex': head_icon,
                'hairStyleIndex': hair_style,
            }
            
            new_role = self.server.create_role(self.session.account_id, role_data)
            
            builder = PacketBuilder()
            
            if 'error' in new_role:
                builder.write_short(0)
                builder.write_string(new_role['error'])
                self.log(f"❌ Erro ao criar: {new_role['error']}")
            else:
                self.log(f"✅ Personagem criado: {new_role}")
                
                role_builder = PacketBuilder()
                role_builder.write_string(new_role['name'])
                role_builder.write_byte(new_role['jobCode'])
                role_builder.write_byte(new_role['sex'])
                role_builder.write_short(new_role['level'])
                role_builder.write_unsigned_short(new_role['headIconIndex'])
                role_builder.write_byte(new_role['hairStyleIndex'])
                role_builder.write_string(str(new_role['accountId']))
                role_builder.write_string(str(new_role['createTime']))
                role_builder.write_string(str(new_role['lastPlayTime']))
                role_builder.write_bool(new_role['deletedFlag'])
                role_builder.write_string(str(new_role['willDeleteTime']))
                role_builder.write_varint(0)
                role_builder.write_bool(new_role['hasRolePassword'])
                
                role_bytes = role_builder.get_bytes()
                builder.write_short(len(role_bytes))
                builder.write_bytes(role_bytes)
                builder.write_string("")
            
            self.send_packet(builder.build(RoleCommandCode.CREATE_ROLE_ANSWER))
            
        except Exception as e:
            self.log(f"Erro ao criar role: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_select_role(self, reader: PacketReader):
        """Selecionar personagem (cmd 265)"""
        try:
            name = reader.read_string()
            password = reader.read_string()
            
            self.log(f"SelectRole: name={name}")
            
            result = self.server.select_role(self.session.account_id, name, password)
            
            builder = PacketBuilder()
            
            if result.get('IsDone'):
                for role in self.server.get_roles_for_account(self.session.account_id):
                    if role.get('name') == name:
                        self.session.selected_role = role
                        break
                builder.write_bool(True)
                builder.write_string("")
                self.log(f"✅ Personagem selecionado: {name}")
            else:
                builder.write_bool(False)
                builder.write_string(result.get('FailureReason', 'Erro'))
                self.log(f"❌ Falha: {result.get('FailureReason')}")
            
            self.send_packet(builder.build(RoleCommandCode.SELECT_ROLE_ANSWER))
            
        except Exception as e:
            self.log(f"Erro ao selecionar role: {e}")
            import traceback
            traceback.print_exc()
    
    def handle_delete_role(self, reader: PacketReader):
        """Deletar personagem (cmd 263)"""
        try:
            name = reader.read_string()
            self.log(f"DeleteRole: name={name}")
            
            result = self.server.delete_role(self.session.account_id, name)
            
            builder = PacketBuilder()
            builder.write_bool(bool(result.get('IsDone')))
            builder.write_string(result.get('FailureReason', '') if not result.get('IsDone') else '')
            
            self.send_packet(builder.build(RoleCommandCode.DELETE_ROLE_ANSWER))
            
        except Exception as e:
            self.log(f"Erro ao deletar role: {e}")
