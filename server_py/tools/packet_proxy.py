"""
Asa de Cristal - Packet Proxy Interceptor
==========================================
Proxy TCP que intercepta e decodifica pacotes entre cliente e servidor.

Uso:
    python packet_proxy.py [--listen-port 8888] [--target-host 127.0.0.1] [--target-port 9999] [--no-forward]

Exemplos:
    # Apenas capturar pacotes do cliente (sem servidor destino)
    python packet_proxy.py --no-forward
    
    # Proxy entre cliente e servidor real
    python packet_proxy.py --target-host 192.168.1.100 --target-port 8888
    
    # Escutar em porta diferente
    python packet_proxy.py --listen-port 9000 --no-forward
"""

import socket
import threading
import struct
import sys
import os
import argparse
from datetime import datetime
from typing import Optional, Tuple, Dict
from dataclasses import dataclass
from enum import Enum

# Adiciona o diretório pai ao path para imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# ============================================
# Importar comandos do arquivo gerado
# ============================================
try:
    from command_codes import COMMAND_NAMES
except ImportError:
    # Fallback se não existir
    COMMAND_NAMES: Dict[int, str] = {}

class Direction(Enum):
    CLIENT_TO_SERVER = "C→S"
    SERVER_TO_CLIENT = "S→C"

@dataclass
class PacketInfo:
    direction: Direction
    command: int
    payload: bytes
    timestamp: datetime
    
    @property
    def command_name(self) -> str:
        return COMMAND_NAMES.get(self.command, f"UNKNOWN_{self.command}")

# ============================================
# Funções de Parse
# ============================================

def read_varint(data: bytes, offset: int = 0) -> Tuple[int, int]:
    """Lê um VarInt e retorna (valor, bytes_consumidos)"""
    result = 0
    shift = 0
    bytes_read = 0
    
    while offset + bytes_read < len(data):
        byte = data[offset + bytes_read]
        bytes_read += 1
        result |= (byte & 0x7F) << shift
        if (byte & 0x80) == 0:
            break
        shift += 7
        if bytes_read > 5:
            raise ValueError("VarInt too long")
    
    return result, bytes_read

def read_string(data: bytes, offset: int = 0) -> Tuple[str, int]:
    """Lê uma string (varint length + utf8 bytes)"""
    length, varint_size = read_varint(data, offset)
    start = offset + varint_size
    end = start + length
    if end > len(data):
        return f"<truncated:{length}bytes>", varint_size
    string_data = data[start:end].decode('utf-8', errors='replace')
    return string_data, varint_size + length

def parse_packet_payload(cmd: int, payload: bytes, direction: Direction) -> str:
    """Tenta fazer parse do payload baseado no comando conhecido"""
    try:
        if cmd == 1:  # LOGIN_REQUEST
            offset = 0
            username, size = read_string(payload, offset)
            offset += size
            password, size = read_string(payload, offset)
            offset += size
            version, size = read_string(payload, offset)
            return f"username={username}, password={'*'*len(password)}, version={version}"
        
        elif cmd == 7:  # ENTER_WORLD_REQUEST
            role_name, _ = read_string(payload, 0)
            return f"roleName={role_name}"
        
        elif cmd == 49:  # CYCLIC_REQUEST
            if len(payload) >= 4:
                tick = struct.unpack('>I', payload[:4])[0]
                return f"cycTick={tick}"
        
        elif cmd == 515:  # PLAYER_VIEW_MAP_REQUEST
            map_id, size = read_string(payload, 0)
            offset = size
            line_index = payload[offset] if offset < len(payload) else 0
            return f"mapId={map_id}, lineIndex={line_index}"
        
        elif cmd == 537:  # PLAYER_WALK_REQUEST
            if len(payload) >= 6:
                # MapPoint é 2 shorts (x, y)
                x = struct.unpack('>h', payload[0:2])[0]
                y = struct.unpack('>h', payload[2:4])[0]
                # walkPath é array de MapPoints
                path_count, varint_size = read_varint(payload, 4)
                return f"toPosition=({x},{y}), pathCount={path_count}"
        
        elif cmd == 5122:  # PLAYER_BAG_CAPACITY_CHANGE_NOTIFY
            if len(payload) >= 2:
                bag_index = payload[0]
                capacity = payload[1]
                return f"bagIndex={bag_index}, capacity={capacity}"
        
        elif cmd == 5124:  # PLAYER_USE_ITEM_REQUEST
            if len(payload) >= 2:
                bag_index = payload[0]
                offset = 1
                slot_index, size = read_varint(payload, offset)
                return f"bagIndex={bag_index}, slotIndex={slot_index}"
        
        elif cmd == 5125:  # PLAYER_MOVE_ITEM_REQUEST
            if len(payload) >= 3:
                bag_index = payload[0]
                offset = 1
                from_slot, size = read_varint(payload, offset)
                offset += size
                to_slot, size = read_varint(payload, offset)
                return f"bagIndex={bag_index}, fromSlot={from_slot}, toSlot={to_slot}"
        
    except Exception as e:
        return f"<parse error: {e}>"
    
    return ""

