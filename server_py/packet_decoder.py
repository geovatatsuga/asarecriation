#!/usr/bin/env python3
"""
Utilitário de Análise de Packets - Asa de Cristal
Decodifica e analisa packets capturados
"""

import struct
import json
import sys
from typing import Dict, List, Any
from enum import IntEnum

# ============================================================================
# CÓDIGOS DE COMANDO CONHECIDOS
# ============================================================================

# Login Server (porta 9999)
LOGIN_COMMANDS = {
    16: {'name': 'WelcomeNotify', 'fields': ['key:string'], 'dir': 'S2C'},
    17: {'name': 'LoginRequest', 'fields': ['user:string', 'password:string', 'ssKey:short'], 'dir': 'C2S'},
    18: {'name': 'LoginAnswer', 'fields': ['sessionId:string', 'failureReason:string'], 'dir': 'S2C'},
    19: {'name': 'LogoutRequest', 'fields': [], 'dir': 'C2S'},
    20: {'name': 'LogoutAnswer', 'fields': ['sessionId:string'], 'dir': 'S2C'},
    23: {'name': 'ServerListRequest', 'fields': [], 'dir': 'C2S'},
    24: {'name': 'ServerListAnswer', 'fields': ['serverList:array:object', 'selectedServer:int'], 'dir': 'S2C'},
}

# World Server (porta 8888) - parcial
WORLD_COMMANDS = {
    # Sistema
    1: {'name': 'WorldPingEcho', 'fields': ['timestamp:long'], 'dir': 'BOTH'},
    2: {'name': 'WorldTimeCheckNotify', 'fields': ['serverTime:long'], 'dir': 'S2C'},
    
    # Login/Logout do World
    3: {'name': 'WorldLoginRequest', 'fields': ['sessionId:string', 'serverId:int'], 'dir': 'C2S'},
    4: {'name': 'WorldLoginAnswer', 'fields': ['success:bool', 'reason:string'], 'dir': 'S2C'},
    5: {'name': 'WorldLogoutRequest', 'fields': [], 'dir': 'C2S'},
    6: {'name': 'WorldLogoutAnswer', 'fields': [], 'dir': 'S2C'},
    
    # Role/Personagem (100-199)
    100: {'name': 'RoleListRequest', 'fields': [], 'dir': 'C2S'},
    101: {'name': 'RoleListAnswer', 'fields': ['roles:array:object'], 'dir': 'S2C'},
    102: {'name': 'CreateRoleRequest', 'fields': ['name:string', 'gender:byte', 'job:byte', 'hairStyle:byte'], 'dir': 'C2S'},
    103: {'name': 'CreateRoleAnswer', 'fields': ['success:bool', 'reason:string', 'roleId:long'], 'dir': 'S2C'},
    104: {'name': 'SelectRoleRequest', 'fields': ['roleId:long', 'password:string'], 'dir': 'C2S'},
    105: {'name': 'SelectRoleAnswer', 'fields': ['success:bool', 'reason:string'], 'dir': 'S2C'},
    106: {'name': 'DeleteRoleRequest', 'fields': ['roleId:long'], 'dir': 'C2S'},
    107: {'name': 'DeleteRoleAnswer', 'fields': ['success:bool', 'reason:string'], 'dir': 'S2C'},
    108: {'name': 'RoleNameConfirmRequest', 'fields': ['name:string'], 'dir': 'C2S'},
    109: {'name': 'RoleNameConfirmAnswer', 'fields': ['available:bool'], 'dir': 'S2C'},
    
    # Player (200-299)
    200: {'name': 'PlayerEnterWorldRequest', 'fields': [], 'dir': 'C2S'},
    201: {'name': 'PlayerEnterWorldAnswer', 'fields': ['success:bool', 'playerData:object'], 'dir': 'S2C'},
    202: {'name': 'PlayerEnterMapRequest', 'fields': ['mapId:int', 'x:short', 'y:short'], 'dir': 'C2S'},
    203: {'name': 'PlayerEnterMapAnswer', 'fields': ['success:bool', 'mapData:object'], 'dir': 'S2C'},
    204: {'name': 'PlayerMoveRequest', 'fields': ['targetX:short', 'targetY:short'], 'dir': 'C2S'},
    205: {'name': 'PlayerPositionCheckNotify', 'fields': ['x:short', 'y:short', 'direction:byte'], 'dir': 'S2C'},
    206: {'name': 'PlayerLeaveMapNotify', 'fields': [], 'dir': 'S2C'},
}

# Combinar todos
ALL_COMMANDS = {**LOGIN_COMMANDS, **WORLD_COMMANDS}

# ============================================================================
# DECODIFICADOR
# ============================================================================

