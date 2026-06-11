import time
import random
from typing import Dict, List
from handlers.base_handler import BaseHandler
from protocol.packet_reader import PacketReader
from protocol.packet_builder import PacketBuilder
from protocol.commands import BagCommandCode, MapCommandCode


# Hardcoded drop groups referenced in imn.json but missing from decoded JSONs
DROP_GROUPS = {
    "bw0200": [  # Boss/world boss drops - quest items + basic loot
        {"itemCode": "bq020d", "chance": 1.0, "minCount": 1, "maxCount": 1},  # peitoral da quest
        {"itemCode": "dy0000", "chance": 0.5, "minCount": 1, "maxCount": 3},  # poção mana
        {"itemCode": "dy0001", "chance": 0.5, "minCount": 1, "maxCount": 3},  # poção vida
        {"itemCode": "gold", "chance": 1.0, "minCount": 50, "maxCount": 200},  # gold
    ],
    "ab0000": [  # General early-game drops
        {"itemCode": "dy0000", "chance": 0.3, "minCount": 1, "maxCount": 2},
        {"itemCode": "dy0001", "chance": 0.3, "minCount": 1, "maxCount": 2},
        {"itemCode": "gold", "chance": 1.0, "minCount": 10, "maxCount": 50},
    ],
    "bb1000": [  # Mini-boss/boss drops
        {"itemCode": "dy0000", "chance": 0.5, "minCount": 2, "maxCount": 5},
        {"itemCode": "dy0001", "chance": 0.5, "minCount": 2, "maxCount": 5},
        {"itemCode": "gold", "chance": 1.0, "minCount": 100, "maxCount": 500},
    ],
}