def format_hex_dump(data: bytes, max_bytes: int = 64) -> str:
    """Formata bytes como hex dump legível"""
    if len(data) == 0:
        return "<empty>"
    
    truncated = len(data) > max_bytes
    display_data = data[:max_bytes]
    
    hex_str = ' '.join(f'{b:02X}' for b in display_data)
    ascii_str = ''.join(chr(b) if 32 <= b < 127 else '.' for b in display_data)
    
    result = f"HEX: {hex_str}"
    if truncated:
        result += f" ... (+{len(data) - max_bytes} bytes)"
    result += f"\nASC: {ascii_str}"
    
    return result

# ============================================
# Cores para Terminal
# ============================================

class Colors:
    RESET = '\033[0m'
    BOLD = '\033[1m'
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    MAGENTA = '\033[95m'
    CYAN = '\033[96m'
    WHITE = '\033[97m'
    
    @staticmethod
    def client(text: str) -> str:
        return f"{Colors.CYAN}{text}{Colors.RESET}"
    
    @staticmethod
    def server(text: str) -> str:
        return f"{Colors.GREEN}{text}{Colors.RESET}"
    
    @staticmethod
    def error(text: str) -> str:
        return f"{Colors.RED}{text}{Colors.RESET}"
    
    @staticmethod
    def info(text: str) -> str:
        return f"{Colors.YELLOW}{text}{Colors.RESET}"

# ============================================
# Proxy Handler
# ============================================

