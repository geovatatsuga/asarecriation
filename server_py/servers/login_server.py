import socket
import struct
import hashlib
import uuid
import random
import string

from .base_server import BaseTCPServer
from protocol import PacketReader, PacketBuilder, LoginCommandCode

def generate_key(length: int = 8) -> str:
    """Gera uma key aleatória para autenticação"""
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

class LoginSession:
    
    def __init__(self, client_socket: socket.socket, address: tuple, server: 'LoginServer'):
        self.socket = client_socket
        self.address = address
        self.server = server
        self.key = generate_key()
    
    def log(self, message: str):
        from .base_server import log
        log("LOGIN", f"[{self.address}] {message}")
    
    def send_packet(self, packet: bytes):
        """Envia pacote ao cliente"""
        try:
            self.socket.sendall(packet)
            self.log(f"Enviado {len(packet)} bytes")
        except Exception as e:
            self.log(f"Erro ao enviar: {e}")
    
    def send_welcome(self):
        builder = PacketBuilder()
        builder.write_string(self.key)
        packet = builder.build(LoginCommandCode.WELCOME_NOTIFY)
        self.log(f"Enviando WelcomeNotify (key={self.key})")
        self.send_packet(packet)

class LoginServer(BaseTCPServer):
    
    def __init__(self, host: str = '0.0.0.0', port: int = 9999):
        super().__init__('LOGIN', host, port)
        self._db = None
        self._db_available = False
        self._account_repo = None
        self._server_repo = None
        self._init_database()
    
    def _init_database(self):
        try:
            from database import get_db, get_account_repo, get_server_repo
            
            db = get_db()
            if db.connect():
                self._db = db
                self._account_repo = get_account_repo()
                self._server_repo = get_server_repo()
                self._db_available = True
                self.log("✅ Banco de dados conectado")
        except ImportError:
            self.log("⚠️ pyodbc não instalado - modo debug")
        except Exception as e:
            self.log(f"⚠️ Erro DB: {e}")
    
    def handle_client(self, client_socket: socket.socket, address: tuple):
        """Processa cliente do Login Server"""
        session = LoginSession(client_socket, address, self)
        session.log("Cliente conectado")
        
        session.send_welcome()
        
        buffer = b''
        
        try:
            while True:
                data = client_socket.recv(4096)
                if not data:
                    session.log("Cliente desconectou (sem dados)")
                    break
                
                session.log(f"Recebido {len(data)} bytes: {data[:50].hex()}...")
                buffer += data
                
                while len(buffer) >= 1:
                    length = 0
                    shift = 0
                    varint_bytes = 0
                    
                    for i in range(min(5, len(buffer))):
                        byte = buffer[i]
                        length |= (byte & 0x7F) << shift
                        varint_bytes += 1
                        if (byte & 0x80) == 0:
                            break
                        shift += 7
                    else:
                        if len(buffer) >= 5:
                            session.log(f"VarInt inválido, descartando byte")
                            buffer = buffer[1:]
                        break
                    
                    total_len = varint_bytes + length
                    if len(buffer) < total_len:
                        break
                    
                    packet_data = buffer[varint_bytes:total_len]
                    buffer = buffer[total_len:]
                    
                    if len(packet_data) < 4:
                        session.log(f"Pacote muito pequeno: {len(packet_data)}")
                        continue
                    
                    command = struct.unpack('>H', packet_data[:2])[0]
                    digest = struct.unpack('>H', packet_data[2:4])[0]
                    payload = packet_data[4:]
                    
                    session.log(f"Comando: {command}, Payload: {len(payload)} bytes")
                    
                    reader = PacketReader(payload)
                    
                    if command == LoginCommandCode.LOGIN_REQ:
                        response = self._handle_login(reader, session.key, address[0])
                        session.send_packet(response)
                    
                    elif command == LoginCommandCode.SERVER_LIST_REQ:
                        response = self._handle_server_list(reader)
                        session.send_packet(response)
                    
                    else:
                        session.log(f"Comando desconhecido: {command}")
                        
        except Exception as e:
            session.log(f"Erro: {e}")
            import traceback
            traceback.print_exc()
        finally:
            client_socket.close()
            session.log("Desconectado")
    
    def _handle_login(self, reader: PacketReader, session_key: str, client_ip: str) -> bytes:
        """Processa requisição de login"""
        try:
            username = reader.read_string()
            password_hash = reader.read_string()
            
            ss_key = ""
            if reader.remaining() > 0:
                try:
                    ss_key = reader.read_string()
                except:
                    pass
            
            self.log(f"Login: {username}, hash={password_hash[:16]}...")
            
            result = self._authenticate(username, password_hash, session_key, client_ip)
            
            self.log(f"Auth result: status={result['status']}, ticket={result.get('ticket', '')[:8]}...")
            
            builder = PacketBuilder()
            
            if result['status'] == 0:
                builder.write_string(result.get('ticket', ''))  # sessionId
                builder.write_int(0)
            else:
                builder.write_string("")  # sessionId vazio
                builder.write_int(result['status'])  # failureReason
            
            packet = builder.build(LoginCommandCode.LOGIN_ANSWER)
            self.log(f"LoginAnswer: {len(packet)} bytes")
            return packet
            
        except Exception as e:
            self.log(f"Erro no login: {e}")
            import traceback
            traceback.print_exc()
            
            builder = PacketBuilder()
            builder.write_string("")  # sessionId vazio
            builder.write_int(99)
            return builder.build(LoginCommandCode.LOGIN_ANSWER)
    
    def _authenticate(self, username: str, password_hash: str, key: str, client_ip: str) -> dict:
        """Autentica usuário"""
        if self._db_available and self._account_repo:
            try:
                account = self._account_repo.get_account(username)
                
                if not account:
                    self.log(f"Conta '{username}' não encontrada, criando automaticamente...")
                    try:
                        self._db.execute_non_query(
                            "INSERT INTO TB_Account (Username, PasswordHash, Status) VALUES (?, ?, 1)",
                            (username, 'debug'))
                        account = self._account_repo.get_account(username)
                    except Exception as e:
                        self.log(f"Erro ao criar conta: {e}")
                
                if not account:
                    self.log(f"Fallback: permitindo login de '{username}' sem verificação")
                    return self._fallback_auth(username, client_ip)
                
                if account.get('IsBanned'):
                    return {'status': 3, 'desc': 'Conta banida'}
                
                stored_password = account.get('LoginPwd', '')
                if stored_password and stored_password != 'debug':
                    expected_hash = hashlib.md5((key + stored_password).encode()).hexdigest()
                    if password_hash.lower() != expected_hash.lower():
                        return {'status': 2, 'desc': 'Senha incorreta'}
                
                session = self._account_repo.create_session(
                    account['AccountUID'], 
                    client_ip
                )
                
                return {
                    'status': 0,
                    'desc': '',
                    'account_id': account['AccountUID'],
                    'account_name': username,
                    'is_adult': bool(account.get('IsAdult', 1)),
                    'identity': '',
                    'register_time': 0,
                    'ticket': session.get('Ticket', '')
                }
                
            except Exception as e:
                self.log(f"Erro auth: {e}")
        
        return self._fallback_auth(username, client_ip)
    
    def _fallback_auth(self, username: str, client_ip: str) -> dict:
        return {
            'status': 0,
            'desc': '',
            'account_id': 1,
            'account_name': username,
            'is_adult': True,
            'identity': '',
            'register_time': 0,
            'ticket': str(uuid.uuid4())
        }
    
    def _handle_server_list(self, reader: PacketReader) -> bytes:
        """Retorna lista de servidores"""
        ss_key = 0
        if reader.remaining() >= 2:
            ss_key = reader.read_short()
        
        self.log(f"ServerListRequest: ssKey={ss_key}")
        
        servers = self._get_servers()
        
        self.log(f"ServerList: {len(servers)} servidores encontrados")
        for s in servers:
            self.log(f"  - {s['id']}: {s['name']} ({s['host']}:{s['port']}) status={s['status']}")
        
        builder = PacketBuilder()
        
        builder.write_varint(len(servers))
        
        for server in servers:
            srv_builder = PacketBuilder()
            srv_builder.write_string(str(server['id']))       # serverId:string
            srv_builder.write_string(server['name'])          # serverName:string
            srv_builder.write_string(server['host'])          # serverIP:string
            srv_builder.write_unsigned_short(server['port'])  # serverPort:ushort
            srv_builder.write_string(str(server.get('status', 0)))  # serverStatus:string
            
            srv_data = srv_builder.get_bytes()
            builder.write_short(len(srv_data))
            builder.write_bytes(srv_data)
        
        builder.write_string("1")
        
        return builder.build(LoginCommandCode.SERVER_LIST_ANSWER)
    
    def _get_servers(self) -> list:
        if self._db_available and self._server_repo:
            try:
                servers = self._server_repo.get_server_list()
                return [{
                    'id': s['ServerID'],
                    'name': s['ServerName'],
                    'host': s['ServerIP'],
                    'port': s['ServerPort'],
                    'status': s['Status']
                } for s in servers]
            except Exception as e:
                self.log(f"Erro ao buscar servidores: {e}")
        
        return [{
            'id': 1,
            'name': 'Servidor Principal',
            'host': '127.0.0.1',
            'port': 8888,
            'status': 0
        }]