class PacketDecoder:
    """Decodificador de packets DIY"""
    
    def __init__(self, data: bytes):
        self.data = data
        self.pos = 0
    
    def read_byte(self) -> int:
        if self.pos >= len(self.data):
            return 0
        value = self.data[self.pos]
        self.pos += 1
        return value
    
    def read_short(self) -> int:
        if self.pos + 2 > len(self.data):
            return 0
        value = struct.unpack('>h', self.data[self.pos:self.pos+2])[0]
        self.pos += 2
        return value
    
    def read_ushort(self) -> int:
        if self.pos + 2 > len(self.data):
            return 0
        value = struct.unpack('>H', self.data[self.pos:self.pos+2])[0]
        self.pos += 2
        return value
    
    def read_int(self) -> int:
        if self.pos + 4 > len(self.data):
            return 0
        value = struct.unpack('>i', self.data[self.pos:self.pos+4])[0]
        self.pos += 4
        return value
    
    def read_long(self) -> int:
        if self.pos + 8 > len(self.data):
            return 0
        value = struct.unpack('>q', self.data[self.pos:self.pos+8])[0]
        self.pos += 8
        return value
    
    def read_float(self) -> float:
        if self.pos + 4 > len(self.data):
            return 0.0
        value = struct.unpack('>f', self.data[self.pos:self.pos+4])[0]
        self.pos += 4
        return value
    
    def read_double(self) -> float:
        if self.pos + 8 > len(self.data):
            return 0.0
        value = struct.unpack('>d', self.data[self.pos:self.pos+8])[0]
        self.pos += 8
        return value
    
    def read_bool(self) -> bool:
        return self.read_byte() != 0
    
    def read_string(self) -> str:
        length = self.read_short()
        if length <= 0 or self.pos + length > len(self.data):
            return ''
        value = self.data[self.pos:self.pos+length].decode('utf-8', errors='replace')
        self.pos += length
        return value
    
    def read_bytes(self) -> bytes:
        length = self.read_short()
        if length <= 0 or self.pos + length > len(self.data):
            return b''
        value = self.data[self.pos:self.pos+length]
        self.pos += length
        return value
    
    def read_field(self, field_type: str, array_type: str = None) -> Any:
        """Lê um campo pelo tipo"""
        if field_type == 'byte':
            return self.read_byte()
        elif field_type == 'short':
            return self.read_short()
        elif field_type == 'int':
            return self.read_int()
        elif field_type == 'long':
            return self.read_long()
        elif field_type == 'float':
            return self.read_float()
        elif field_type == 'double':
            return self.read_double()
        elif field_type == 'bool':
            return self.read_bool()
        elif field_type == 'string':
            return self.read_string()
        elif field_type == 'bytes':
            return self.read_bytes().hex()
        elif field_type == 'array':
            count = self.read_short()
            items = []
            for _ in range(count):
                if array_type == 'string':
                    items.append(self.read_string())
                elif array_type == 'int':
                    items.append(self.read_int())
                elif array_type == 'object':
                    items.append(self.read_object())
                else:
                    items.append(f'<{array_type}>')
            return items
        elif field_type == 'object':
            return self.read_object()
        else:
            return f'<unknown:{field_type}>'
    
    def read_object(self) -> Dict:
        """Lê um objeto (sem conhecer a estrutura)"""
        length = self.read_short()
        if length <= 0:
            return {}
        obj_data = self.data[self.pos:self.pos+length]
        self.pos += length
        return {
            '_raw': obj_data.hex(),
            '_length': length,
            '_text': obj_data.decode('utf-8', errors='replace')
        }
    
    def remaining(self) -> bytes:
        return self.data[self.pos:]

# ============================================================================
# FUNÇÕES DE ANÁLISE
# ============================================================================

def decode_hex(hex_string: str) -> Dict:
    """Decodifica uma string hex em um packet"""
    # Limpar string
    hex_string = hex_string.replace(' ', '').replace('\n', '').replace('\r', '')
    
    try:
        data = bytes.fromhex(hex_string)
    except ValueError as e:
        return {'error': f'Hex inválido: {e}'}
    
    if len(data) < 4:
        return {'error': 'Packet muito pequeno (mínimo 4 bytes)'}
    
    decoder = PacketDecoder(data)
    
    # Header
    payload_len = decoder.read_ushort()
    command_code = decoder.read_short()
    
    result = {
        'raw_hex': hex_string,
        'total_length': len(data),
        'payload_length': payload_len,
        'command_code': command_code,
        'command_name': 'UNKNOWN',
        'fields': {},
        'remaining_hex': '',
        'remaining_text': ''
    }
    
    # Procurar comando
    if command_code in ALL_COMMANDS:
        cmd_def = ALL_COMMANDS[command_code]
        result['command_name'] = cmd_def['name']
        result['direction'] = cmd_def['dir']
        
        # Decodificar campos
        for field_def in cmd_def['fields']:
            parts = field_def.split(':')
            field_name = parts[0]
            field_type = parts[1] if len(parts) > 1 else 'string'
            array_type = parts[2] if len(parts) > 2 else None
            
            try:
                result['fields'][field_name] = decoder.read_field(field_type, array_type)
            except Exception as e:
                result['fields'][field_name] = f'<error: {e}>'
                break
    
    # Bytes restantes
    remaining = decoder.remaining()
    if remaining:
        result['remaining_hex'] = remaining.hex()
        result['remaining_text'] = remaining.decode('utf-8', errors='replace')
    
    return result