class PacketProxy:
    def __init__(self, listen_port: int, target_host: Optional[str], target_port: Optional[int], no_forward: bool):
        self.listen_port = listen_port
        self.target_host = target_host
        self.target_port = target_port
        self.no_forward = no_forward
        self.running = False
        self.connections = 0
        self.packets_captured = 0
        self.log_file = None
        
    def start(self):
        """Inicia o proxy"""
        self.running = True
        
        # Criar arquivo de log
        log_filename = "server_py/logs/latest.log"
        self.log_file = None
        
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.bind(('0.0.0.0', self.listen_port))
        server_socket.listen(5)
        
        print(Colors.info("=" * 60))
        print(Colors.info("  ASA DE CRISTAL - PACKET PROXY INTERCEPTOR"))
        print(Colors.info("=" * 60))
        print(f"  Escutando em: {Colors.BOLD}0.0.0.0:{self.listen_port}{Colors.RESET}")
        
        if self.no_forward:
            print(f"  Modo: {Colors.YELLOW}CAPTURE ONLY (sem forwarding){Colors.RESET}")
        else:
            print(f"  Target: {Colors.BOLD}{self.target_host}:{self.target_port}{Colors.RESET}")
        
        print(f"  Log central: {Colors.BOLD}{log_filename}{Colors.RESET}")
        print(Colors.info("=" * 60))
        print(Colors.info("Aguardando conexões... (Ctrl+C para sair)\n"))
        
        try:
            while self.running:
                server_socket.settimeout(1.0)
                try:
                    client_socket, client_addr = server_socket.accept()
                    self.connections += 1
                    print(Colors.client(f"\n[+] Nova conexão #{self.connections} de {client_addr}"))
                    
                    # Criar thread para lidar com esta conexão
                    handler = threading.Thread(
                        target=self._handle_connection,
                        args=(client_socket, client_addr),
                        daemon=True
                    )
                    handler.start()
                    
                except socket.timeout:
                    continue
                    
        except KeyboardInterrupt:
            print(Colors.info("\n\n[!] Encerrando proxy..."))
        finally:
            self.running = False
            server_socket.close()
            if self.log_file:
                self.log_file.close()
            print(Colors.info(f"[*] Total de pacotes capturados: {self.packets_captured}"))
    
    def _handle_connection(self, client_socket: socket.socket, client_addr: tuple):
        """Lida com uma conexão do cliente"""
        target_socket = None
        
        try:
            # Conectar ao servidor de destino (se não for no_forward)
            if not self.no_forward and self.target_host and self.target_port:
                try:
                    target_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    target_socket.connect((self.target_host, self.target_port))
                    print(Colors.server(f"    [+] Conectado ao servidor {self.target_host}:{self.target_port}"))
                    
                    # Thread para receber do servidor
                    server_thread = threading.Thread(
                        target=self._relay_data,
                        args=(target_socket, client_socket, Direction.SERVER_TO_CLIENT, client_addr),
                        daemon=True
                    )
                    server_thread.start()
                except Exception as e:
                    print(Colors.error(f"    [-] Erro conectando ao servidor: {e}"))
                    target_socket = None
            
            # Receber do cliente
            self._relay_data(client_socket, target_socket, Direction.CLIENT_TO_SERVER, client_addr)
            
        except Exception as e:
            print(Colors.error(f"    [-] Erro na conexão: {e}"))
        finally:
            client_socket.close()
            if target_socket:
                target_socket.close()
            print(Colors.info(f"    [x] Conexão de {client_addr} encerrada"))
    
    def _relay_data(self, source: socket.socket, dest: Optional[socket.socket], 
                    direction: Direction, client_addr: tuple):
        """Relay de dados entre sockets, interceptando pacotes"""
        buffer = b''
        
        try:
            while self.running:
                source.settimeout(1.0)
                try:
                    data = source.recv(4096)
                    if not data:
                        break
                    
                    # Forward imediato dos dados brutos (antes de processar)
                    if dest:
                        try:
                            dest.sendall(data)
                        except Exception as e:
                            print(Colors.error(f"    [-] Erro forward: {e}"))
                            break
                    
                    buffer += data
                    
                    # Processar pacotes completos no buffer (apenas para logging)
                    while len(buffer) > 0:
                        # Tentar ler o tamanho (VarInt)
                        try:
                            packet_len, varint_size = read_varint(buffer, 0)
                        except:
                            break  # Precisa mais dados
                        
                        total_size = varint_size + packet_len
                        
                        if len(buffer) < total_size:
                            break  # Pacote incompleto
                        
                        # Extrair pacote completo
                        packet_data = buffer[varint_size:total_size]
                        buffer = buffer[total_size:]
                        
                        # Parse do comando
                        # Formato: command(2 bytes) + digest(2 bytes) + payload
                        if len(packet_data) >= 4:
                            cmd = struct.unpack('>H', packet_data[:2])[0]
                            digest = struct.unpack('>H', packet_data[2:4])[0]
                            payload = packet_data[4:]  # Pular command + digest
                            
                            # Log do pacote
                            self._log_packet(direction, cmd, payload, client_addr, digest)
                    
                except socket.timeout:
                    continue
                except Exception as e:
                    if self.running:
                        print(Colors.error(f"    [-] Erro relay: {e}"))
                    break
                    
        except Exception as e:
            if self.running:
                print(Colors.error(f"    [-] Erro no relay: {e}"))
    
    def _log_packet(self, direction: Direction, cmd: int, payload: bytes, client_addr: tuple, digest: int = 0):
        """Loga um pacote capturado"""
        self.packets_captured += 1
        timestamp = datetime.now()
        
        # Nome do comando
        cmd_name = COMMAND_NAMES.get(cmd, f"UNKNOWN_{cmd}")
        
        # Cor baseada na direção
        if direction == Direction.CLIENT_TO_SERVER:
            dir_str = Colors.client(f"[{direction.value}]")
            cmd_str = Colors.cyan(f"{cmd_name} ({cmd})")
        else:
            dir_str = Colors.server(f"[{direction.value}]")
            cmd_str = Colors.green(f"{cmd_name} ({cmd})")
        
        # Parse do payload
        parsed = parse_packet_payload(cmd, payload, direction)
        
        # Print no console
        digest_str = f", digest={digest}" if digest else ""
        print(f"\n{dir_str} {Colors.BOLD}{cmd_name}{Colors.RESET} (cmd={cmd}{digest_str}, len={len(payload)})")
        if parsed:
            print(f"    📋 {parsed}")
        if len(payload) > 0:
            hex_preview = ' '.join(f'{b:02X}' for b in payload[:32])
            if len(payload) > 32:
                hex_preview += f" ... (+{len(payload)-32} bytes)"
            print(f"    📦 {hex_preview}")
        
        # Salvar no arquivo de log
        if self.log_file:
            self.log_file.write(f"\n{'='*60}\n")
            self.log_file.write(f"[{timestamp.strftime('%H:%M:%S.%f')[:-3]}] {direction.value} {cmd_name} (cmd={cmd})\n")
            self.log_file.write(f"Payload Length: {len(payload)} bytes\n")
            if parsed:
                self.log_file.write(f"Parsed: {parsed}\n")
            self.log_file.write(format_hex_dump(payload, max_bytes=256) + "\n")
            self.log_file.flush()

