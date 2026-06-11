#!/usr/bin/env python3

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from datetime import datetime
from config import HOST, HTTP_PORT, LOGIN_PORT, WORLD_PORT, POLICY_PORT


def log(message: str):
    timestamp = datetime.now().strftime('%H:%M:%S')
    print(f"[{timestamp}] {message}")


def main():
    print("=" * 60)
    print("  ASA DE CRISTAL - Private Server")
    print("=" * 60)
    print()
    
    from servers import HTTPServer, LoginServer, WorldServer, PolicyServer
    
    http_server = HTTPServer(HOST, HTTP_PORT)
    login_server = LoginServer(HOST, LOGIN_PORT)
    world_server = WorldServer(HOST, WORLD_PORT)
    policy_server = PolicyServer(HOST, POLICY_PORT)
    
    log("Iniciando servidores...")
    
    http_server.start()
    login_server.start()
    world_server.start()
    policy_server.start()
    
    print()
    print("=" * 60)
    print(f"  HTTP Server:    http://{HOST}:{HTTP_PORT}")
    print(f"  Login Server:   {HOST}:{LOGIN_PORT}")
    print(f"  World Server:   {HOST}:{WORLD_PORT}")
    print(f"  Policy Server:  {HOST}:{POLICY_PORT}")
    print("=" * 60)
    print()
    log("Todos os servidores iniciados! Pressione Ctrl+C para parar.")
    print()
    
    try:
        while True:
            input()
    except KeyboardInterrupt:
        log("Encerrando servidores...")
        http_server.stop()
        login_server.stop()
        world_server.stop()
        policy_server.stop()
        log("Servidor encerrado.")


if __name__ == '__main__':
    main()
