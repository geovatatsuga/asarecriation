import socket
import struct
import time
import logging
import os
from typing import Dict, List, Optional

from .base_server import BaseTCPServer, log
from smart_logging import smart_logger
from protocol import PacketReader, PacketBuilder, WorldCommandCode, RoleCommandCode, PlayerCommandCode, BagCommandCode, ShopCommandCode

logger = logging.getLogger(__name__)

from handlers.registry import get_handler_registry
from debug_role_store import DebugRoleStore

try:
    from game_data.map_teleport_config import MAP_EXITS as _MAP_EXITS_RAW, MAP_ENTRIES as _MAP_ENTRIES_RAW
    
    MAP_EXITS = {}
    for (from_map, exit_id), (to_map, to_entry) in _MAP_EXITS_RAW.items():
        if from_map not in MAP_EXITS:
            MAP_EXITS[from_map] = {}
        MAP_EXITS[from_map][exit_id] = {"toMap": to_map, "toEntry": to_entry}
    
    MAP_ENTRIES = {}
    for (map_id, entry_id), (pos_x, pos_y) in _MAP_ENTRIES_RAW.items():
        if map_id not in MAP_ENTRIES:
            MAP_ENTRIES[map_id] = {}
        MAP_ENTRIES[map_id][entry_id] = {"x": pos_x, "y": pos_y}
    
    print(f"[MAPS] Loaded {len(_MAP_EXITS_RAW)} exits and {len(_MAP_ENTRIES_RAW)} entries from config")
except ImportError as e:
    print(f"[WARN] Could not load map_teleport_config: {e}")
    print("[WARN] Using empty map configs - run generate_map_teleport_sql.py to generate")
    MAP_EXITS = {}
    MAP_ENTRIES = {}

def write_transportable_object(builder: PacketBuilder, write_func, *args, **kwargs):
    """
    Wrapper para escrever objetos transportáveis com prefixo de tamanho (2 bytes ushort).
    O cliente espera: length(2 bytes) + data
    Se length=0, o objeto é null.
    """
    import struct
    
    temp_builder = PacketBuilder()
    write_func(temp_builder, *args, **kwargs)
    obj_data = temp_builder.get_bytes()
    
    builder.write_unsigned_short(len(obj_data))
    builder.write_bytes(obj_data)

def _write_map_point_raw(builder: PacketBuilder, x: int = 0, y: int = 0):
    """Serializa MapPoint (sem prefixo de tamanho): ["x:short","y:short"]"""
    builder.write_short(x)
    builder.write_short(y)

def write_map_point(builder: PacketBuilder, x: int = 0, y: int = 0):
    """Serializa MapPoint COM prefixo de tamanho: ["x:short","y:short"]"""
    before_len = len(builder.get_bytes())
    
    write_transportable_object(builder, _write_map_point_raw, x, y)
    
    after_bytes = builder.get_bytes()[before_len:]
    # print(f"[DEBUG] write_map_point: x={x}, y={y} -> bytes: {after_bytes.hex()}")

def _write_farm_harvest_info_raw(builder: PacketBuilder, harvest: Dict):
    builder.write_string(str(harvest.get("id", "")))
    builder.write_unsigned_byte(int(harvest.get("productRate", 1)) & 0xFF)
    builder.write_byte(int(harvest.get("phaseIndex", 0)))
    builder.write_int(int(harvest.get("phaseTimeLeftInSec", 0)))
    builder.write_bool(bool(harvest.get("isIll", False)))
    builder.write_unsigned_byte(int(harvest.get("promoteTimesCurrent", 0)) & 0xFF)
    builder.write_short(int(harvest.get("productNumberTotal", 1)))
    builder.write_short(int(harvest.get("productNumberLeft", 1)))
    builder.write_string(str(harvest.get("createrId", "")))
    builder.write_string(str(harvest.get("code", "")))
    builder.write_short(int(harvest.get("x", 0)))
    builder.write_short(int(harvest.get("y", 0)))

def write_farm_harvest_info(builder: PacketBuilder, harvest: Dict):
    write_transportable_object(builder, _write_farm_harvest_info_raw, harvest)

def _write_map_item_info_raw(builder: PacketBuilder, item: Dict):
    """
    Serializa MapItemInfo (sem prefixo):
    ["x:short","y:short","itemId:string","itemCode:string","itemCount:ubyte","protectionTimeLeft:byte"]
    """
    builder.write_short(int(item.get('x', 0) or 0))
    builder.write_short(int(item.get('y', 0) or 0))
    builder.write_string(str(item.get('itemId', '') or ''))
    builder.write_string(str(item.get('itemCode', '') or ''))
    builder.write_unsigned_byte(max(0, min(int(item.get('itemCount', 1) or 1), 255)))
    builder.write_byte(max(-128, min(int(item.get('protectionTimeLeft', 0) or 0), 127)))

def write_map_item_info(builder: PacketBuilder, item: Dict):
    write_transportable_object(builder, _write_map_item_info_raw, item)

def map_harvests_from_definition(map_id: str, map_def: Dict) -> List[Dict]:
    harvest_array = (map_def or {}).get("harvestRule", {}).get("harvestArray", [])
    harvests = []
    for idx, rule in enumerate(harvest_array):
        code = str(rule.get("code", ""))
        if not code:
            continue
        harvests.append({
            "id": f"fh_{map_id}_{idx}",
            "productRate": 1,
            "phaseIndex": 0,
            "phaseTimeLeftInSec": 0,
            "isIll": False,
            "promoteTimesCurrent": 0,
            "productNumberTotal": 1,
            "productNumberLeft": 1,
            "createrId": "",
            "code": code,
            "x": int(float(rule.get("px", 0))),
            "y": int(float(rule.get("py", 0))),
        })
    return harvests

def _write_dynamic_vars_raw(builder: PacketBuilder, bool_vars: Dict = None, int_vars: Dict = None, str_vars: Dict = None):
    """
    Serializa DynamicVars (sem prefixo):
    ["boolVars:map(string,boolean)","intVars:map(string,vint)","strVars:map(string,string)"]
    """
    bool_vars = bool_vars or {}
    int_vars = int_vars or {}
    str_vars = str_vars or {}
    
    builder.write_varint(len(bool_vars))
    for key, val in bool_vars.items():
        builder.write_string(key)
        builder.write_bool(val)
    
    builder.write_varint(len(int_vars))
    for key, val in int_vars.items():
        builder.write_string(key)
        builder.write_varint(val)
    
    builder.write_varint(len(str_vars))
    for key, val in str_vars.items():
        builder.write_string(key)
        builder.write_string(val)

def write_dynamic_vars(builder: PacketBuilder, bool_vars: Dict = None, int_vars: Dict = None, str_vars: Dict = None):
    """Serializa DynamicVars COM prefixo de tamanho"""
    write_transportable_object(builder, _write_dynamic_vars_raw, bool_vars, int_vars, str_vars)

def _write_task_recorder_raw(builder: PacketBuilder, doing_allocators: Dict = None, doing_tasks: List = None, done_tasks: Dict = None):
    """
    Serializa TaskRecorder (sem prefixo):
    ["doingAllocators:map(ushort,ushort)","doingTasks:array(ushort)","doneTasks:map(ushort,short)"]
    """
    doing_allocators = doing_allocators or {}
    doing_tasks = doing_tasks or []
    done_tasks = done_tasks or {}
    
    builder.write_varint(len(doing_allocators))
    for key, val in doing_allocators.items():
        builder.write_unsigned_short(int(key))
        builder.write_unsigned_short(int(val))
    
    builder.write_varint(len(doing_tasks))
    for task in doing_tasks:
        builder.write_unsigned_short(task)
    
    builder.write_varint(len(done_tasks))
    for key, val in done_tasks.items():
        builder.write_unsigned_short(int(key))
        builder.write_short(int(val))

def write_task_recorder(builder: PacketBuilder, doing_allocators: Dict = None, doing_tasks: List = None, done_tasks: Dict = None):
    """Serializa TaskRecorder COM prefixo de tamanho"""
    write_transportable_object(builder, _write_task_recorder_raw, doing_allocators, doing_tasks, done_tasks)

def _write_friend_info_raw(builder: PacketBuilder, friend: Dict):
    """
    Serializa FriendInfo (sem prefixo):
    ["friendName:string","relationValue:int","sex:byte","level:short","isOnline:boolean","moodIndex:byte"]
    """
    builder.write_string(friend.get('friendName', ''))
    builder.write_int(friend.get('relationValue', 0))
    builder.write_byte(friend.get('sex', 0))
    builder.write_short(friend.get('level', 1))
    builder.write_bool(friend.get('isOnline', False))
    builder.write_byte(friend.get('moodIndex', 0))

def write_friend_info(builder: PacketBuilder, friend: Dict):
    """Serializa FriendInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_friend_info_raw, friend)

def _write_role_attributes_raw(builder: PacketBuilder, attrs: Dict = None):
    """
    Serializa RoleAttributesInfo (sem prefixo) com todos os campos:
    ["strength:int","wisdom:int","agility:int","vitality:int","hp:double","hpMax:double",
     "mp:int","mpMax:int","sp:int","spMax:int","xp:int","xpMax:int",
     "physicalAttack:double","physicalDefense:int","physicalReduceRate:float",
     "magicAttack:double","magicDefense:int","magicReduceRate:float",
     "hitValue:int","hitRate:float","dodgeValue:int","dodgeRate:float",
     "critValue:int","critRate:float","luckyAttack:int","luckyDefense:int",
     "critDamageMul:float","toughValue:int","pierceAttack:int","pierceDefense:int",
     "singTimeModifier:float","castTimeModifier:float","singTimeReduceMS:int",
     "walkSpeed:int","hpHealValue:int","mpHealValue:int","spHealValue:int",
     "cureValue:int","element1Attack:int","element2Attack:int","element3Attack:int",
     "element4Attack:int","element5Attack:int","element1Defense:int","element2Defense:int",
     "element3Defense:int","element4Defense:int","element5Defense:int",
     "lot:int","loa:int","loh:int"]
    """
    attrs = attrs or {}
    
    builder.write_int(attrs.get('strength', 10))
    builder.write_int(attrs.get('wisdom', 10))
    builder.write_int(attrs.get('agility', 10))
    builder.write_int(attrs.get('vitality', 10))
    
    builder.write_double(float(attrs.get('hp', 100)))
    builder.write_double(float(attrs.get('hpMax', 100)))
    builder.write_int(attrs.get('mp', 50))
    builder.write_int(attrs.get('mpMax', 50))
    builder.write_int(attrs.get('sp', 0))
    builder.write_int(attrs.get('spMax', 100))
    builder.write_int(attrs.get('xp', 0))
    builder.write_int(attrs.get('xpMax', 100))
    
    builder.write_double(float(attrs.get('physicalAttack', 10)))
    builder.write_int(attrs.get('physicalDefense', 5))
    builder.write_float(attrs.get('physicalReduceRate', 0.0))
    builder.write_double(float(attrs.get('magicAttack', 10)))
    builder.write_int(attrs.get('magicDefense', 5))
    builder.write_float(attrs.get('magicReduceRate', 0.0))
    
    builder.write_int(attrs.get('hitValue', 50))
    builder.write_float(attrs.get('hitRate', 0.95))
    builder.write_int(attrs.get('dodgeValue', 10))
    builder.write_float(attrs.get('dodgeRate', 0.05))
    builder.write_int(attrs.get('critValue', 10))
    builder.write_float(attrs.get('critRate', 0.05))
    builder.write_int(attrs.get('luckyAttack', 0))
    builder.write_int(attrs.get('luckyDefense', 0))
    builder.write_float(attrs.get('critDamageMul', 1.5))
    builder.write_int(attrs.get('toughValue', 0))
    builder.write_int(attrs.get('pierceAttack', 0))
    builder.write_int(attrs.get('pierceDefense', 0))
    
    builder.write_float(attrs.get('singTimeModifier', 1.0))
    builder.write_float(attrs.get('castTimeModifier', 1.0))
    builder.write_int(attrs.get('singTimeReduceMS', 0))
    
    builder.write_int(attrs.get('walkSpeed', 200))
    builder.write_int(attrs.get('hpHealValue', 0))
    builder.write_int(attrs.get('mpHealValue', 0))
    builder.write_int(attrs.get('spHealValue', 0))
    builder.write_int(attrs.get('cureValue', 0))
    
    for i in range(1, 6):
        builder.write_int(attrs.get(f'element{i}Attack', 0))
    for i in range(1, 6):
        builder.write_int(attrs.get(f'element{i}Defense', 0))
    
    builder.write_int(attrs.get('lot', 0))
    builder.write_int(attrs.get('loa', 0))
    builder.write_int(attrs.get('loh', 0))

def write_role_attributes(builder: PacketBuilder, attrs: Dict = None):
    """Serializa RoleAttributesInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_role_attributes_raw, attrs)