# Fix para Colors.cyan e Colors.green que faltaram
Colors.cyan = staticmethod(lambda text: f"{Colors.CYAN}{text}{Colors.RESET}")
Colors.green = staticmethod(lambda text: f"{Colors.GREEN}{text}{Colors.RESET}")

# ============================================
# Main
# ============================================

def main():
    parser = argparse.ArgumentParser(
        description='Asa de Cristal - Packet Proxy Interceptor',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exemplos:
  # Apenas capturar pacotes do cliente (responde com erro)
  python packet_proxy.py --no-forward
  
  # Proxy entre cliente e servidor real  
  python packet_proxy.py --target-host 192.168.1.100 --target-port 8888
  
  # Escutar em porta diferente
  python packet_proxy.py --listen-port 9000 --target-host 127.0.0.1 --target-port 8889
"""
    )
    
    parser.add_argument('--listen-port', '-l', type=int, default=8888,
                        help='Porta para escutar conexões (default: 8888)')
    parser.add_argument('--target-host', '-H', type=str, default=None,
                        help='Host do servidor de destino')
    parser.add_argument('--target-port', '-p', type=int, default=None,
                        help='Porta do servidor de destino')
    parser.add_argument('--no-forward', '-n', action='store_true',
                        help='Não encaminhar pacotes, apenas capturar')
    
    args = parser.parse_args()
    
    # Validação
    if not args.no_forward and (not args.target_host or not args.target_port):
        print(Colors.error("Erro: Especifique --target-host e --target-port, ou use --no-forward"))
        print("Use --help para mais informações.")
        sys.exit(1)
    
    proxy = PacketProxy(
        listen_port=args.listen_port,
        target_host=args.target_host,
        target_port=args.target_port,
        no_forward=args.no_forward
    )
    
    proxy.start()

if __name__ == '__main__':
    main()