class LootManager(BaseHandler):
    @classmethod
    def get_handlers(cls) -> Dict[int, str]:
        return {
            BagCommandCode.PLAYER_PICKUP_ITEM_REQ: 'handle_pickup_item',
            BagCommandCode.PLAYER_DROP_ITEM_REQ: 'handle_drop_item',
        }

    def handle_pickup_item(self, reader: PacketReader):
        try:
            map_id = reader.read_string()
            item_id = reader.read_string()
            self.log(f"PLAYER_PICKUP_ITEM_REQ: map={map_id}, item={item_id}")
            
            if not self.player_data:
                return
                
            map_instance = self.server.map_manager.get_map(map_id)
            if not map_instance:
                self.log(f"❌ Map instance {map_id} not found")
                return
                
            item = map_instance.items.get(item_id)
            if not item:
                self.log(f"❌ Item {item_id} not found on map {map_id}")
                return
                
            # Add to player inventory
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            
            # bagIndex=1 (main bag)
            result = inv_mgr.add_item(self.role_name, item['itemCode'], item['itemCount'], 1)
            success = bool(result.get('success'))
            
            if success:
                # Notify player of item added (floating effect + chat)
                self.session._send_item_added_notify([{
                    'item_id': item_id,
                    'item_code': item['itemCode'],
                    'count': item['itemCount']
                }])
                
                # Refresh backpack slots
                items_in_bag = inv_mgr.load_inventory(self.role_name, 1)
                self.session._send_bag_check(1, items_in_bag)
                
                # Remove from map instance
                del map_instance.items[item_id]
                
                # Broadcast removal to all players on the map
                remove_notify = PacketBuilder()
                remove_notify.write_string(map_id)
                remove_notify.write_string(item_id)
                packet_data = remove_notify.build(MapCommandCode.MAP_ITEM_REMOVED_NOTIFY)
                # Send to all sessions on the same map
                for sess in self.server.sessions.values():
                    if sess.player_data and sess.player_data.get('mapId') == map_id:
                        sess.send_packet(packet_data)
                        
                self.log(f"🎁 Player {self.role_name} picked up {item['itemCode']} x{item['itemCount']}")
            else:
                self.log(f"❌ Inventory full, could not pick up {item['itemCode']}")
                
        except Exception as e:
            self.log(f"Error handling pickup item: {e}")

    def handle_drop_item(self, reader: PacketReader):
        try:
            bag_index = reader.read_byte()
            item_index = reader.read_unsigned_byte()
            map_id = reader.read_string()
            
            # read MapPoint wrapper
            has_point = reader.read_unsigned_short() > 0
            target_x = 0
            target_y = 0
            if has_point:
                target_x = reader.read_short()
                target_y = reader.read_short()
                
            self.log(f"PLAYER_DROP_ITEM_REQ: bag={bag_index}, slot={item_index}, pos=({target_x}, {target_y})")
            
            if not self.player_data:
                return
                
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.get_db())
            
            # Find item in bag
            items = inv_mgr.load_inventory(self.role_name, bag_index)
            item_to_drop = None
            for it in items:
                if it.slot_index == item_index:
                    item_to_drop = it
                    break
                    
            if not item_to_drop:
                self.log(f"❌ Item not found in bag={bag_index} slot={item_index}")
                return
                
            # Remove item from inventory
            result = inv_mgr.remove_item(self.role_name, bag_index, item_index, item_to_drop.item_count)
            if result.get('success'):
                # Refresh bag check (send slot as empty)
                self.session._send_bag_check(bag_index, inv_mgr.load_inventory(self.role_name, bag_index), [item_index])
                
                # Spawn item on the ground
                x = target_x if target_x > 0 else self.player_data.get('posX', 1000)
                y = target_y if target_y > 0 else self.player_data.get('posY', 1000)
                
                self.spawn_loot_on_ground(map_id, x, y, item_to_drop.item_code, item_to_drop.item_count)
                self.log(f"Dropped {item_to_drop.item_code} on map {map_id} at ({x}, {y})")
                
        except Exception as e:
            self.log(f"Error handling drop item: {e}")

    def spawn_loot_on_ground(self, map_id: str, x: int, y: int, item_code: str, count: int):
        map_instance = self.server.map_manager.get_map(map_id)
        if not map_instance:
            return
            
        item_id = f"loot_{int(time.time() * 1000)}_{random.randint(1000, 9999)}"
        loot_item = {
            'x': x,
            'y': y,
            'itemId': item_id,
            'itemCode': item_code,
            'itemCount': count,
            'protectionTimeLeft': 0,
            'spawn_time': time.time()
        }
        
        map_instance.items[item_id] = loot_item
        
        # Broadcast MAP_ITEM_ADDED_NOTIFY (cmd 1537)
        notify = PacketBuilder()
        notify.write_string(map_id)
        
        # Serialize MapItemInfo with length prefix (transportable)
        def write_map_item_info_raw(builder):
            builder.write_short(x)
            builder.write_short(y)
            builder.write_string(item_id)
            builder.write_string(item_code)
            builder.write_unsigned_byte(min(int(count), 255))
            builder.write_byte(0) # protectionTimeLeft
            
        from servers.world_server import write_transportable_object
        write_transportable_object(notify, write_map_item_info_raw)
        
        packet_data = notify.build(MapCommandCode.MAP_ITEM_ADDED_NOTIFY)
        # Send to all sessions on the same map
        for sess in self.server.sessions.values():
            if sess.player_data and sess.player_data.get('mapId') == map_id:
                sess.send_packet(packet_data)

    @staticmethod
    def resolve_drop_groups(drop_group_names: List[str]) -> List[dict]:
        """Resolve drop group names to actual item drops.
        Returns list of dicts with itemCode and count."""
        drops = []
        for group_name in drop_group_names:
            group = DROP_GROUPS.get(group_name)
            if not group:
                continue
            for entry in group:
                if random.random() < entry.get("chance", 1.0):
                    count = random.randint(entry.get("minCount", 1), entry.get("maxCount", 1))
                    drops.append({"itemCode": entry["itemCode"], "count": count})
        return drops

    def spawn_monster_loot(self, map_id: str, x: int, y: int, drop_group_names: List[str]):
        """Spawn loot from drop groups at monster death location."""
        drops = self.resolve_drop_groups(drop_group_names)
        for drop in drops:
            item_code = drop["itemCode"]
            count = drop["count"]
            if item_code == "gold":
                # Gold is handled separately via PLAYER_GOLD_CHANGE_NOTIFY
                # For now, spawn as a special item that auto-picks up
                # TODO: Implement proper gold drop handling
                pass
            else:
                self.spawn_loot_on_ground(map_id, x, y, item_code, count)