def _write_mate_relation_info_raw(builder: PacketBuilder, mate: Dict = None):
    """
    Serializa MateRelationInfo (sem prefixo):
    ["mateName:string","relationType:byte","mateValue:ushort","mateGold:ushort"]
    """
    mate = mate or {}
    builder.write_string(mate.get('mateName', ''))
    builder.write_byte(mate.get('relationType', 0))
    builder.write_unsigned_short(mate.get('mateValue', 0))
    builder.write_unsigned_short(mate.get('mateGold', 0))

def write_mate_relation_info(builder: PacketBuilder, mate: Dict = None):
    """Serializa MateRelationInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_mate_relation_info_raw, mate)

def _write_buff_info_raw(builder: PacketBuilder, buff: Dict):
    """
    Serializa BuffInfo (sem prefixo):
    ["buffId:ushort","durationInSec:vint"]
    """
    builder.write_unsigned_short(int(buff.get('buffId', 0) or 0))
    builder.write_varint(int(float(buff.get('durationInSec', 0) or 0)))

def write_buff_info(builder: PacketBuilder, buff: Dict):
    """Serializa BuffInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_buff_info_raw, buff)

def _write_monster_info_raw(builder: PacketBuilder, monster):
    """
    Serializa MonsterInfo (sem prefixo):
    ["ownerPlayerId:string","id:string","monsterCode:string","level:short","x:short","y:short",
     "pathArrayReversed:array(MapPoint)","walkSpeed:short","hpPercent:byte","isBoss:boolean",
     "prefixArray:array(string)","buffArray:array(BuffInfo)"]
    """
    builder.write_string("") # ownerPlayerId
    builder.write_string(monster.instance_id) # id
    builder.write_string(monster.code) # monsterCode
    builder.write_short(monster.level) # level
    builder.write_short(monster.x) # x
    builder.write_short(monster.y) # y
    builder.write_varint(0) # pathArrayReversed (empty)
    builder.write_short(monster.walk_speed) # walkSpeed
    builder.write_byte(monster.get_hp_percent()) # hpPercent
    builder.write_bool(monster.is_boss) # isBoss
    builder.write_varint(0) # prefixArray (empty)
    builder.write_varint(0) # buffArray (empty)

def write_monster_info(builder: PacketBuilder, monster):
    """Serializa MonsterInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_monster_info_raw, monster)

def _write_local_player_farm_info_raw(builder: PacketBuilder, farm: Dict = None):
    """
    Serializa LocalPlayerFarmInfo (sem prefixo):
    ["mapId:string","farmId:string","templetCode:string","name:string",
     "ownerId:string","currentLevel:byte","farmExp:int","styleCode:string"]
    """
    farm = farm or {}
    builder.write_string(farm.get('mapId', ''))
    builder.write_string(farm.get('farmId', ''))
    builder.write_string(farm.get('templetCode', ''))
    builder.write_string(farm.get('name', ''))
    builder.write_string(farm.get('ownerId', ''))
    builder.write_byte(farm.get('currentLevel', 1))
    builder.write_int(farm.get('farmExp', 0))
    builder.write_string(farm.get('styleCode', ''))

def write_local_player_farm_info(builder: PacketBuilder, farm: Dict = None):
    """Serializa LocalPlayerFarmInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_local_player_farm_info_raw, farm)

def _write_local_player_info_raw(builder: PacketBuilder, role: Dict, attrs: Dict = None):
    """
    Serializa LocalPlayerInfo completo (sem prefixo) (RoleBaseInfo + LocalPlayerInfo fields)
    
    RoleBaseInfo: ["name:string","jobCode:byte","sex:byte","level:short","headIconIndex:ushort","hairStyleIndex:ubyte"]
    
    LocalPlayerInfo adiciona muitos campos!
    """
    start_pos = len(builder.get_bytes())
    
    builder.write_string(role.get('name', ''))
    builder.write_byte(role.get('jobCode', 1))
    builder.write_byte(role.get('sex', 0))
    builder.write_short(role.get('level', 1))
    builder.write_unsigned_short(role.get('headIconIndex', 0))
    builder.write_unsigned_byte(role.get('hairStyleIndex', 0))  # ubyte!
    
    rolebase_end = len(builder.get_bytes())
    print(f"[DEBUG] RoleBaseInfo: {builder.get_bytes()[start_pos:rolebase_end].hex()}")
    
    builder.write_bool(role.get('isGM', False))
    builder.write_byte(role.get('vipLevel', 0))
    builder.write_string(role.get('mapId', 'a1'))
    
    pre_position = len(builder.get_bytes())
    print(f"[DEBUG] até mapId: {builder.get_bytes()[rolebase_end:pre_position].hex()}")
    
    write_map_point(builder, role.get('posX', 900), role.get('posY', 700))
    builder.write_varint(0)
    builder.write_varint(0)
    builder.write_string(role.get('rideCode', ''))
    builder.write_string(role.get('rideMasterPlayerId', ''))
    builder.write_varint(0)
    builder.write_short(role.get('titleIndex', 0))
    builder.write_short(role.get('kitTitleIndex', 0))
    builder.write_bool(role.get('isDead', False))
    builder.write_bool(role.get('isSitting', False))
    builder.write_double(float(role.get('exp', 0)))
    write_role_attributes(builder, attrs)
    builder.write_int(role.get('statusFlags', 0))
    builder.write_double(float(role.get('gold', 0)))
    builder.write_int(role.get('money', 0))
    builder.write_int(role.get('coin', 0))
    builder.write_int(role.get('vipExp', 0))
    builder.write_byte(role.get('lifeJob', 0))
    builder.write_byte(role.get('lifeLevel', 0))
    builder.write_int(role.get('lifeExp', 0))
    farm_skill_levels = role.get('farmSkillLevelArray', [0, 0, 0, 0])
    builder.write_varint(len(farm_skill_levels))
    for lv in farm_skill_levels:
        builder.write_byte(lv)
    farm_skill_exps = role.get('farmSkillExpArray', [0, 0, 0, 0])
    builder.write_varint(len(farm_skill_exps))
    for exp in farm_skill_exps:
        builder.write_int(exp)
    write_local_player_farm_info(builder, role.get('mainFarm'))
    builder.write_varint(0)
    builder.write_byte(role.get('pkMode', 0))
    builder.write_byte(role.get('pkValue', 0))
    builder.write_byte(role.get('lineIndex', 0))
    write_mate_relation_info(builder, role.get('mateRelationInfo'))
    write_dynamic_vars(builder)
    builder.write_int(role.get('bkHp', 0))
    builder.write_int(role.get('bkHpMax', 0))
    builder.write_int(role.get('bkMp', 0))
    builder.write_int(role.get('bkMpMax', 0))
    builder.write_int(role.get('petBkHp', 0))
    builder.write_int(role.get('petBkHpMax', 0))
    builder.write_int(role.get('petBkMp', 0))
    builder.write_int(role.get('petBkMpMax', 0))
    builder.write_int(role.get('honorValue', 0))
    builder.write_byte(role.get('honorLevel', 0))
    builder.write_int(role.get('freeAttrPt', 0))
    builder.write_byte(role.get('rebornTimes', 0))
    builder.write_byte(role.get('side', 0))
    builder.write_int(role.get('payMarks', 0))
    builder.write_int(role.get('charmValue', 0))
    builder.write_int(role.get('charmInt', 0))
    builder.write_byte(role.get('beliefGod', 0))
    builder.write_byte(role.get('beliefLevel', 0))
    builder.write_byte(role.get('armoryLevel', 0))
    builder.write_varint(0)
    builder.write_int(role.get('armoryExp', 0))
    builder.write_short(role.get('maxLevel', 999))
    builder.write_varint(0)
    builder.write_int(role.get('dragonLevel', 0))
    builder.write_int(role.get('dragonExp', 0))
    builder.write_varint(role.get('dragonUpChanceNum', 0))
    builder.write_bool(role.get('isAntoHp', False))
    builder.write_bool(role.get('isAntoMp', False))
    builder.write_int(role.get('consecutiveLoginDays', 1))
    builder.write_string(role.get('boonItemCode', ''))
    builder.write_int(role.get('stirpLevel', 0))
    builder.write_unsigned_byte(role.get('potentialLevel', 0))
    builder.write_int(role.get('potentialValue', 0))
    builder.write_byte(role.get('refineLevel', 0))
    builder.write_byte(role.get('lightLevel', 0))
    builder.write_byte(role.get('boneLevel', 0))
    builder.write_unsigned_byte(role.get('constellation', 0))
    builder.write_unsigned_byte(role.get('constellationLevel', 0))
    builder.write_int(role.get('constellationTaskId', 0))
    builder.write_unsigned_byte(role.get('luckLevel', 0))
    builder.write_unsigned_byte(role.get('hartLevel', 0))
    builder.write_unsigned_byte(role.get('gameTimes', 0))
    builder.write_short(role.get('arenaIntegral', 0))
    builder.write_int(role.get('towerValue', 0))
    builder.write_varint(0)
    builder.write_string(time.strftime('%Y-%m-%d %H:%M:%S'))
    builder.write_string(role.get('modelCode', ''))

def write_remote_player_info(builder: PacketBuilder, role: Dict):
    def _write_raw(b):
        b.write_string(role.get('name', ''))
        b.write_byte(int(role.get('jobCode', 1)))
        b.write_byte(int(role.get('sex', 0)))
        b.write_short(int(role.get('level', 1)))
        b.write_unsigned_short(int(role.get('headIconIndex', 0)))
        b.write_unsigned_byte(int(role.get('hairStyleIndex', 0)))
        
        b.write_bool(bool(role.get('isGM', False)))
        b.write_byte(int(role.get('vipLevel', 0)))
        b.write_short(int(role.get('walkSpeed', 200)))
        b.write_string(role.get('mapId', 'a1'))
        
        # position (MapPoint)
        def write_pos(bp):
            bp.write_unsigned_short(int(role.get('posX', 1120)))
            bp.write_unsigned_short(int(role.get('posY', 2080)))
        write_transportable_object(b, write_pos)
        
        # pathArrayReversed (array of MapPoint)
        b.write_varint(0)
        # buffs
        b.write_varint(0)
