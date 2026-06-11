import os

HOST = '0.0.0.0'
HTTP_PORT = 8081
LOGIN_PORT = 9999
POLICY_PORT = 843

WORLD_PORT = int(os.environ.get('WORLD_PORT', 8888))

AUTH_MODE = 'debug'

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
GAME_RESOURCES_DIR = os.path.join(SCRIPT_DIR, 'game_resources')
LOG_DIR = os.path.join(SCRIPT_DIR, 'logs')

LOG_COLORS = {
    'HTTP': '\033[94m',
    'LOGIN': '\033[92m',
    'POLICY': '\033[93m',
    'WORLD': '\033[95m',
    'DB': '\033[96m',
    'RESET': '\033[0m'
}

ENABLE_COLORS = True
