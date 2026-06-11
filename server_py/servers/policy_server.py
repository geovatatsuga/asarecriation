import socket

from .base_server import BaseTCPServer


POLICY_RESPONSE = b'''<?xml version="1.0"?>
<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
    <allow-access-from domain="*" to-ports="*"/>
</cross-domain-policy>\x00'''


class PolicyServer(BaseTCPServer):
    
    def __init__(self, host: str = '0.0.0.0', port: int = 843):
        super().__init__('POLICY', host, port)
    
    def handle_client(self, client_socket: socket.socket, address: tuple):
        try:
            data = client_socket.recv(1024)
            if b'policy-file-request' in data:
                self.log(f"Policy request de {address}")
                client_socket.send(POLICY_RESPONSE)
        except Exception as e:
            self.log(f"Erro: {e}")
        finally:
            try:
                client_socket.close()
            except:
                pass
