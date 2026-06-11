from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from servers.world_server import write_transportable_object
from typing import Dict

def write_team_member_info(builder: PacketBuilder, name: str, session):
    if session and session.player_data:
        pd = session.player_data
        builder.write_string(name)
        builder.write_bool(True) # isOnline
        builder.write_byte(int(pd.get('jobCode', 1)))
        builder.write_byte(int(pd.get('sex', 0)))
        builder.write_short(int(pd.get('level', 1)))
        builder.write_unsigned_byte(int(pd.get('headIconIndex', 0)))
        builder.write_unsigned_int(int(pd.get('hp', 100)))
        builder.write_unsigned_int(int(pd.get('hpMax', 100)))
        builder.write_unsigned_short(int(pd.get('mp', 50)))
        builder.write_unsigned_short(int(pd.get('mpMax', 50)))
        builder.write_string(pd.get('mateRelationInfo', {}).get('mateName', ''))
        builder.write_byte(int(pd.get('mateRelationInfo', {}).get('relationType', 0)))
    else:
        builder.write_string(name)
        builder.write_bool(False) # isOnline
        builder.write_byte(1)
        builder.write_byte(0)
        builder.write_short(1)
        builder.write_unsigned_byte(0)
        builder.write_unsigned_int(100)
        builder.write_unsigned_int(100)
        builder.write_unsigned_short(50)
        builder.write_unsigned_short(50)
        builder.write_string("")
        builder.write_byte(0)

def send_team_check_notify(session, team_name: str, leader: str, members: list, server):
    builder = PacketBuilder()
    builder.write_string(team_name)
    builder.write_string(leader)
    
    # members array
    builder.write_varint(len(members))
    for mem_name in members:
        mem_session = server.sessions.get(mem_name)
        def write_member(b):
            write_team_member_info(b, mem_name, mem_session)
        write_transportable_object(builder, write_member)
        
    session.send_packet(builder.build(8449))