def write_mate_relation_info(builder: PacketBuilder, mate: Dict = None):
    """Serializa MateRelationInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_mate_relation_info_raw, mate)

def _write_buff_info_raw(builder: PacketBuilder, buff: Dict):
    """
    Serializa BuffInfo (sem prefixo):
    ["buffId:ushort","durationInSec:vint"]
    """
    builder.write_unsigned_short(int(buff.get('buffId', 0) or 0))
    builder.write_varint(int(float(buff.get('durationInSec', 0) or 0)))

def write_buff_info(builder: PacketBuilder, buff: Dict):
    """Serializa BuffInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_buff_info_raw, buff)

def _write_monster_info_raw(builder: PacketBuilder, monster):
    """
    Serializa MonsterInfo (sem prefixo):
    ["ownerPlayerId:string","id:string","monsterCode:string","level:short","x:short","y:short",
     "pathArrayReversed:array(MapPoint)","walkSpeed:short","hpPercent:byte","isBoss:boolean",
     "prefixArray:array(string)","buffArray:array(BuffInfo)"]
    """
    builder.write_string("") # ownerPlayerId
    builder.write_string(monster.instance_id) # id
    builder.write_string(monster.code) # monsterCode
    builder.write_short(monster.level) # level
    builder.write_short(monster.x) # x
    builder.write_short(monster.y) # y
    builder.write_varint(0) # pathArrayReversed (empty)
    builder.write_short(monster.walk_speed) # walkSpeed
    builder.write_byte(monster.get_hp_percent()) # hpPercent
    builder.write_bool(monster.is_boss) # isBoss
    builder.write_varint(0) # prefixArray (empty)
    builder.write_varint(0) # buffArray (empty)

