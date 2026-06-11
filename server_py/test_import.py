import sys
sys.path.insert(0, "/c/Users/jeova/Downloads/Converted on 2022-06-04/server_py")

try:
    from handlers.loot_manager import LootManager
    print("LootManager: OK")
except Exception as e:
    print(f"LootManager: FAILED - {e}")

try:
    from handlers.pet_handler import PetHandler
    print("PetHandler: OK")
except Exception as e:
    print(f"PetHandler: FAILED - {e}")

try:
    from handlers.inventory_handler import InventoryHandler
    print("InventoryHandler: OK")
except Exception as e:
    print(f"InventoryHandler: FAILED - {e}")

try:
    from tools.audit_combat_completion import analyze_skill_resource
    print("audit_combat_completion: OK")
except Exception as e:
    print(f"audit_combat_completion: FAILED - {e}")

try:
    from gameplay.buff_runtime import apply_buff
    print("gameplay.buff_runtime: OK")
except Exception as e:
    print(f"gameplay.buff_runtime: FAILED - {e}")
