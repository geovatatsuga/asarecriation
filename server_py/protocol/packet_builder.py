import struct


class PacketBuilder:
    
    def __init__(self):
        self.buffer = bytearray()
    
    def write_byte(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>b', value))
        return self
    
    def write_unsigned_byte(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>B', value))
        return self
    
    def write_short(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>h', value))
        return self
    
    def write_unsigned_short(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>H', value))
        return self
    
    def write_int(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>i', value))
        return self
    
    def write_unsigned_int(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>I', value))
        return self
    
    def write_long(self, value: int) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>q', value))
        return self
    
    def write_float(self, value: float) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>f', value))
        return self
    
    def write_double(self, value: float) -> 'PacketBuilder':
        self.buffer.extend(struct.pack('>d', value))
        return self
    
    def write_varint(self, value: int) -> 'PacketBuilder':
        while True:
            byte = value & 0x7F
            value >>= 7
            if value:
                byte |= 0x80
            self.buffer.append(byte)
            if not value:
                break
        return self
    
    def write_string(self, value: str) -> 'PacketBuilder':
        if value is None:
            value = ""
        encoded = value.encode('utf-8')
        self.write_varint(len(encoded))
        self.buffer.extend(encoded)
        return self
    
    def write_bool(self, value: bool) -> 'PacketBuilder':
        self.buffer.append(1 if value else 0)
        return self
    
    def write_bytes(self, data: bytes) -> 'PacketBuilder':
        self.buffer.extend(data)
        return self
    
    def build(self, command: int, digest: int = 0) -> bytes:
        payload = bytes(self.buffer)
        header = struct.pack('>HH', command, digest)
        packet_body = header + payload
        
        length_bytes = bytearray()
        length = len(packet_body)
        while True:
            byte = length & 0x7F
            length >>= 7
            if length:
                byte |= 0x80
            length_bytes.append(byte)
            if not length:
                break
        
        return bytes(length_bytes) + packet_body
    
    def get_bytes(self) -> bytes:
        return bytes(self.buffer)
    
    def clear(self):
        self.buffer = bytearray()