class TeamHandler(BaseHandler):
    PLAYER_TEAM_CHECK_NOTIFY = 8449
    PLAYER_TEAM_MEMBER_CHECK_NOTIFY = 8450
    PLAYER_CREATE_TEAM_REQUEST = 8465
    PLAYER_DISMISS_TEAM_REQUEST = 8466
    PLAYER_INVITE_TEAM_REQUEST = 8471
    PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY = 8472
    PLAYER_PROCESS_INVITE_TEAM_REQUEST_REPLY = 8473
    PLAYER_QUIT_TEAM_REQUEST = 8479

    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            cls.PLAYER_CREATE_TEAM_REQUEST: 'handle_create_team',
            cls.PLAYER_INVITE_TEAM_REQUEST: 'handle_invite_team',
            cls.PLAYER_PROCESS_INVITE_TEAM_REQUEST_REPLY: 'handle_invite_reply',
            cls.PLAYER_QUIT_TEAM_REQUEST: 'handle_quit_team',
            cls.PLAYER_DISMISS_TEAM_REQUEST: 'handle_dismiss_team',
        }

    def handle_create_team(self, reader: PacketReader):
        try:
            self.log(f"PLAYER_CREATE_TEAM_REQUEST by {self.role_name}")
            
            # Simple in-memory team: Leader = self.role_name, member list starts with leader
            team_name = f"Grupo de {self.role_name}"
            self.server.teams[self.role_name] = {
                'teamName': team_name,
                'leader': self.role_name,
                'members': [self.role_name]
            }
            
            if self.player_data:
                self.player_data['teamName'] = team_name
                self.player_data['isTeamLeader'] = True
                
            send_team_check_notify(self.session, team_name, self.role_name, [self.role_name], self.server)
            self.log(f"Team '{team_name}' created successfully")
            
        except Exception as e:
            self.log(f"Error creating team: {e}")

    def handle_invite_team(self, reader: PacketReader):
        try:
            target_name = reader.read_string()
            self.log(f"PLAYER_INVITE_TEAM_REQUEST: from={self.role_name} target={target_name}")
            
            # Find target session
            target_session = self.server.sessions.get(target_name)
            if not target_session:
                self.log(f"Target '{target_name}' not online")
                return
                
            # Send PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY (cmd 8472)
            notify = PacketBuilder()
            notify.write_string(self.role_name)
            target_session.send_packet(notify.build(self.PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY))
            self.log(f"Team invite notification sent to {target_name}")
            
        except Exception as e:
            self.log(f"Error inviting to team: {e}")

    def handle_invite_reply(self, reader: PacketReader):
        try:
            inviter_name = reader.read_string()
            reply = reader.read_bool()
            self.log(f"PLAYER_PROCESS_INVITE_TEAM_REQUEST_REPLY: from={self.role_name} inviter={inviter_name} reply={reply}")
            
            if not reply:
                return
                
            # Find inviter's team. If they don't have one, create it
            team = self.server.teams.get(inviter_name)
            if not team:
                team_name = f"Grupo de {inviter_name}"
                team = {
                    'teamName': team_name,
                    'leader': inviter_name,
                    'members': [inviter_name]
                }
                self.server.teams[inviter_name] = team
                
                inviter_session = self.server.sessions.get(inviter_name)
                if inviter_session and inviter_session.player_data:
                    inviter_session.player_data['teamName'] = team_name
                    inviter_session.player_data['isTeamLeader'] = True
                    
            if self.role_name not in team['members']:
                team['members'].append(self.role_name)
                
            if self.player_data:
                self.player_data['teamName'] = team['teamName']
                self.player_data['isTeamLeader'] = False
                
            # Notify all team members about the updated team list
            for mem_name in team['members']:
                mem_session = self.server.sessions.get(mem_name)
                if mem_session:
                    send_team_check_notify(mem_session, team['teamName'], team['leader'], team['members'], self.server)
                    
            self.log(f"Player {self.role_name} joined {inviter_name}'s team")
            
        except Exception as e:
            self.log(f"Error handling team reply: {e}")

    def handle_quit_team(self, reader: PacketReader):
        try:
            self.log(f"PLAYER_QUIT_TEAM_REQUEST by {self.role_name}")
            
            # Find which team the player belongs to
            target_leader = None
            for leader, team in self.server.teams.items():
                if self.role_name in team['members']:
                    target_leader = leader
                    break
                    
            if not target_leader:
                return
                
            team = self.server.teams[target_leader]
            team['members'].remove(self.role_name)
            
            if self.player_data:
                self.player_data['teamName'] = ""
                self.player_data['isTeamLeader'] = False
                
            # Clear team panel on current client by sending empty check notify
            send_team_check_notify(self.session, "", "", [], self.server)
            
            # Notify remaining members
            if team['members']:
                # If leader quit, assign new leader
                if target_leader == self.role_name:
                    new_leader = team['members'][0]
                    team['leader'] = new_leader
                    self.server.teams[new_leader] = team
                    del self.server.teams[target_leader]
                    
                    new_leader_session = self.server.sessions.get(new_leader)
                    if new_leader_session and new_leader_session.player_data:
                        new_leader_session.player_data['isTeamLeader'] = True
                
                for mem_name in team['members']:
                    mem_session = self.server.sessions.get(mem_name)
                    if mem_session:
                        send_team_check_notify(mem_session, team['teamName'], team['leader'], team['members'], self.server)
            else:
                # Team empty, delete it
                if target_leader in self.server.teams:
                    del self.server.teams[target_leader]
                    
            self.log(f"Player {self.role_name} quit the team")
            
        except Exception as e:
            self.log(f"Error quitting team: {e}")

    def handle_dismiss_team(self, reader: PacketReader):
        try:
            self.log(f"PLAYER_DISMISS_TEAM_REQUEST by {self.role_name}")
            
            team = self.server.teams.get(self.role_name)
            if not team:
                return
                
            for mem_name in team['members']:
                mem_session = self.server.sessions.get(mem_name)
                if mem_session:
                    if mem_session.player_data:
                        mem_session.player_data['teamName'] = ""
                        mem_session.player_data['isTeamLeader'] = False
                    send_team_check_notify(mem_session, "", "", [], self.server)
                    
            del self.server.teams[self.role_name]
            self.log(f"Team dismissed by leader {self.role_name}")
            
        except Exception as e:
            self.log(f"Error dismissing team: {e}")