def write_monster_info(builder: PacketBuilder, monster):
    """Serializa MonsterInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_monster_info_raw, monster)

def _write_local_player_farm_info_raw(builder: PacketBuilder, farm: Dict = None):
    """
    Serializa LocalPlayerFarmInfo (sem prefixo):
    ["mapId:string","farmId:string","templetCode:string","name:string",
     "ownerId:string","currentLevel:byte","farmExp:int","styleCode:string"]
    """
    farm = farm or {}
    builder.write_string(farm.get('mapId', ''))
    builder.write_string(farm.get('farmId', ''))
    builder.write_string(farm.get('templetCode', ''))
    builder.write_string(farm.get('name', ''))
    builder.write_string(farm.get('ownerId', ''))
    builder.write_byte(farm.get('currentLevel', 1))
    builder.write_int(farm.get('farmExp', 0))
    builder.write_string(farm.get('styleCode', ''))

def write_local_player_farm_info(builder: PacketBuilder, farm: Dict = None):
    """Serializa LocalPlayerFarmInfo COM prefixo de tamanho"""
    write_transportable_object(builder, _write_local_player_farm_info_raw, farm)

def _write_local_player_info_raw(builder: PacketBuilder, role: Dict, attrs: Dict = None):
    """
    Serializa LocalPlayerInfo completo (sem prefixo) (RoleBaseInfo + LocalPlayerInfo fields)
    
    RoleBaseInfo: ["name:string","jobCode:byte","sex:byte","level:short","headIconIndex:ushort","hairStyleIndex:ubyte"]
    
    LocalPlayerInfo adiciona muitos campos!
    """
    start_pos = len(builder.get_bytes())
    
    builder.write_string(role.get('name', ''))
    builder.write_byte(role.get('jobCode', 1))
    builder.write_byte(role.get('sex', 0))
    builder.write_short(role.get('level', 1))
    builder.write_unsigned_short(role.get('headIconIndex', 0))
    builder.write_unsigned_byte(role.get('hairStyleIndex', 0))  # ubyte!
    
    rolebase_end = len(builder.get_bytes())
    print(f"[DEBUG] RoleBaseInfo: {builder.get_bytes()[start_pos:rolebase_end].hex()}")
    
    builder.write_bool(role.get('isGM', False))
    builder.write_byte(role.get('vipLevel', 0))
    builder.write_string(role.get('mapId', 'a1'))
    
    pre_position = len(builder.get_bytes())
    print(f"[DEBUG] até mapId: {builder.get_bytes()[rolebase_end:pre_position].hex()}")
    
    write_map_point(builder, role.get('posX', 900), role.get('posY', 700))
    builder.write_varint(0)
    builder.write_varint(0)
    builder.write_string(role.get('rideCode', ''))
    builder.write_string(role.get('rideMasterPlayerId', ''))
    builder.write_varint(0)
    builder.write_short(role.get('titleIndex', 0))
    builder.write_short(role.get('kitTitleIndex', 0))
    builder.write_bool(role.get('isDead', False))
    builder.write_bool(role.get('isSitting', False))
    builder.write_double(float(role.get('exp', 0)))
    write_role_attributes(builder, attrs)
    builder.write_int(role.get('statusFlags', 0))
    builder.write_double(float(role.get('gold', 0)))
    builder.write_int(role.get('money', 0))
    builder.write_int(role.get('coin', 0))
    builder.write_int(role.get('vipExp', 0))
    builder.write_byte(role.get('lifeJob', 0))
    builder.write_byte(role.get('lifeLevel', 0))
    builder.write_int(role.get('lifeExp', 0))
    farm_skill_levels = role.get('farmSkillLevelArray', [0, 0, 0, 0])
    builder.write_varint(len(farm_skill_levels))
    for lv in farm_skill_levels:
        builder.write_byte(lv)
    farm_skill_exps = role.get('farmSkillExpArray', [0, 0, 0, 0])
    builder.write_varint(len(farm_skill_exps))
    for exp in farm_skill_exps:
        builder.write_int(exp)
    write_local_player_farm_info(builder, role.get('mainFarm'))
    builder.write_varint(0)
    builder.write_byte(role.get('pkMode', 0))
    builder.write_byte(role.get('pkValue', 0))
    builder.write_byte(role.get('lineIndex', 0))
    write_mate_relation_info(builder, role.get('mateRelationInfo'))
    write_dynamic_vars(builder)
    builder.write_int(role.get('bkHp', 0))
    builder.write_int(role.get('bkHpMax', 0))
    builder.write_int(role.get('bkMp', 0))
    builder.write_int(role.get('bkMpMax', 0))
    builder.write_int(role.get('petBkHp', 0))
    builder.write_int(role.get('petBkHpMax', 0))
    builder.write_int(role.get('petBkMp', 0))
    builder.write_int(role.get('petBkMpMax', 0))
    builder.write_int(role.get('honorValue', 0))
    builder.write_byte(role.get('honorLevel', 0))
    builder.write_int(role.get('freeAttrPt', 0))
    builder.write_byte(role.get('rebornTimes', 0))
    builder.write_byte(role.get('side', 0))
    builder.write_int(role.get('payMarks', 0))
    builder.write_int(role.get('charmValue', 0))
    builder.write_int(role.get('charmInt', 0))
    builder.write_byte(role.get('beliefGod', 0))
    builder.write_byte(role.get('beliefLevel', 0))
    builder.write_byte(role.get('armoryLevel', 0))
    builder.write_varint(0)
    builder.write_int(role.get('armoryExp', 0))
    builder.write_short(role.get('maxLevel', 999))
    builder.write_varint(0)
    builder.write_int(role.get('dragonLevel', 0))
    builder.write_int(role.get('dragonExp', 0))
    builder.write_varint(role.get('dragonUpChanceNum', 0))
    builder.write_bool(role.get('isAntoHp', False))
    builder.write_bool(role.get('isAntoMp', False))
    builder.write_int(role.get('consecutiveLoginDays', 1))
    builder.write_string(role.get('boonItemCode', ''))
    builder.write_int(role.get('stirpLevel', 0))
    builder.write_unsigned_byte(role.get('potentialLevel', 0))
    builder.write_int(role.get('potentialValue', 0))
    builder.write_byte(role.get('refineLevel', 0))
    builder.write_byte(role.get('lightLevel', 0))
    builder.write_byte(role.get('boneLevel', 0))
    builder.write_unsigned_byte(role.get('constellation', 0))
    builder.write_unsigned_byte(role.get('constellationLevel', 0))
    builder.write_int(role.get('constellationTaskId', 0))
    builder.write_unsigned_byte(role.get('luckLevel', 0))
    builder.write_unsigned_byte(role.get('hartLevel', 0))
    builder.write_unsigned_byte(role.get('gameTimes', 0))
    builder.write_short(role.get('arenaIntegral', 0))
    builder.write_int(role.get('towerValue', 0))
    builder.write_varint(0)
    builder.write_string(time.strftime('%Y-%m-%d %H:%M:%S'))
    builder.write_string(role.get('modelCode', ''))

def write_remote_player_info(builder: PacketBuilder, role: Dict):
    def _write_raw(b):
        b.write_string(role.get('name', ''))
        b.write_byte(int(role.get('jobCode', 1)))
        b.write_byte(int(role.get('sex', 0)))
        b.write_short(int(role.get('level', 1)))
        b.write_unsigned_short(int(role.get('headIconIndex', 0)))
        b.write_unsigned_byte(int(role.get('hairStyleIndex', 0)))
        
        b.write_bool(bool(role.get('isGM', False)))
        b.write_byte(int(role.get('vipLevel', 0)))
        b.write_short(int(role.get('walkSpeed', 200)))
        b.write_string(role.get('mapId', 'a1'))
        
        # position (MapPoint)
        def write_pos(bp):
            bp.write_unsigned_short(int(role.get('posX', 1120)))
            bp.write_unsigned_short(int(role.get('posY', 2080)))
        write_transportable_object(b, write_pos)
        
        # pathArrayReversed (array of MapPoint)
        b.write_varint(0)
        # buffs
        b.write_varint(0)
        equipment_models = role.get('equipmentModels', {}) or {}
        b.write_varint(len(equipment_models))
        for slot, model_code in equipment_models.items():
            b.write_byte(int(slot))
            b.write_string(model_code or '')
            
        b.write_string(role.get('rideCode', ''))
        b.write_string(role.get('rideMasterPlayerId', ''))
        # rideGuestPlayerIds
        b.write_varint(0)
        
        b.write_short(int(role.get('titleIndex', 0)))
        b.write_string(role.get('teamName', ''))
        b.write_bool(bool(role.get('isTeamLeader', False)))
        b.write_bool(bool(role.get('isDead', False)))
        b.write_bool(bool(role.get('isSitting', False)))
        b.write_string(role.get('familyName', ''))
        b.write_unsigned_byte(int(role.get('postLevel', 0)))
        b.write_string(role.get('postName', ''))
        b.write_byte(int(role.get('pkMode', 0)))
        b.write_byte(int(role.get('pkValue', 0)))
        b.write_int(int(role.get('statusFlags', 0)))
        b.write_string(role.get('mateName', ''))
        b.write_byte(int(role.get('mateRelation', 0)))
        
        # pet, genie, devil, animal
        b.write_short(0)
        b.write_short(0)
        b.write_short(0)
        b.write_short(0)
        
        b.write_bool(bool(role.get('isBooth', False)))
        b.write_string(role.get('boothTitle', ''))
        b.write_byte(int(role.get('honorLevel', 0)))
        b.write_byte(int(role.get('rebornTimes', 0)))
        b.write_byte(int(role.get('side', 0)))
        
        b.write_bool(bool(role.get('isBless', False)))
        b.write_string(role.get('blessCode', ''))
        b.write_byte(int(role.get('blessLevel', 0)))
        b.write_int(int(role.get('dragonLevel', 0)))
        b.write_string(role.get('modelCode', ''))
        b.write_bool(bool(role.get('isShowRide', bool(role.get('rideCode', '')))))
        b.write_string(role.get('rideCode', '')) # rideModel
        
    write_transportable_object(builder, _write_raw)

def write_local_player_info(builder: PacketBuilder, role: Dict, attrs: Dict = None):
    """Serializa LocalPlayerInfo COM prefixo de tamanho"""
    before = len(builder.get_bytes())
    write_transportable_object(builder, _write_local_player_info_raw, role, attrs)
    after = len(builder.get_bytes())
    data = builder.get_bytes()[before:after]
    size_prefix = int.from_bytes(data[:2], 'big')
    print(f"[DEBUG] LocalPlayerInfo: total={len(data)} bytes, size_prefix={size_prefix}")
    print(f"[DEBUG] Primeiros 50 bytes: {data[:50].hex()}")

class WorldSession:
    
    def __init__(self, client_socket: socket.socket, address: tuple, server: 'WorldServer'):
        self.socket = client_socket
        self.address = address
        self.server = server
        self.session_id: Optional[str] = None
        self.account_id: Optional[str] = None
        self.selected_role: Optional[Dict] = None
        self.player_data: Optional[Dict] = None
        self.connected = True
    
    @property
    def role_name(self) -> str:
        if self.player_data:
            return self.player_data.get('name', '')
        if self.selected_role:
            return self.selected_role.get('name', '')
        return ''

    def _send_player_attributes(self):
        if not self.player_data:
            return
        try:
            from attribute_calculator import AttributeCalculator
            calc = AttributeCalculator(self.server._get_db())
            equip_attrs = calc.calculate_equipment_attributes(self.role_name)
            attrs, basic = calc.build_player_attributes(self.player_data, equip_attrs)
            
            # Update player_data with calculated stats (HP, HPMax, MP, MPMax, PATK, MATK, etc.)
            # but preserve base stats (strength, wisdom, agility, vitality) to avoid inflation.
            for k, v in attrs.items():
                if k not in ("strength", "wisdom", "agility", "vitality"):
                    self.player_data[k] = v
                    
            # Send attributes change notification (cmd 578)
            builder = PacketBuilder()
            write_role_attributes(builder, attrs)
            self.send_packet(builder.build(PlayerCommandCode.PLAYER_ATTRIBUTES_CHANGE_NOTIFY))
            self.log(f"Sent PLAYER_ATTRIBUTES_CHANGE_NOTIFY (578) for {self.role_name}")
        except Exception as e:
            self.log(f"Error recalculating and sending player attributes: {e}")
            import traceback
            traceback.print_exc()

    def log(self, message: str):
        log("WORLD_SESSION", message, session=self, address=str(self.address))
    
    def send_packet(self, packet: bytes):
        """Envia pacote ao cliente"""
        if not self.connected:
            return False
        try:
            self.socket.sendall(packet)
            smart_logger.count("packets_sent")
            smart_logger.count("bytes_sent", len(packet))
            self.log(f"Enviado {len(packet)} bytes")
            return True
        except Exception as e:
            self.connected = False
            smart_logger.exception("WORLD_SESSION.send_packet", e, session=self)
            self.log(f"Erro ao enviar: {e}")
            return False

    def handle_enter_world(self, reader: PacketReader):
        """
        Entrar no mundo/jogo (cmd 513)
        
        PlayerEnterWorldAnswer campos:
        - role:LocalPlayerInfo
        - clientConfig:string
        - vars:DynamicVars
        - killedMonsters:DynamicVars
        - taskRecorder:TaskRecorder
        - friendList:array(FriendInfo)
        - isWaiting:boolean
        - waitingTotal:short
        - waitingIndex:short
        - failureReason:string
        - sysVars:DynamicVars
        """
        try:
            self.log(f"=== PlayerEnterWorldRequest (cmd 513) ===")
            
            if not self.selected_role:
                self.log("❌ Nenhum personagem selecionado!")
                builder = PacketBuilder()
                self._write_enter_world_error(builder, "Nenhum personagem selecionado")
                self.send_packet(builder.build(PlayerCommandCode.PLAYER_ENTER_WORLD_ANSWER))
                return
            
            role_name = self.selected_role.get('name', '')
            self.log(f"Entrando com personagem: {role_name}")
            
            player_data = None
            if self.server._db_available:
                self.log(f"🔍 Banco disponível, carregando dados de {role_name}...")
                try:
                    from player_data_manager import PlayerDataManager
                    pdm = PlayerDataManager(self.server._get_db())
                    player_data = pdm.load_player_full_data(role_name)
                    if player_data:
                        self.log(f"✅ Dados carregados: posX={player_data.get('posX')}, posY={player_data.get('posY')}, mapId={player_data.get('mapId')}")
                        # Grant boon item if specified (for starter items, healing mission, etc.)
                        boon_item_code = player_data.get('boonItemCode', '')
                        if boon_item_code and self.server._db_available:
                            self.log(f"🎁 Granting boon item: {boon_item_code} for {role_name}")
                            from inventory_manager import InventoryManager
                            inv_mgr = InventoryManager(self.server._get_db())
                            # Add 1 of the boon item to the player's main bag (bag 1)
                            result = inv_mgr.add_item(role_name, 1, boon_item_code, 1)
                            if result['success']:
                                self.log(f"✅ Boon item {boon_item_code} granted successfully")
                                # Clear the boonItemCode from database so it's only granted once
                                try:
                                    role_id = player_data.get('roleId')
                                    if role_id:
                                        db = self.server._get_db()
                                        db.execute_query("UPDATE TB_Role SET BoonItemCode = '' WHERE RoleID = ?", (role_id,))
                                        self.log(f"🗑️ Cleared boonItemCode from DB for {role_name}")
                                except Exception as clear_err:
                                    self.log(f"⚠️ Failed to clear boonItemCode: {clear_err}")
                            else:
                                self.log(f"❌ Failed to grant boon item {boon_item_code}: {result.get('error', 'Unknown error')}")
                except Exception as e:
                    self.log(f"⚠️ Erro ao carregar do banco: {e}")
            
            if not player_data:
                self.log("⚠️ Usando dados básicos (banco indisponível)")
                player_data = {
                    'roleId': self.selected_role.get('id', 0),
                    'name': role_name,
                    'jobCode': max(1, int(self.selected_role.get('jobCode') or 1)),
                    'sex': self.selected_role.get('sex', 0),
                    'level': self.selected_role.get('level', 1),
                    'headIconIndex': self.selected_role.get('headIconIndex', 0),
                    'hairStyleIndex': self.selected_role.get('hairStyleIndex', 0),
                    'mapId': self.selected_role.get('mapId') or 'a1',
                    'posX': 1120,
                    'posY': 2080,
                    'hp': 100,
                    'hpMax': 100,
                    'mp': 100,
                    'mpMax': 100,
                    'petBkHp': 0,
                    'petBkHpMax': 0,
                    'petBkMp': 0,
                    'petBkMpMax': 0,
                    'walkSpeed': 200,
                    'gold': 1000,
                    'money': 100,
                    'vars': {'bool': {}, 'int': {}, 'str': {}},
                    'killedMonsters': {'bool': {}, 'int': {}, 'str': {}},
                    'taskRecorder': {
                        'doingAllocators': {},
                        'doingTasks': [],
                        'doneTasks': {}
                    },
                    'friendList': [],
                    'sysVars': {'bool': {}, 'int': {}, 'str': {}},
                }
            
            self.player_data = player_data
            self.server.sessions[role_name] = self
            
            # Recalculate attributes on enter world to ensure stats/equipment are applied
            attrs = player_data
            try:
                from attribute_calculator import AttributeCalculator
                calc = AttributeCalculator(self.server._get_db())
                equip_attrs = calc.calculate_equipment_attributes(role_name)
                attrs, basic = calc.build_player_attributes(self.player_data, equip_attrs)
                for k, v in attrs.items():
                    if k not in ("strength", "wisdom", "agility", "vitality"):
                        self.player_data[k] = v
            except Exception as attr_err:
                self.log(f"⚠️ Erro ao calcular atributos iniciais: {attr_err}")
                attrs = player_data
                
            self.server.announce_player_entered_map(self)
            
            builder = PacketBuilder()
            
            write_local_player_info(builder, player_data, attrs)
            
            builder.write_string(player_data.get('clientConfig', ''))
            
            vars_data = player_data.get('vars', {})
            write_dynamic_vars(builder, 
                vars_data.get('bool', {}), 
                vars_data.get('int', {}), 
                vars_data.get('str', {}))
                
            killed = player_data.get('killedMonsters', {})
            write_dynamic_vars(builder,
                killed.get('bool', {}),
                killed.get('int', {}),
                killed.get('str', {}))
            
            task_rec = player_data.get('taskRecorder', {})
            write_task_recorder(builder,
                task_rec.get('doingAllocators', {}),
                task_rec.get('doingTasks', []),
                task_rec.get('doneTasks', {}))
            
            friends = player_data.get('friendList', [])
            builder.write_varint(len(friends))
            for friend in friends:
                write_friend_info(builder, friend)
            
            builder.write_bool(False)
            
            builder.write_short(0)
            
            builder.write_short(0)
            
            builder.write_string("")
            
            sys_vars = player_data.get('sysVars', {})
            write_dynamic_vars(builder,
                sys_vars.get('bool', {}),
                sys_vars.get('int', {}),
                sys_vars.get('str', {}))
            
            packet = builder.build(PlayerCommandCode.PLAYER_ENTER_WORLD_ANSWER)
            self.log(f"📦 Pacote 514: {len(packet)} bytes total, payload hex (primeiros 100): {packet[:100].hex()}")
            self.send_packet(packet)
            self.log(f"✅ PlayerEnterWorldAnswer enviado!")
            
            self._auto_send_map_data()
            self._send_empty_pet_check()
            # Do not send command 658 during EnterWorld. The original client
            # handles it by refreshing fate/family UI objects without null
            # checks; those objects are still being constructed at this point
            map_id = self.player_data.get('mapId', 'a1')
            self._send_player_view_map_answer(map_id)
            self._send_enter_map_answer()
            # Trigger auto-receive for available quests (e.g., quest 4999 for new chars)
            self._trigger_auto_receive_quests()
        except Exception as e:
            self.log(f"Erro ao enviar dados do mapa automaticamente: {e}")
    
    def handle_view_map(self, reader: PacketReader):
        """
        Ver mapa (cmd 521) - Enviado pelo cliente após carregar recursos do mapa
        """
        try:
            self.log(f"=== PlayerViewMapRequest (cmd 521) ===")
            if not self.selected_role:
                self.log("❌ Nenhum personagem selecionado!")
                return
            map_id = getattr(self, 'player_data', {}).get('mapId', 'a1')
            self._send_player_view_map_answer(map_id)
            self._send_enter_map_answer()
            # Sync skills when client map load is complete and UI is ready
            self._send_learned_skills()
        except Exception as e:
            self.log(f"Erro ao processar view map: {e}")
            import traceback
            traceback.print_exc()

    def _send_learned_skills(self):
        try:
            if not self.player_data:
                return
            # Basic attack is implicit in the client. Sending it as a learned
            # job skill consumes a skill point and blocks the first upgrade.
            skills = {
                str(code): int(level)
                for code, level in self.player_data.get('learnedSkills', {}).items()
                if code != 'basic'
            }

            # Only job skills are ready during initial UI construction. Empty
            # family/fate/bless/book notifications make the Flash client call
            # UI instances that may still be null.
            builder = PacketBuilder()
            builder.write_byte(0)
            builder.write_varint(len(skills))
            for skill_code, level in skills.items():
                builder.write_string(skill_code)
                builder.write_byte(level)
            self.send_packet(builder.build(658))
            self.log(f"Synced {len(skills)} learned job skills to client")
        except Exception as e:
            self.log(f"Error syncing learned skills: {e}")
    def _send_empty_pet_check(self):
        """Force the client to clear any cached/summoned pet state."""
        try:
            builder = PacketBuilder()
            builder.write_bool(True)   # isUsing=true makes the client assign petFullInfo.
            builder.write_short(0)     # pet=null transportable object.
            self.send_packet(builder.build(5377))
            self.log("✅ PetCheckNotify vazio enviado")
        except Exception as e:
            self.log(f"Error sending empty pet check: {e}")

    def _trigger_auto_receive_quests(self):
        """Trigger auto-receive for available quests (e.g., quest 4999 for new chars).
        Uses the TaskHandler via the handler registry."""
        try:
            from handlers.registry import get_handler_registry
            from handlers.task_handler import TaskHandler
            registry = get_handler_registry()
            # Get TaskHandler instance for this session
            handler = registry._get_handler_instance(self, TaskHandler)
            if handler:
                handler._auto_receive_available_tasks()
                self.log("✅ Auto-receive quests triggered")
        except Exception as e:
            self.log(f"Error triggering auto-receive quests: {e}")

    def _send_enter_map_answer(self):
        if not self.player_data:
            return
        
        map_id = self.player_data.get('mapId', 'a1')
        pos_x = self.player_data.get('posX', 1024)
        pos_y = self.player_data.get('posY', 2048)
        line_index = self.player_data.get('lineIndex', 0)
        
        builder = PacketBuilder()
        builder.write_string(map_id)
        write_map_point(builder, pos_x, pos_y)
        builder.write_string("")
        builder.write_byte(line_index)
        
        self.send_packet(builder.build(518))
        self.log(f"✅ PlayerEnterMapAnswer enviado: map={map_id}, pos=({pos_x}, {pos_y})")
        
        self._send_all_bag_capacities()

    def _send_player_view_map_answer(self, map_id: str):
        """Envia PlayerViewMapAnswer (cmd 522) com monstros, itens, armadilhas, fazendas e dynamicVars."""
        if not self.player_data:
            return
            
        map_instance = self.server.map_manager.get_map(map_id)
        monsters = map_instance.get_active_monsters() if map_instance else []
        items = list(map_instance.items.values()) if map_instance and hasattr(map_instance, 'items') else []
        harvests = map_harvests_from_definition(map_id, map_instance.map_def if map_instance else {})
        
        builder = PacketBuilder()
        builder.write_string(map_id)
        builder.write_varint(0)  # remotePlayers
        
        # monsters
        builder.write_varint(len(monsters))
        for m in monsters:
            write_monster_info(builder, m)
            
        builder.write_varint(0)  # traps
        
        # items
        builder.write_varint(len(items))
        for item in items:
            write_map_item_info(builder, item)
            
        builder.write_varint(0)  # farmsInUse
        builder.write_varint(0)  # farmBuildings
        builder.write_varint(len(harvests))  # farmHarvests
        for harvest in harvests:
            write_farm_harvest_info(builder, harvest)
        write_dynamic_vars(builder)
        
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_VIEW_MAP_ANSWER))
        self.log(
            f"✅ PlayerViewMapAnswer enviado para map={map_id} com "
            f"{len(monsters)} monstros, {len(items)} itens, {len(harvests)} harvests"
        )

    def _auto_send_map_data(self):
        """Envia dados do mapa automaticamente ao entrar no mundo."""
        try:
            if not self.player_data:
                return
            map_id = self.player_data.get('mapId', 'a1')
            self._send_player_view_map_answer(map_id)
            self._send_enter_map_answer()
        except Exception as e:
            self.log(f"Erro ao enviar dados do mapa automaticamente: {e}")
            import traceback
            traceback.print_exc()
    
    def _send_all_bag_capacities(self):
        bag_player = self.player_data.get('BagCapacityPlayer', 36) if self.player_data else 36
        bag_pet = self.player_data.get('BagCapacityPet', 3) if self.player_data else 3
        bag_ride = self.player_data.get('BagCapacityRide', 3) if self.player_data else 3
        
        self.log(f"📦 Capacidades: Player={bag_player}, Pet={bag_pet}, Ride={bag_ride}")
        
        self._send_bag_capacity(1, bag_player)
        self._send_bag_capacity(2, bag_pet)
        self._send_bag_capacity(3, bag_ride)
        
        self._send_all_inventory_items()
    
    def _send_all_inventory_items(self):
        if not self.selected_role:
            return
        
        role_name = self.selected_role.get('name', '')
        if not role_name:
            return
        try:
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.server._get_db())
            for bag_index in [1, 2, 3]:
                items = inv_mgr.load_inventory(role_name, bag_index)
                if items:
                    self._send_bag_check(bag_index, items)
                    self.log("Inventario bag " + str(bag_index) + " enviado")
            equip_items = inv_mgr.load_inventory(role_name, 10)
            is_use_fashion = self.player_data.get('isUseFashion', True)
            fashion_builder = PacketBuilder()
            fashion_builder.write_bool(is_use_fashion)
            self.send_packet(fashion_builder.build(4612))
            
            if equip_items:
                for equip in equip_items:
                    item_def_result = self.server._db.execute_query(
                        "SELECT * FROM TB_ItemDefinition WHERE ItemCode = ?",
                        (equip.item_code,)
                    )
                    item_def = item_def_result[0] if item_def_result else None
                    self._send_view_item_answer(equip, equip.item_id, item_def)
            
            self._send_equipment_check_notify(equip_items or [])
            self._send_player_attributes()
        except Exception as e:
            self.log("Erro no inventario: " + str(e))
            import traceback
            traceback.print_exc()

    def _send_equipment_check_notify(self, items: list, empty_equipment_slots: list = None):
        empty_equipment_slots = empty_equipment_slots or []
        total_entries = len(items) + len(empty_equipment_slots)
        builder = PacketBuilder()
        builder.write_varint(total_entries)
        for empty_slot in empty_equipment_slots:
            item_builder = PacketBuilder()
            item_builder.write_unsigned_short(empty_slot)
            item_builder.write_unsigned_short(0)
            item_data = item_builder.get_bytes()
            builder.write_unsigned_short(len(item_data))
            builder.write_bytes(item_data)
        for item in items:
            item_builder = PacketBuilder()
            slot_index = item.slot_index if hasattr(item, 'slot_index') else item.get('SlotIndex', 0)
            item_builder.write_unsigned_short(slot_index)
            brief_builder = PacketBuilder()
            item_id = item.item_id if hasattr(item, 'item_id') else item.get('ItemId', '')
            brief_builder.write_string(item_id)
            item_code = item.item_code if hasattr(item, 'item_code') else item.get('ItemCode', '')
            brief_builder.write_string(item_code)
            item_count = item.item_count if hasattr(item, 'item_count') else item.get('ItemCount', 1)
            brief_builder.write_unsigned_byte(item_count)
            brief_data = brief_builder.get_bytes()
            item_builder.write_unsigned_short(len(brief_data))
            item_builder.write_bytes(brief_data)
            item_data = item_builder.get_bytes()
            builder.write_unsigned_short(len(item_data))
            builder.write_bytes(item_data)
        self.send_packet(builder.build(4609))
        self.log(f"✅ PlayerEquipmentCheckNotify enviado: {len(items)} equipados, {len(empty_equipment_slots)} vazios (NULL)")

    def _send_initial_equipment_models(self, role_name: str):
        equip_models = self.player_data.get('equipmentModels', {}) if self.player_data else {}
        if not equip_models:
            return
        builder = PacketBuilder()
        builder.write_string(role_name)
        builder.write_varint(len(equip_models))
        for slot, model_code in equip_models.items():
            builder.write_byte(int(slot))
            builder.write_string(model_code or '')
        self.send_packet(builder.build(865))
        self.log(f"✅ RemoteEquipmentModelCheckNotify enviado: {equip_models}")
    
    def _send_bag_capacity(self, bag_index: int, capacity: int):
        """
        Envia PlayerBagCapacityChangeNotify (cmd 5122) para desbloquear slots do inventário.
        
        Args:
            bag_index: Tipo de bag (1=PLAYER_MAIN_BAG, 2=PET_BAG, 3=RIDE_BAG, etc)
            capacity: Número de slots desbloqueados
        """
        builder = PacketBuilder()
        
        builder.write_byte(bag_index)
        builder.write_unsigned_byte(capacity)
        
        self.send_packet(builder.build(5122))
        self.log(f"✅ PlayerBagCapacityChangeNotify enviado: bagIndex={bag_index}, capacity={capacity}")
    
    
    def handle_bag_check(self, reader: PacketReader):
        """
        Sincronizar inventário (usado ao abrir bag ou entrar no jogo)
        Envia PlayerBagCheckNotify (cmd 5121)
        """
        try:
            if not self.player_data:
                return
            
            role_name = self.player_data.get('name', '')
            
            from inventory_manager import InventoryManager
            inv_mgr = InventoryManager(self.server._get_db())
            
            for bag_index in [1, 2, 3]:
                items = inv_mgr.load_inventory(role_name, bag_index)
                if items:
                    self._send_bag_check(bag_index, items)
                    
        except Exception as e:
            self.log(f"Erro ao carregar inventário: {e}")
            import traceback
            traceback.print_exc()
    
    def _send_bag_check(self, bag_index: int, items: list, empty_slots: list = None):
        """
        Envia PlayerBagCheckNotify (cmd 5121)
        Campos: bagIndex:byte, changedItems:array(BagItemInfo)
        
        BagItemInfo: itemIndex:ubyte, gameItem:GameItemBriefInfo
        GameItemBriefInfo: itemId:string, itemCode:string, itemCount:ubyte
        
        Args:
            bag_index: Índice da bag
            items: Lista de itens existentes
            empty_slots: Lista de slots que ficaram vazios (opcional)
        """
        builder = PacketBuilder()
        
        builder.write_byte(bag_index)
        
        empty_slots = empty_slots or []
        total_entries = len(items) + len(empty_slots)
        
        builder.write_varint(total_entries)
        
        for slot_index in empty_slots:
            item_builder = PacketBuilder()
            
            item_builder.write_unsigned_byte(slot_index)
            
            game_item_builder = PacketBuilder()
            game_item_builder.write_string("")  # itemId vazio
            game_item_builder.write_string("")  # itemCode vazio
            game_item_builder.write_unsigned_byte(0)
            
            game_item_data = game_item_builder.get_bytes()
            item_builder.write_short(len(game_item_data))
            item_builder.write_bytes(game_item_data)
            
            item_data = item_builder.get_bytes()
            builder.write_short(len(item_data))
            builder.write_bytes(item_data)
        
        for item in items:
            item_builder = PacketBuilder()
            
            item_builder.write_unsigned_byte(item.slot_index)
            
            game_item_builder = PacketBuilder()
            game_item_builder.write_string(item.item_id)
            game_item_builder.write_string(item.item_code)
            game_item_builder.write_unsigned_byte(min(item.item_count, 255))
            
            game_item_data = game_item_builder.get_bytes()
            item_builder.write_short(len(game_item_data))
            item_builder.write_bytes(game_item_data)
            
            item_data = item_builder.get_bytes()
            builder.write_short(len(item_data))
            builder.write_bytes(item_data)
        
        self.send_packet(builder.build(BagCommandCode.PLAYER_BAG_CHECK_NOTIFY))
        self.log(f"✅ BagCheckNotify enviado: bag={bag_index}, items={len(items)}, empty_slots={len(empty_slots)}")

    def _send_item_added_notify(self, items_added: list):
        """
        Envia PlayerItemAddedNotify (cmd 5131) - Notificação de item obtido
        Mostra: efeito flutuante do item acima do personagem + mensagem no chat
        
        Campos: itemsAdded:array(GameItemBriefInfo)
        GameItemBriefInfo: itemId:string, itemCode:string, itemCount:ubyte
        
        Args:
            items_added: Lista de dicts com: 
                - item_id: ID único do item (ou string vazia se não tiver)
                - item_code: Código do item (ex: "bq200d")  
                - count: Quantidade
        """
        if not items_added:
            return
            
        builder = PacketBuilder()
        
        builder.write_varint(len(items_added))
        
        for item in items_added:
            item_id = str(item.get('item_id', ''))
            item_code = str(item.get('item_code', ''))
            count = min(item.get('count', 1), 255)  # ubyte max = 255
            
            item_builder = PacketBuilder()
            item_builder.write_string(item_id)
            item_builder.write_string(item_code)
            item_builder.write_unsigned_byte(count)
            
            item_data = item_builder.get_bytes()
            builder.write_short(len(item_data))
            builder.write_bytes(item_data)
        
        self.send_packet(builder.build(BagCommandCode.PLAYER_ITEM_ADDED_NOTIFY))
        
        item_names = [f"{i.get('item_code')} x{i.get('count', 1)}" for i in items_added]
        self.log(f"✨ ItemAddedNotify enviado: {', '.join(item_names)}")
    

    def _send_view_item_answer(self, item, item_id: str, item_def: dict = None):
        """
        Envia PlayerViewItemAnswer (cmd 5134)
        
        Campos: ["itemId:string","item:com.sunweb.game.rpg.gameItem.GameItemFullInfo"]
        
        GameItemFullInfo:
        ["itemId:string","itemCode:string","expiredTimeLeftInHour:int","canTrade:boolean",
         "equipmentInfo:...","rideInfo:...","expendableInfo:...","petInfo:...","genieInfo:...",
         "elementInfo:...","devilInfo:..."]
        
        item pode ser ItemInfo (dataclass) ou None
        """
        builder = PacketBuilder()
        
        builder.write_string(item_id)
        
        if item is None:
            builder.write_short(0)
        else:
            item_builder = PacketBuilder()
            
            item_code = item.item_code if hasattr(item, 'item_code') else ''
            is_bound = item.is_bound if hasattr(item, 'is_bound') else False
            
            can_trade = not is_bound
            
            item_builder.write_string(item_id)
            
            item_builder.write_string(item_code)
            
            item_builder.write_int(2147483647)
            
            item_builder.write_bool(can_trade)
            
            item_type = item_def.get('ItemType', 0) if item_def else 0
            if item_type == 4:
                self._write_equipment_info(item_builder, item, item_def)
            else:
                item_builder.write_short(0)
            
            item_builder.write_short(0)
            
            if item_type == 1:
                self._write_expendable_info(item_builder, item, item_def)
            else:
                item_builder.write_short(0)
            
            item_builder.write_short(0)
            
            item_builder.write_short(0)
            
            item_builder.write_short(0)
            
            item_builder.write_short(0)
            
            item_data = item_builder.get_bytes()
            builder.write_short(len(item_data))
            builder.write_bytes(item_data)
        
        self.send_packet(builder.build(BagCommandCode.PLAYER_VIEW_ITEM_ANSWER))
        self.log(f"📤 ViewItemAnswer: id={item_id}, found={item is not None}")
    
    def _write_expendable_info(self, builder: PacketBuilder, item, item_def: dict):
        """
        Escreve ItemExpendableInfo
        Campos: ["usePlace:string"]
        """
        exp_builder = PacketBuilder()
        
        exp_builder.write_string("")
        
        exp_data = exp_builder.get_bytes()
        builder.write_short(len(exp_data))
        builder.write_bytes(exp_data)
    
    def _write_equipment_info(self, builder: PacketBuilder, item, item_def: dict):
        """
        Escreve ItemEquipmentInfo
        Campos complexos - enviar valores básicos
        """
        eq_builder = PacketBuilder()
        item_id = getattr(item, "item_id", "")
        artifact_state = {}
        kind_grow_state = {}
        try:
            if item_id and self.player_data:
                db = self.server._get_db()
                rows = db.execute_query(
                    "SELECT * FROM TB_RoleArtifactState WHERE RoleName=? AND EquipmentItemId=?",
                    (self.player_data.get("name", ""), item_id),
                )
                artifact_state = rows[0] if rows else {}
                subtype = int(item_def.get("ItemSubType", item_def.get("SubType", 0)) or 0)
                kg_rows = db.execute_query(
                    "SELECT * FROM TB_RoleKindGrow WHERE RoleName=? AND Kind=?",
                    (self.player_data.get("name", ""), subtype),
                )
                kind_grow_state = kg_rows[0] if kg_rows else {}
        except Exception:
            artifact_state = {}
            kind_grow_state = {}
        
        eq_builder.write_bool(False)
        eq_builder.write_byte(0)
        max_durability = int(getattr(item, "max_durability", 100) or 100)
        durability = int(getattr(item, "durability", max_durability) or 0)
        eq_builder.write_short(max(0, max_durability))
        eq_builder.write_short(max(0, min(durability, max_durability)))
        eq_builder.write_bool(False)
        eq_builder.write_string("")
        is_bound = item.is_bound if hasattr(item, 'is_bound') else False
        eq_builder.write_bool(is_bound)
        eq_builder.write_byte(0)
        eq_builder.write_varint(0)
        refine_level = int(artifact_state.get("RefineLevel") or (item.enhance_level if hasattr(item, 'enhance_level') else 0) or 0)
        eq_builder.write_byte(refine_level)
        eq_builder.write_string("")
        eq_builder.write_string("")
        eq_builder.write_float(0.0)
        eq_builder.write_byte(0)
        eq_builder.write_varint(0)
        eq_builder.write_varint(0)
        eq_builder.write_byte(0)
        eq_builder.write_string("")
        eq_builder.write_string(str(artifact_state.get("LetteringWord") or ""))
        eq_builder.write_string("")
        eq_builder.write_unsigned_short(int(artifact_state.get("EquLevel") or 0))
        eq_builder.write_varint(int(artifact_state.get("EquExp") or 0))
        eq_builder.write_string("")
        eq_builder.write_unsigned_byte(0)
        eq_builder.write_unsigned_byte(0)
        eq_builder.write_unsigned_short(int(artifact_state.get("SoulLevel") or 0))
        eq_builder.write_unsigned_byte(0)
        eq_builder.write_varint(0)
        eq_builder.write_unsigned_short(0)
        eq_builder.write_string("")
        eq_builder.write_varint(0)
        eq_builder.write_varint(0)
        eq_builder.write_string("")
        eq_builder.write_unsigned_byte(int(kind_grow_state.get("Level") or 0))
        eq_builder.write_float(float(kind_grow_state.get("Level") or 0) * 0.01)
        eq_builder.write_varint(0)
        eq_builder.write_varint(0)
        eq_builder.write_unsigned_byte(0)
        
        eq_data = eq_builder.get_bytes()
        builder.write_short(len(eq_data))
        builder.write_bytes(eq_data)
    
    
    def _send_shop_buy_result(self, success: bool, error_msg: str = ""):
        """Envia resultado da compra na loja (cmd 2819)"""
        builder = PacketBuilder()
        
        builder.write_bool(success)
        builder.write_string(error_msg)
        
        self.send_packet(builder.build(ShopCommandCode.SHOP_BUY_ITEM_ANSWER))
        self.log(f"📤 ShopBuyAnswer: success={success}, error={error_msg}")
    
    def _send_shop_sell_result(self, success: bool, error_msg: str = ""):
        """Envia resultado da venda na loja (cmd 2820)"""
        builder = PacketBuilder()
        builder.write_bool(success)
        builder.write_string(error_msg)
        self.send_packet(builder.build(ShopCommandCode.SHOP_SELL_ITEM_ANSWER))
        self.log(f"📤 ShopSellAnswer: success={success}, error={error_msg}")
    
    def _update_gold_in_db(self, amount: int, is_absolute: bool = False):
        """
        Atualiza gold do jogador no banco de dados usando stored procedure.
        
        Args:
            amount: Quantidade a adicionar (positivo) ou subtrair (negativo), 
                   ou valor absoluto se is_absolute=True
            is_absolute: Se True, usa SP_UpdateGold (define valor absoluto),
                        Se False, usa SP_AddGold (adiciona/subtrai)
        
        Returns:
            Tuple[bool, int]: (sucesso, novo_gold)
        """
        if not self.player_data:
            return False, 0
            
        role_id = self.player_data.get('roleId', 0)
        if not role_id:
            self.log(f"❌ roleId não encontrado no player_data")
            return False, 0
            
        try:
            db = self.server._get_db()
            if not db:
                self.log(f"❌ DatabaseManager não disponível")
                return False, 0
            
            if is_absolute:
                sql = "DECLARE @Result INT; EXEC SP_UpdateGold @RoleID=?, @NewGold=?, @Result=@Result OUTPUT; SELECT @Result AS Result;"
                results = db.execute_query(sql, (role_id, amount))
                result = results[0]['Result'] if results else -1
                new_gold = amount
            else:
                sql = "DECLARE @NewGold BIGINT, @Result INT; EXEC SP_AddGold @RoleID=?, @Amount=?, @NewGold=@NewGold OUTPUT, @Result=@Result OUTPUT; SELECT @NewGold AS NewGold, @Result AS Result;"
                results = db.execute_query(sql, (role_id, amount))
                if results:
                    new_gold = results[0].get('NewGold', 0)
                    result = results[0].get('Result', -1)
                else:
                    new_gold = 0
                    result = -1
            
            if result == 0:
                self.log(f"💰 Gold atualizado via SP: amount={amount}, novo={new_gold}")
                return True, new_gold
            elif result == -2:
                self.log(f"❌ Gold insuficiente para operação: {amount}")
                return False, self.player_data.get('gold', 0)
            else:
                self.log(f"❌ Erro na SP de gold: result={result}")
                return False, 0
                    
        except Exception as e:
            self.log(f"❌ Erro ao atualizar gold no DB: {e}")
            import traceback
            traceback.print_exc()
            return False, 0
    
    def _send_gold_change(self, gold_changed: int = 0):
        """
        Envia notificação de mudança de gold (cmd 563)
        
        Campos esperados pelo cliente:
        - goldChanged:int - diferença (positivo = ganhou, negativo = perdeu)
        - goldCurrent:double - gold atual total
        """
        if not self.player_data:
            return
            
        gold_current = float(self.player_data.get('gold', 0))
        
        builder = PacketBuilder()
        builder.write_int(gold_changed)
        builder.write_double(gold_current)
        
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_GOLD_CHANGE_NOTIFY))
        self.log(f"📤 GoldChange: changed={gold_changed}, current={gold_current}")
    
    def _send_exp_change(self, exp_changed: int = 0):
        if not self.player_data:
            return
        exp_current = float(self.player_data.get('exp', 0))
        builder = PacketBuilder()
        builder.write_double(float(exp_changed))
        builder.write_double(exp_current)
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_EXP_CHANGE_NOTIFY))
        self.log(f"ExpChange: changed={exp_changed}, current={exp_current}")

    def _send_level_up(self, new_level: int):
        builder = PacketBuilder()
        builder.write_short(int(new_level))
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_LEVEL_UP_NOTIFY))
        self.log(f"LevelUp: newLevel={new_level}")

    def _restore_vitals_after_level_up(self):
        """Recalculate level-scaled attributes and fully restore HP/MP."""
        if not self.player_data:
            return

        old_hp = float(self.player_data.get('hp', 0))
        old_mp = int(self.player_data.get('mp', 0))
        self._send_player_attributes()

        hp_max = max(1.0, float(self.player_data.get('hpMax', 1)))
        mp_max = max(1, int(self.player_data.get('mpMax', 1)))
        self.player_data['hp'] = hp_max
        self.player_data['mp'] = mp_max

        hp_max_notify = PacketBuilder()
        hp_max_notify.write_double(hp_max)
        hp_max_notify.write_double(hp_max)
        self.send_packet(hp_max_notify.build(PlayerCommandCode.PLAYER_HPMAX_CHANGE_NOTIFY))

        hp_notify = PacketBuilder()
        hp_notify.write_double(hp_max - old_hp)
        hp_notify.write_double(hp_max)
        hp_notify.write_string("")
        hp_notify.write_bool(False)
        hp_notify.write_bool(False)
        self.send_packet(hp_notify.build(PlayerCommandCode.PLAYER_HP_CHANGE_NOTIFY))

        mp_notify = PacketBuilder()
        mp_notify.write_short(mp_max - old_mp)
        mp_notify.write_int(mp_max)
        mp_notify.write_string("")
        self.send_packet(mp_notify.build(PlayerCommandCode.PLAYER_MP_CHANGE_NOTIFY))

        self.server.broadcast_remote_hp(self, hp_max - old_hp)
        self.server.broadcast_remote_mp(self, mp_max - old_mp)
        self.log(f"Level-up vitals restored: HP={hp_max}/{hp_max}, MP={mp_max}/{mp_max}")

    def _send_ext_attr_int_change(self, attr: int, changed: int, current: int):
        builder = PacketBuilder()
        builder.write_byte(int(attr))
        builder.write_int(int(changed))
        builder.write_int(int(current))
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_EXT_ATTR_INT_CHANGE_NOTIFY))
        self.log(f"ExtAttrIntChange: attr={attr}, changed={changed}, current={current}")

    def _update_money_in_db(self, amount: int) -> tuple:
        """
        Atualiza money (cristal) do jogador no banco de dados.
        
        Args:
            amount: Quantidade a adicionar (positivo) ou subtrair (negativo)
        
        Returns:
            Tuple[bool, int]: (sucesso, novo_money)
        """
        if not self.player_data:
            return False, 0
            
        role_id = self.player_data.get('roleId', 0)
        if not role_id:
            self.log(f"❌ roleId não encontrado no player_data")
            return False, 0
            
        try:
            db = self.server._get_db()
            if not db or not self.server._db_available:
                current_money = int(self.player_data.get('money', 0))
                new_money = max(0, current_money + amount)
                self.player_data['money'] = new_money
                self.log(f"💎 [Debug Fallback] Cristal atualizado: amount={amount}, novo={new_money}")
                return True, new_money

            sql = """
                DECLARE @NewMoney BIGINT, @Result INT;
                EXEC SP_UpdateMoney @RoleID=?, @Amount=?, @NewMoney=@NewMoney OUTPUT, @Result=@Result OUTPUT;
                SELECT @NewMoney AS NewMoney, @Result AS Result;
            """
            results = db.execute_query(sql, (role_id, amount))
            
            if results:
                new_money = results[0].get('NewMoney', 0)
                result_code = results[0].get('Result', -1)
                
                if result_code == 0:
                    self.log(f"💎 Cristal atualizado via SP: amount={amount}, novo={new_money}")
                    return True, new_money
                elif result_code == -2:
                    self.log(f"❌ Cristais insuficientes: {amount}")
                    return False, self.player_data.get('money', 0)
                else:
                    self.log(f"❌ Erro na SP de money: result={result_code}")
                    return False, 0
            else:
                return False, 0
        except Exception as e:
            self.log(f"❌ Erro ao atualizar money no DB: {e}")
            current_money = int(self.player_data.get('money', 0))
            new_money = max(0, current_money + amount)
            self.player_data['money'] = new_money
            self.log(f"💎 [Exception Fallback] Cristal atualizado: amount={amount}, novo={new_money}")
            return True, new_money

    def _send_money_change(self, money_changed: int = 0):
        if not self.player_data:
            return
        money_current = int(self.player_data.get('money', 0))
        builder = PacketBuilder()
        builder.write_int(money_changed)
        builder.write_int(money_current)
        self.send_packet(builder.build(PlayerCommandCode.PLAYER_MONEY_CHANGE_NOTIFY))
        self.log(f"📤 MoneyChange: changed={money_changed}, current={money_current}")

    def _write_enter_world_error(self, builder: PacketBuilder, error_msg: str):
        builder.write_unsigned_short(0)
        builder.write_bool(False)
        builder.write_short(0)
        builder.write_short(0)
        builder.write_string(error_msg)
        builder.write_unsigned_short(0)

class WorldServer(BaseTCPServer):
    
    def __init__(self, host: str = '0.0.0.0', port: int = 8888):
        super().__init__('WORLD', host, port)
        self._db = None
        self._db_available = False
        self._role_repo = None
        debug_roles_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'debug_roles.json')
        self._debug_role_store = DebugRoleStore(debug_roles_path)
        self.sessions = {}
        self.teams = {}
        from gameplay.macro_engine import MacroEngine
        from gameplay.resource_index import ResourceIndex
        from gameplay.game_resource_service import GameResourceService
        from gameplay.combat_scheduler import CombatScheduler
        self.macro_engine = MacroEngine()
        self.game_resources = GameResourceService()
        self.resource_index = ResourceIndex()
        self.combat_scheduler = CombatScheduler()
        
        # Integrar o MapManager
        from map_manager import MapManager
        self.map_manager = MapManager.get_instance()
        
        self._init_database()
        
        import threading
        self._tick_thread = threading.Thread(target=self._tick_loop, daemon=True)
        self._tick_thread.start()

    def broadcast_to_map(self, map_id: str, packet: bytes, exclude_session=None):
        smart_logger.count("broadcasts")
        for session in list(self.sessions.values()):
            if session.player_data and session.player_data.get('mapId') == map_id:
                if session != exclude_session:
                    session.send_packet(packet)

    def announce_player_entered_map(self, entering_session):
        if not entering_session.player_data:
            return
        map_id = entering_session.player_data.get('mapId')
        for session in list(self.sessions.values()):
            if session is entering_session or not session.player_data:
                continue
            if session.player_data.get('mapId') == map_id:
                builder = PacketBuilder()
                write_remote_player_info(builder, entering_session.player_data)
                session.send_packet(builder.build(769))
                builder = PacketBuilder()
                write_remote_player_info(builder, session.player_data)
                entering_session.send_packet(builder.build(769))

    def announce_player_left_map(self, leaving_session, map_id):
        if not leaving_session.player_data:
            return
        builder = PacketBuilder()
        builder.write_string(map_id)
        builder.write_string(leaving_session.player_data.get('name', ''))
        self.broadcast_to_map(map_id, builder.build(770), exclude_session=leaving_session)

    def broadcast_remote_hp(self, session, changed, skill_code="", critical=False):
        pd = session.player_data
        hp_max = max(1.0, float(pd.get("hpMax", 1)))
        builder = PacketBuilder()
        builder.write_string(session.role_name)
        builder.write_double(float(changed))
        builder.write_byte(max(0, min(100, int(float(pd.get("hp", 0)) * 100 / hp_max))))
        builder.write_string(skill_code)
        builder.write_bool(critical)
        self.broadcast_to_map(pd.get("mapId"), builder.build(804), exclude_session=session)

    def broadcast_remote_mp(self, session, changed, skill_code=""):
        pd = session.player_data
        mp_max = max(1, int(pd.get("mpMax", 1)))
        builder = PacketBuilder()
        builder.write_string(session.role_name)
        builder.write_short(int(changed))
        builder.write_byte(max(0, min(100, int(int(pd.get("mp", 0)) * 100 / mp_max))))
        builder.write_string(skill_code)
        self.broadcast_to_map(pd.get("mapId"), builder.build(805), exclude_session=session)

    def set_combat_status(self, session, active):
        if not session.player_data or session.player_data.get("inCombat") == active:
            return
        session.player_data["inCombat"] = active
        session.player_data["combatUntil"] = time.time() + 8 if active else 0
        builder = PacketBuilder()
        builder.write_bool(active)
        session.send_packet(builder.build(570))

    def notify_player_died(self, session):
        pd = session.player_data
        if not pd or pd.get('isDead'):
            return
        pd['isDead'] = True
        pd['hp'] = 0.0
        self.combat_scheduler.cancel(session.role_name)

        for map_instance in self.map_manager.maps.values():
            for monster in map_instance.monsters.values():
                if getattr(monster, 'aggro_target', None) == session.role_name:
                    monster.aggro_target = None

        db = self._get_db()
        if db:
            try:
                db.execute_non_query("UPDATE TB_Role SET IsDead=1, HP=0 WHERE Name=?", (session.role_name,))
            except Exception as exc:
                smart_logger.exception("WORLD.persist_player_death", exc, session=session)
                try:
                    db.execute_non_query("UPDATE TB_Role SET HP=0 WHERE Name=?", (session.role_name,))
                except Exception as fallback_exc:
                    smart_logger.exception("WORLD.persist_player_hp_zero", fallback_exc, session=session)

        self.set_combat_status(session, False)

        map_id = pd.get("mapId", "")
        pos_x = int(pd.get("posX", 0))
        pos_y = int(pd.get("posY", 0))

        # 1) Tell the dying player they died (cmd 565: PLAYER_DIED_NOTIFY)
        local_died = PacketBuilder()
        local_died.write_string(map_id)
        local_died.write_short(pos_x)
        local_died.write_short(pos_y)
        local_died.write_string("")  # killerName
        session.send_packet(local_died.build(565))

        # 2) Broadcast local HP=0 notify so the player's own bar updates
        hp_notify = PacketBuilder()
        hp_notify.write_double(float(-float(pd.get('hpMax', 100))))  # changed (always negative enough)
        hp_notify.write_double(0.0)  # current = 0
        hp_notify.write_string("")
        hp_notify.write_bool(False)
        hp_notify.write_bool(False)
        session.send_packet(hp_notify.build(550))

        # 3) Broadcast remote HP=0 so other players see the bar empty (cmd 804)
        self.broadcast_remote_hp(session, -float(pd.get('hpMax', 100)), "")

        # 4) Broadcast remote died notify so other players see the death animation (cmd 808)
        remote_died = PacketBuilder()
        remote_died.write_string(session.role_name)
        remote_died.write_string(map_id)
        remote_died.write_short(pos_x)
        remote_died.write_short(pos_y)
        self.broadcast_to_map(map_id, remote_died.build(808), exclude_session=session)

    def notify_buff_change(self, session, added=None, removed=None):
        added, removed = added or [], removed or []
        local = PacketBuilder()
        local.write_varint(len(added))
        for buff in added:
            write_buff_info(local, buff)
        local.write_varint(len(removed))
        for buff_id in removed:
            local.write_unsigned_short(int(buff_id))
        session.send_packet(local.build(560))
        remote = PacketBuilder()
        remote.write_string(session.role_name)
        remote.write_varint(len(added))
        for buff in added:
            write_buff_info(remote, buff)
        remote.write_varint(len(removed))
        for buff_id in removed:
            remote.write_unsigned_short(int(buff_id))
        self.broadcast_to_map(session.player_data.get("mapId"), remote.build(806), exclude_session=session)

    def apply_buff(self, session, buff_id, duration_sec):
        buff_id = int(buff_id)
        config = self.resource_index.buff(buff_id)
        now = time.time()
        from gameplay.buff_runtime import apply_buff
        active = session.player_data.setdefault("activeBuffs", {})
        result = apply_buff(active, {**config, "buffId": buff_id, "durationInSec": config.get("durationInSec", duration_sec)}, now=now)
        if result.applied:
            for trigger in result.instance.get("triggers", []):
                if trigger["event"] == "timer":
                    trigger["nextTimerAt"] = now + trigger["firstDelay"]
            self.notify_buff_change(session, added=[{"buffId": buff_id, "durationInSec": result.instance["durationInSec"]}], removed=list(result.removed))
        return result

    def trigger_buffs(self, session, event_name, target_session=None):
        import random
        from gameplay.macro_engine import MacroContext
        for buff in list(session.player_data.get("activeBuffs", {}).values()):
            for trigger in buff.get("triggers", []):
                if trigger["event"] == event_name and random.random() <= trigger["chance"]:
                    self.macro_engine.execute(
                        trigger["macro"],
                        MacroContext(server=self, session=session, target_session=target_session, source=buff),
                    )

    def trigger_monster_buffs(self, monster, event_name, source_session=None):
        import random
        from gameplay.macro_engine import MacroContext
        for buff in list(monster.active_buffs.values()):
            for trigger in buff.get("triggers", []):
                if trigger["event"] == event_name and random.random() <= trigger["chance"]:
                    self.macro_engine.execute(
                        trigger["macro"],
                        MacroContext(server=self, session=source_session, monster=monster, source=buff),
                    )
        
    def _tick_loop(self):
        last_metrics_at = 0.0
        while True:
            tick_started = time.perf_counter()
            try:
                self.map_manager.tick(self)
                self.combat_scheduler.run_due(max_events=500)
                self.combat_scheduler.prune_cooldowns()
                now = time.time()
                for session in list(self.sessions.values()):
                    if session.player_data and session.player_data.get("inCombat") and now >= session.player_data.get("combatUntil", 0):
                        self.set_combat_status(session, False)
                    if session.player_data:
                        active = session.player_data.setdefault("activeBuffs", {})
                        from gameplay.macro_engine import MacroContext
                        for buff in list(active.values()):
                            for trigger in buff.get("triggers", []):
                                if trigger["event"] == "timer" and now >= trigger.get("nextTimerAt", 0):
                                    self.macro_engine.execute(trigger["macro"], MacroContext(server=self, session=session, target_session=session, source=buff))
                                    trigger["nextTimerAt"] = now + max(0.1, trigger["repeatInterval"] or 999999999)
                        from gameplay.buff_runtime import expire_buffs
                        expired = list(expire_buffs(active, now))
                        if expired:
                            self.notify_buff_change(session, removed=expired)
            except Exception as e:
                smart_logger.exception("WORLD.tick", e)
                self.log(f"Error in map manager tick: {e}")
            tick_ms = (time.perf_counter() - tick_started) * 1000.0
            metrics_now = time.time()
            if metrics_now - last_metrics_at >= 1.0:
                last_metrics_at = metrics_now
                smart_logger.write_metrics(
                    tick_ms=round(tick_ms, 3),
                    sessions=len(self.sessions),
                    maps=len(self.map_manager.maps),
                    monsters=sum(len(game_map.monsters) for game_map in self.map_manager.maps.values()),
                    pending_combat_events=self.combat_scheduler.pending_count(),
                )
            time.sleep(1.0)
            
    def _init_database(self):
        try:
            from database import get_db, get_role_repo
            db = get_db()
            if db.connect():
                self._db = db
                self._role_repo = get_role_repo()
                self._db_available = True
                self.log("✅ Banco de dados conectado no WorldServer")
        except Exception as e:
            self.log(f"⚠️ Erro DB no WorldServer: {e}")
            
    def _get_db(self):
        return self._db

    def handle_client(self, client_socket: socket.socket, address: tuple):
        """Processa cliente do World Server"""
        session = WorldSession(client_socket, address, self)
        session.log("🔌 Cliente conectado no World Server")
        
        buffer = b''
        
        try:
            while True:
                data = client_socket.recv(4096)
                if not data:
                    session.log("🔌 Cliente desconectou (sem dados)")
                    break
                
                buffer += data
                
                while len(buffer) >= 1:
                    length = 0
                    shift = 0
                    varint_bytes = 0
                    
                    for i in range(min(5, len(buffer))):
                        byte = buffer[i]
                        length |= (byte & 0x7F) << shift
                        varint_bytes += 1
                        if (byte & 0x80) == 0:
                            break
                        shift += 7
                    else:
                        if len(buffer) >= 5:
                            buffer = buffer[1:]
                        break
                    
                    total_len = varint_bytes + length
                    if len(buffer) < total_len:
                        break
                    
                    packet_data = buffer[varint_bytes:total_len]
                    buffer = buffer[total_len:]
                    
                    if len(packet_data) < 4:
                        continue
                    
                    command = struct.unpack('>H', packet_data[:2])[0]
                    payload = packet_data[4:]
                    
                    session.log(f"📥 Recebido cmd={command} ({len(payload)} bytes payload)")
                    
                    reader = PacketReader(payload)
                    
                    handler_registry = get_handler_registry()
                    if handler_registry.can_handle(command):
                        handler_registry.dispatch(command, session, reader)
                        continue
                    
                    if command == PlayerCommandCode.PLAYER_ENTER_WORLD_REQ:
                        session.handle_enter_world(reader)
                    elif command == PlayerCommandCode.PLAYER_VIEW_MAP_REQ:
                        session.handle_view_map(reader)
                    elif command in (BagCommandCode.PLAYER_BAG_CHECK_NOTIFY, BagCommandCode.PLAYER_VIEW_BAG_REQ):
                        session.handle_bag_check(reader)
                    else:
                        session.log(f"Comando desconhecido: {command}")
                        
        except Exception as e:
            smart_logger.exception("WORLD.handle_client", e, session=session)
            session.log(f"Erro: {e}")
            import traceback
            traceback.print_exc()
        finally:
            session.connected = False
            if session.player_data and session.player_data.get('name'):
                self.announce_player_left_map(session, session.player_data.get('mapId', ''))
                name = session.player_data.get('name')
                if self.sessions.get(name) is session:
                    self.sessions.pop(name, None)
                self.combat_scheduler.cancel(name)
                for game_map in self.map_manager.maps.values():
                    for monster in game_map.monsters.values():
                        if getattr(monster, 'aggro_target', None) == name:
                            monster.aggro_target = None
            handler_registry = get_handler_registry()
            handler_registry.cleanup_session(session)
            
            client_socket.close()
            session.log("🔌 Cliente desconectado")
    
    def get_account_by_ticket(self, ticket: str) -> Optional[Dict]:
        """Busca conta pelo ticket"""
        if self._db_available and self._role_repo:
            try:
                return self._role_repo.get_account_by_ticket(ticket)
            except Exception as e:
                self.log(f"Erro ao buscar conta: {e}")
        return None
    
    def get_roles_for_account(self, account_id: str) -> List[Dict]:
        if not self._db_available:
            return self._debug_role_store.list(account_id)
        """Retorna personagens de uma conta"""
        if self._db_available and self._role_repo:
            try:
                account_uid = None
                try:
                    account_uid = int(account_id)
                except ValueError:
                    account_data = self._role_repo.get_account_by_ticket(account_id)
                    if account_data:
                        account_uid = account_data['AccountUID']
                
                if account_uid:
                    db_roles = self._role_repo.get_roles_by_account(account_uid)
                    return [{
                        'id': r.get('Id') or r.get('RoleID'),
                        'name': r.get('Name'),
                        'jobCode': r.get('JobCode'),
                        'sex': r.get('Sex'),
                        'level': r.get('Level'),
                        'headIconIndex': r.get('HeadIconIndex'),
                        'hairStyleIndex': r.get('HairStyleIndex'),
                        'accountId': str(r.get('AccountId') or r.get('AccountUID')),
                        'createTime': str(r.get('CreatedAt') or r.get('CreateTime', '')),
                        'lastPlayTime': str(r.get('LastPlayTime', '')),
                        'deletedFlag': bool(r.get('DeletedFlag', False)),
                        'willDeleteTime': str(r.get('WillDeleteTime', '')) if r.get('WillDeleteTime') else '',
                        'equipmentModels': {},
                        'hasRolePassword': bool(r.get('HasRolePassword', False))
                     } for r in db_roles]
            except Exception as e:
                self.log(f"Erro ao buscar roles: {e}")
        return []
    
    def check_role_name(self, name: str) -> bool:
        if not self._db_available:
            return self._debug_role_store.name_available(name)
        """Verifica se nome está disponível"""
        if self._db_available and self._role_repo:
            try:
                return self._role_repo.check_name(name)
            except:
                pass
        return True
    
    def create_role(self, account_id: str, role_data: Dict) -> Dict:
        if not self._db_available:
            return self._debug_role_store.create(account_id, role_data)
        """Cria novo personagem"""
        if self._db_available and self._role_repo:
            try:
                account_uid = None
                try:
                    account_uid = int(account_id)
                except ValueError:
                    account_data = self._role_repo.get_account_by_ticket(account_id)
                    if account_data:
                        account_uid = account_data['AccountUID']
                
                if account_uid:
                    result = self._role_repo.create_role(
                        account_uid=account_uid,
                        name=role_data.get('name', ''),
                        job_code=role_data.get('jobCode', 1),
                        sex=role_data.get('sex', 0),
                        head_icon_index=role_data.get('headIconIndex', 0),
                        hair_style_index=role_data.get('hairStyleIndex', 0)
                    )
                    
                    if result.get('Status') == 0:
                        return {
                            'id': result.get('RoleID'),
                            'name': result.get('Name'),
                            'jobCode': result.get('JobCode'),
                            'sex': result.get('Sex'),
                            'level': result.get('Level', 1),
                            'headIconIndex': result.get('HeadIconIndex', 0),
                            'hairStyleIndex': result.get('HairStyleIndex', 0),
                            'accountId': str(result.get('AccountUID', account_uid)),
                            'createTime': str(result.get('CreateTime', '')),
                            'lastPlayTime': str(result.get('LastPlayTime', '')),
                            'deletedFlag': False,
                            'willDeleteTime': '',
                            'equipmentModels': {},
                            'hasRolePassword': False
                        }
                    else:
                        return {'error': result.get('Message', 'Erro')}
            except Exception as e:
                self.log(f"Erro ao criar role: {e}")
        
        return {'error': 'Banco não disponível'}
    
    def select_role(self, account_id: str, name: str, password: str = None) -> Dict:
        if not self._db_available:
            return self._debug_role_store.select(account_id, name)
        """Seleciona personagem"""
        if self._db_available and self._role_repo:
            try:
                account_uid = None
                try:
                    account_uid = int(account_id)
                except ValueError:
                    account_data = self._role_repo.get_account_by_ticket(account_id)
                    if account_data:
                        account_uid = account_data['AccountUID']
                
                if account_uid:
                    return self._role_repo.select_role(account_uid, name, password)
            except Exception as e:
                self.log(f"Erro ao selecionar role: {e}")
        
        return {'IsDone': 0, 'FailureReason': 'Erro interno'}
    
    def delete_role(self, account_id: str, name: str) -> Dict:
        if not self._db_available:
            return self._debug_role_store.delete(account_id, name)
        """Deleta personagem"""
        if self._db_available and self._role_repo:
            try:
                account_uid = None
                try:
                    account_uid = int(account_id)
                except ValueError:
                    account_data = self._role_repo.get_account_by_ticket(account_id)
                    if account_data:
                        account_uid = account_data['AccountUID']
                
                if account_uid:
                    return self._role_repo.delete_role(account_uid, name)
            except Exception as e:
                self.log(f"Erro ao deletar role: {e}")
        
        return {'IsDone': 0, 'FailureReason': 'Erro interno'}

if __name__ == '__main__':
    server = WorldServer()
    try:
        server.start()
    except KeyboardInterrupt:
        pass

