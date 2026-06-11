import http.server
import socketserver
import os
import threading
import json
from datetime import datetime

from config import HTTP_PORT, GAME_RESOURCES_DIR, LOG_COLORS, ENABLE_COLORS
from smart_logging import smart_logger


def log(prefix: str, message: str):
    timestamp = datetime.now().strftime('%H:%M:%S')
    if ENABLE_COLORS and prefix in LOG_COLORS:
        color = LOG_COLORS[prefix]
        reset = LOG_COLORS['RESET']
        print(f"[{timestamp}] {color}[{prefix}]{reset} {message}")
    else:
        print(f"[{timestamp}] [{prefix}] {message}")


class GameHTTPHandler(http.server.SimpleHTTPRequestHandler):
    _request_counts = {}
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=GAME_RESOURCES_DIR, **kwargs)
    
    def log_message(self, format, *args):
        log("HTTP", f"{self.address_string()} - {format % args}")

    def send_response(self, code, message=None):
        self._response_code = code
        super().send_response(code, message)

    def send_head(self):
        request_path = self.path.split('?', 1)[0]
        if request_path in ('/game.swf', '/bin/game.bin') and '?' not in self.path:
            file_path = self.translate_path(request_path)
            if os.path.isfile(file_path):
                version = os.stat(file_path).st_mtime_ns
                self.send_response(302)
                self.send_header('Location', f'{request_path}?v={version}')
                self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
                self.send_header('Pragma', 'no-cache')
                self.send_header('Expires', '0')
                self.end_headers()
                return None
        path = self.translate_path(self.path)
        if os.path.isfile(path):
            stat = os.stat(path)
            etag = f'"{stat.st_size:x}-{stat.st_mtime_ns:x}"'
            if self.headers.get('If-None-Match') == etag:
                self.send_response(304)
                self.send_header('ETag', etag)
                self.end_headers()
                return None
            self._response_size = stat.st_size
            self._etag = etag
        return super().send_head()
    
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        path = self.path.split('?', 1)[0]
        if path in (
            '/res/remoteUrl',
            '/res/data1',
            '/res/data2',
            '/res/16ceadfbd18d8d9042567d31415807c6',
        ):
            self.send_header('Cache-Control', 'no-cache, must-revalidate')
        elif path.startswith('/res/'):
            # Resource filenames are content hashes. Caching them avoids
            # repeatedly transferring multi-megabyte assets on every login.
            self.send_header('Cache-Control', 'public, max-age=31536000, immutable')
        elif path.endswith(('.swf', '.bin')):
            # During local reconstruction these files change often while keeping
            # the same URL, so never let Flash reuse a stale client binary.
            self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')
            self.send_header('Pragma', 'no-cache')
            self.send_header('Expires', '0')
        else:
            self.send_header('Cache-Control', 'no-cache, must-revalidate')
        if getattr(self, '_etag', None):
            self.send_header('ETag', self._etag)
        super().end_headers()

    def finish(self):
        try:
            path = self.path.split('?', 1)[0]
            code = getattr(self, '_response_code', 0)
            size = getattr(self, '_response_size', 0) if code == 200 else 0
            key = (self.client_address[0], path)
            self._request_counts[key] = self._request_counts.get(key, 0) + 1
            smart_logger.count(f"http_status_{code}")
            smart_logger.count("http_requests")
            smart_logger.count("http_bytes_sent", size)
            if code == 304:
                smart_logger.count("http_cache_hits")
            elif code == 200 and size:
                smart_logger.count("http_downloads")
            if self._request_counts[key] > 1 and code == 200:
                smart_logger.count("http_repeat_downloads")
                if size >= 1_000_000:
                    smart_logger.log("HTTP_CACHE", "Arquivo grande baixado novamente", path=path, bytes=size, repeats=self._request_counts[key])
        finally:
            super().finish()

    def do_GET(self):
        path = self.path.split('?', 1)[0]
        # The original remoteUrl points at dead 9919 services. Flash caches this
        # file aggressively and a failed RemoteFlash Loader can remain above the
        # game UI, swallowing clicks intended for window close buttons.
        if path.rstrip('/') == '/res/remoteUrl':
            payload = json.dumps({
                'loadingBG': ['/LoadingBG/01.swf'],
                'RemoteFlash': '',
                'ResetGamePage': '',
                'HuoDong': '',
                'HelpPage': '',
                'PisPage': '',
            }).encode('utf-8')
            self.send_response(200)
            self.send_header('Content-Type', 'application/json; charset=utf-8')
            self.send_header('Content-Length', str(len(payload)))
            self.end_headers()
            self.wfile.write(payload)
            return
        super().do_GET()
    
    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()


class HTTPServer:
    
    def __init__(self, host: str = '0.0.0.0', port: int = HTTP_PORT):
        self.host = host
        self.port = port
        self.server = None
        self.thread = None
    
    def start(self):
        self.thread = threading.Thread(target=self._run, daemon=True)
        self.thread.start()
    
    def _run(self):
        try:
            self.server = socketserver.ThreadingTCPServer(
                (self.host, self.port), 
                GameHTTPHandler
            )
            self.server.daemon_threads = True
            self.server.allow_reuse_address = True
            log("HTTP", f"Servidor iniciado em {self.host}:{self.port}")
            log("HTTP", f"Servindo arquivos de: {GAME_RESOURCES_DIR}")
            self.server.serve_forever()
        except Exception as e:
            log("HTTP", f"Erro: {e}")
    
    def stop(self):
        if self.server:
            self.server.shutdown()
