import sys
from handlers.registry import get_handler_registry

registry = get_handler_registry()
commands = registry.get_registered_commands()

print("=== Verifying handler ID conflicts ===")
for cmd_id in [50, 5127, 690]:
    if cmd_id in commands:
        print(f"Command {cmd_id}: {commands[cmd_id]}")
    else:
        print(f"Command {cmd_id}: NOT REGISTERED")

print("\n=== All registered commands ===")
for cmd_id, handler in sorted(commands.items()):
    print(f"  {cmd_id}: {handler}")