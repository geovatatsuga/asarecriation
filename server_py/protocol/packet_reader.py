import struct


class PacketReader:
    
    def __init__(self, data: bytes):
        self.data = data
        self.pos = 0
    
    def remaining(self) -> int:
        return len(self.data) - self.pos
    
    def read_bytes(self, count: int) -> bytes:
        if self.pos + count > len(self.data):
            raise ValueError(f"Tentando ler {count} bytes, mas só restam {self.remaining()}")
        result = self.data[self.pos:self.pos + count]
        self.pos += count
        return result
    
    def read_byte(self) -> int:
        return struct.unpack('>b', self.read_bytes(1))[0]
    
    def read_unsigned_byte(self) -> int:
        return struct.unpack('>B', self.read_bytes(1))[0]
    
    def read_short(self) -> int:
        return struct.unpack('>h', self.read_bytes(2))[0]
    
    def read_unsigned_short(self) -> int:
        return struct.unpack('>H', self.read_bytes(2))[0]
    
    def read_int(self) -> int:
        return struct.unpack('>i', self.read_bytes(4))[0]
    
    def read_unsigned_int(self) -> int:
        return struct.unpack('>I', self.read_bytes(4))[0]
    
    def read_long(self) -> int:
        return struct.unpack('>q', self.read_bytes(8))[0]
    
    def read_varint(self) -> int:
        result = 0
        shift = 0
        while True:
            byte = self.read_unsigned_byte()
            result |= (byte & 0x7F) << shift
            if (byte & 0x80) == 0:
                break
            shift += 7
        return result
    
    def read_string(self) -> str:
        length = self.read_varint()
        if length == 0:
            return ""
        data = self.read_bytes(length)
        return data.decode('utf-8')
    
    def read_bool(self) -> bool:
        return self.read_unsigned_byte() != 0
    
    def peek_bytes(self, count: int) -> bytes:
        if self.pos + count > len(self.data):
            return self.data[self.pos:]
        return self.data[self.pos:self.pos + count]
    
    def skip(self, count: int):
        self.pos = min(self.pos + count, len(self.data))
