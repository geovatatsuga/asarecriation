import socket
import threading
from datetime import datetime
from typing import Callable, Optional

from config import LOG_COLORS, ENABLE_COLORS
from smart_logging import smart_logger


def log(prefix: str, message: str, session=None, **context):
    smart_logger.log(prefix, message, session=session, **context)
    timestamp = datetime.now().strftime('%H:%M:%S')
    
    if ENABLE_COLORS and prefix in LOG_COLORS:
        color = LOG_COLORS[prefix]
        reset = LOG_COLORS['RESET']
        print(f"[{timestamp}] {color}[{prefix}]{reset} {message}")
    else:
        print(f"[{timestamp}] [{prefix}] {message}")


class BaseTCPServer:
    
    def __init__(self, name: str, host: str, port: int):
        self.name = name
        self.host = host
        self.port = port
        self.socket: Optional[socket.socket] = None
        self.running = False
        self.thread: Optional[threading.Thread] = None
    
    def log(self, message: str):
        log(self.name, message)
    
    def handle_client(self, client_socket: socket.socket, address: tuple):
        raise NotImplementedError
    
    def start(self):
        self.thread = threading.Thread(target=self._run, daemon=True)
        self.thread.start()
    
    def _run(self):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        
        try:
            self.socket.bind((self.host, self.port))
            self.socket.listen(5)
            self.running = True
            self.log(f"Servidor iniciado em {self.host}:{self.port}")
            
            while self.running:
                try:
                    client_socket, address = self.socket.accept()
                    client_thread = threading.Thread(
                        target=self.handle_client,
                        args=(client_socket, address),
                        daemon=True
                    )
                    client_thread.start()
                except OSError:
                    break
                    
        except Exception as e:
            self.log(f"Erro: {e}")
        finally:
            self.stop()
    
    def stop(self):
        self.running = False
        if self.socket:
            try:
                self.socket.close()
            except:
                pass
            self.socket = None