def print_decoded(decoded: Dict):
    """Imprime o packet decodificado de forma legível"""
    print("\n" + "="*60)
    print("PACKET DECODIFICADO")
    print("="*60)
    
    if 'error' in decoded:
        print(f"ERRO: {decoded['error']}")
        return
    
    print(f"Tamanho total: {decoded['total_length']} bytes")
    print(f"Payload: {decoded['payload_length']} bytes")
    print(f"Comando: {decoded['command_name']} (code={decoded['command_code']})")
    
    if 'direction' in decoded:
        dir_map = {'C2S': 'Cliente → Servidor', 'S2C': 'Servidor → Cliente', 'BOTH': 'Bidirecional'}
        print(f"Direção: {dir_map.get(decoded['direction'], decoded['direction'])}")
    
    if decoded['fields']:
        print("\nCampos:")
        for name, value in decoded['fields'].items():
            if isinstance(value, dict):
                print(f"  {name}: (objeto)")
                for k, v in value.items():
                    print(f"    {k}: {v}")
            elif isinstance(value, list):
                print(f"  {name}: [{len(value)} itens]")
                for i, item in enumerate(value):
                    print(f"    [{i}]: {item}")
            else:
                print(f"  {name}: {value}")
    
    if decoded['remaining_hex']:
        print(f"\nBytes não processados ({len(decoded['remaining_hex'])//2} bytes):")
        print(f"  Hex: {decoded['remaining_hex'][:64]}{'...' if len(decoded['remaining_hex']) > 64 else ''}")
        if decoded['remaining_text'].strip():
            print(f"  Texto: {decoded['remaining_text'][:64]}...")

def list_commands():
    """Lista todos os comandos conhecidos"""
    print("\n" + "="*70)
    print("COMANDOS CONHECIDOS")
    print("="*70)
    
    print("\n--- LOGIN SERVER (porta 9999) ---")
    for code, cmd in sorted(LOGIN_COMMANDS.items()):
        dir_icon = '→' if cmd['dir'] == 'C2S' else '←' if cmd['dir'] == 'S2C' else '↔'
        print(f"  {code:3d} {dir_icon} {cmd['name']}")
        if cmd['fields']:
            print(f"       Fields: {cmd['fields']}")
    
    print("\n--- WORLD SERVER (porta 8888) ---")
    for code, cmd in sorted(WORLD_COMMANDS.items()):
        dir_icon = '→' if cmd['dir'] == 'C2S' else '←' if cmd['dir'] == 'S2C' else '↔'
        print(f"  {code:3d} {dir_icon} {cmd['name']}")
        if cmd['fields']:
            print(f"       Fields: {cmd['fields']}")

def interactive_mode():
    """Modo interativo para decodificar packets"""
    print("\n" + "="*60)
    print("DECODIFICADOR DE PACKETS - Modo Interativo")
    print("="*60)
    print("Comandos:")
    print("  - Cole o hex do packet para decodificar")
    print("  - 'list' para listar comandos conhecidos")
    print("  - 'quit' para sair")
    print("="*60)
    
    while True:
        try:
            print("\n")
            hex_input = input("Hex> ").strip()
            
            if not hex_input:
                continue
            
            if hex_input.lower() == 'quit':
                break
            
            if hex_input.lower() == 'list':
                list_commands()
                continue
            
            decoded = decode_hex(hex_input)
            print_decoded(decoded)
            
        except KeyboardInterrupt:
            break
        except Exception as e:
            print(f"Erro: {e}")

# ============================================================================
# MAIN
# ============================================================================

def main():
    if len(sys.argv) > 1:
        # Modo linha de comando
        if sys.argv[1] == '--list':
            list_commands()
        else:
            # Decodificar hex passado como argumento
            hex_input = ' '.join(sys.argv[1:])
            decoded = decode_hex(hex_input)
            print_decoded(decoded)
            print("\nJSON:")
            print(json.dumps(decoded, indent=2, default=str))
    else:
        # Modo interativo
        interactive_mode()

if __name__ == '__main__':
    main()
