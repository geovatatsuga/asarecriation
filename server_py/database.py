import json
import os
import sqlite3
import uuid
import threading
from datetime import datetime, timedelta
from typing import Dict, List, Optional


SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(SCRIPT_DIR, "data")
SQLITE_PATH = os.environ.get("CRYSTAL_SQLITE_PATH", os.path.join(DATA_DIR, "crystal_saga.db"))

DB_BACKEND = os.environ.get("DB_BACKEND", "auto").lower()
POSTGRES_DSN = os.environ.get(
    "POSTGRES_DSN",
    "host=localhost port=5432 dbname=mspt1 user=postgres password=postgres connect_timeout=3",
)

_db_instance = None


class Database:
    def __init__(self):
        self.conn = None
        self.backend = None
        self._transaction_lock = threading.RLock()
        self._in_transaction = False

    def connect(self) -> bool:
        if self.conn:
            return True

        if DB_BACKEND in ("postgres", "postgresql", "auto"):
            try:
                import psycopg

                try:
                    self.conn = psycopg.connect(POSTGRES_DSN)
                except psycopg.OperationalError as e:
                    if "mspt1" not in str(e):
                        raise
                    admin = psycopg.connect("host=localhost port=5432 dbname=postgres user=postgres password=postgres")
                    admin.autocommit = True
                    with admin.cursor() as cur:
                        cur.execute("CREATE DATABASE mspt1")
                    admin.close()
                    self.conn = psycopg.connect(POSTGRES_DSN)
                self.conn.autocommit = True
                self.backend = "postgres"
                self._init_schema()
                print("[DB] PostgreSQL conectado")
                return True
            except Exception as e:
                if DB_BACKEND in ("postgres", "postgresql"):
                    print(f"[DB] Erro PostgreSQL: {str(e).encode('ascii', 'ignore').decode('ascii')}")
                    return False
                safe_error = str(e).encode("ascii", "ignore").decode("ascii")
                print(f"[DB] PostgreSQL indisponivel, usando SQLite persistente: {safe_error}")

        try:
            os.makedirs(DATA_DIR, exist_ok=True)
            self.conn = sqlite3.connect(SQLITE_PATH, check_same_thread=False)
            self.conn.row_factory = sqlite3.Row
            self.backend = "sqlite"
            self._init_schema()
            print(f"[DB] SQLite persistente conectado: {SQLITE_PATH}")
            return True
        except Exception as e:
            print(f"[DB] Erro SQLite: {e}")
            return False

    def _convert_query(self, query: str) -> str:
        if self.backend == "postgres":
            return query.replace("?", "%s")
        query = query.replace("GETDATE()", "CURRENT_TIMESTAMP")
        query = query.replace("getdate()", "CURRENT_TIMESTAMP")
        return query

    def execute_query(self, query: str, params: tuple = None) -> List[Dict]:
        if not self.conn:
            return []
        cursor = self.conn.cursor()
        cursor.execute(self._convert_query(query), params or ())
        if not cursor.description:
            if self.backend == "sqlite":
                self.conn.commit()
            return []
        columns = [col[0] for col in cursor.description]
        return [self._row_dict(columns, row) for row in cursor.fetchall()]

    def _row_dict(self, columns, row) -> Dict:
        aliases = {
            "id": "Id",
            "username": "Username",
            "passwordhash": "PasswordHash",
            "status": "Status",
            "accountuid": "AccountUID",
            "accountid": "AccountId",
            "serverid": "ServerID",
            "servername": "ServerName",
            "serverip": "ServerIP",
            "serverport": "ServerPort",
            "name": "Name",
            "jobcode": "JobCode",
            "sex": "Sex",
            "level": "Level",
            "headiconindex": "HeadIconIndex",
            "hairstyleindex": "HairStyleIndex",
            "mapid": "MapId",
            "posx": "PosX",
            "posy": "PosY",
            "createdat": "CreatedAt",
            "lastplaytime": "LastPlayTime",
            "deletedflag": "DeletedFlag",
            "willdeletetime": "WillDeleteTime",
            "hasrolepassword": "HasRolePassword",
            "petbkhp": "PetBkHp",
            "petbkhpmax": "PetBkHpMax",
            "petbkmp": "PetBkMp",
            "petbkmpmax": "PetBkMpMax",
            "honorvalue": "HonorValue",
            "bagcapacityplayer": "BagCapacityPlayer",
            "bagindex": "BagIndex",
            "inventoryid": "InventoryID",
            "slotindex": "SlotIndex",
            "itemid": "ItemId",
            "itemcode": "ItemCode",
            "itemcount": "ItemCount",
            "isbound": "IsBound",
            "enhancelevel": "EnhanceLevel",
            "extradata": "ExtraData",
            "itemtype": "ItemType",
            "itemsubtype": "ItemSubType",
            "subtype": "SubType",
            "maintype": "MainType",
            "itemname": "ItemName",
            "equipmodelcode": "EquipModelCode",
            "attrforce": "AttrForce",
            "attrspirit": "AttrSpirit",
            "attragility": "AttrAgility",
            "attrvitality": "AttrVitality",
            "attrremainpoints": "AttrRemainPoints",
            "lineindex": "LineIndex",
            "maxhp": "MaxHP",
            "maxmp": "MaxMP",
            "bagcapacitypet": "BagCapacityPet",
            "bagcapacityride": "BagCapacityRide",
            "isusefashion": "IsUseFashion",
            "equipmentmodelsjson": "EquipmentModelsJson",
            "clientconfig": "ClientConfig",
            "honorlevel": "HonorLevel",
            "viplevel": "VipLevel",
            "vipexp": "VipExp",
            "isdead": "IsDead",
            "issitting": "IsSitting",
            "statusflags": "StatusFlags",
            "reborntimes": "RebornTimes",
            "lifejob": "LifeJob",
            "lifelevel": "LifeLevel",
            "lifeexp": "LifeExp",
            "pkmode": "PkMode",
            "pkvalue": "PkValue",
            "isautohp": "IsAutoHp",
            "isautomp": "IsAutoMp",
            "consecutivelogindays": "ConsecutiveLoginDays",
            "boonitemcode": "BoonItemCode",
            "stirplevel": "StirpLevel",
            "potentiallevel": "PotentialLevel",
            "potentialvalue": "PotentialValue",
            "refinelevel": "RefineLevel",
            "lightlevel": "LightLevel",
            "bonelevel": "BoneLevel",
            "constellationlevel": "ConstellationLevel",
            "constellationtaskid": "ConstellationTaskId",
            "lucklevel": "LuckLevel",
            "hartlevel": "HartLevel",
            "gametimes": "GameTimes",
            "arenaintegral": "ArenaIntegral",
            "towervalue": "TowerValue",
            "ridecode": "RideCode",
            "titleindex": "TitleIndex",
            "kittitleindex": "KitTitleIndex",
            "modelcode": "ModelCode",
            "durability": "Durability",
            "maxdurability": "MaxDurability",
            "renewruleindex": "RenewRuleIndex",
            "agentrecid": "AgentRecId",
            "sellerrolename": "SellerRoleName",
            "price": "Price",
            "state": "State",
            "waittimeinsec": "WaitTimeInSec",
            "boothitemid": "BoothItemId",
            "ownerrolename": "OwnerRoleName",
            "itemindex": "ItemIndex",
            "itemprice": "ItemPrice",
            "kind": "Kind",
            "rolename": "RoleName",
            "boothtitle": "BoothTitle",
            "isbooth": "IsBooth",
            "gridtomcname": "GridToMCName",
            "gridkind": "GridKind",
            "equipmentitemid": "EquipmentItemId",
            "armorylevel": "ArmoryLevel",
            "armoryexp": "ArmoryExp",
            "wardrobeindex": "WardrobeIndex",
            "wardrobelevel": "WardrobeLevel",
            "holecount": "HoleCount",
            "soullevel": "SoulLevel",
            "equlevel": "EquLevel",
            "equexp": "EquExp",
            "washpoint": "WashPoint",
            "letteringword": "LetteringWord",
            "extrajson": "ExtraJson",
            "temperjson": "TemperJson",
            "newtemperjson": "NewTemperJson",
        }
        result = {}
        for column, value in zip(columns, row):
            result[column] = value
            lower = column.lower()
            if lower in aliases:
                result[aliases[lower]] = value
            if column:
                result[column[:1].upper() + column[1:]] = value
        return result

    def execute_non_query(self, query: str, params: tuple = None) -> int:
        if not self.conn:
            return 0
        cursor = self.conn.cursor()
        cursor.execute(self._convert_query(query), params or ())
        if self.backend == "sqlite" and not self._in_transaction:
            self.conn.commit()
        return cursor.rowcount

    def run_transaction(self, callback):
        """Run a database operation atomically on the shared connection."""
        with self._transaction_lock:
            old_autocommit = getattr(self.conn, "autocommit", None)
            try:
                self._in_transaction = True
                if self.backend == "postgres":
                    self.conn.autocommit = False
                result = callback()
                self.conn.commit()
                return result
            except Exception:
                self.conn.rollback()
                raise
            finally:
                self._in_transaction = False
                if self.backend == "postgres":
                    self.conn.autocommit = old_autocommit

    def execute_proc(self, proc_name: str, params: Dict = None) -> List[Dict]:
        params = params or {}
        if proc_name == "SP_AddItemToInventory":
            return [self.add_item_to_inventory(
                params.get("RoleName", ""),
                params.get("ItemCode", ""),
                int(params.get("ItemCount", 1)),
                int(params.get("BagIndex", 1)),
            )]
        if proc_name == "SP_LoadInventory":
            query = "SELECT * FROM TB_RoleInventory WHERE RoleName=?"
            values = (params.get("RoleName", ""),)
            if params.get("BagIndex") is not None:
                query += " AND BagIndex=?"
                values = (params.get("RoleName", ""), int(params.get("BagIndex", 1)))
            return self.execute_query(query, values)
        if proc_name == "SP_MoveInventoryItem":
            return [self.move_inventory_item(
                params.get("RoleName", ""),
                int(params.get("BagIndex", 1)),
                int(params.get("FromSlot", 0)),
                int(params.get("ToSlot", 0)),
            )]
        if proc_name == "SP_RemoveItem":
            return [self.remove_item(
                params.get("RoleName", ""),
                int(params.get("BagIndex", 1)),
                int(params.get("SlotIndex", 0)),
                params.get("RemoveCount"),
            )]
        if proc_name == "SP_EquipItem":
            return [self.equip_item(
                params.get("RoleName", ""),
                int(params.get("FromBag", 1)),
                int(params.get("FromSlot", 0)),
                int(params.get("ToBag", 10)),
                int(params.get("ToSlot", 0)),
            )]
        if proc_name == "SP_UpdateEquipmentModel":
            return []
        if proc_name == "SP_UpdateTaskStatus":
            self.update_task_status(
                params.get("RoleName") or params.get(0, ""),
                int(params.get("TaskId") or params.get(1, 0)),
                params.get("TaskStatus") or params.get(2, "D"),
                int(params.get("AllocatorId") or params.get(3, 0) or 0),
                int(params.get("CompletedCount") or params.get(4, 0) or 0),
            )
            return [{"RowsAffected": 1}]
        if proc_name == "SP_RemoveTask":
            self.remove_task_status(
                params.get("RoleName") or params.get(0, ""),
                int(params.get("TaskId") or params.get(1, 0)),
            )
            return [{"RowsAffected": 1}]
        print(f"[DB] Stored procedure nao implementada: {proc_name}")
        return []

    def execute_proc_multi(self, proc_name: str, params: Dict = None) -> List[List[Dict]]:
        result = self.execute_proc(proc_name, params)
        return [result] if result else []

    def call_procedure(self, proc_name: str, params=None) -> List[Dict]:
        if isinstance(params, tuple):
            keys = {
                "SP_UpdateTaskStatus": ["RoleName", "TaskId", "TaskStatus", "AllocatorId", "CompletedCount"],
                "SP_RemoveTask": ["RoleName", "TaskId"],
            }.get(proc_name, [])
            params = {key: params[index] for index, key in enumerate(keys) if index < len(params)}
        return self.execute_proc(proc_name, params or {})

    def update_task_status(
        self,
        role_name: str,
        task_id: int,
        status: str,
        allocator_id: int = 0,
        completed_count: int = 0,
    ) -> None:
        if self.backend == "postgres":
            self.execute_non_query(
                """
                INSERT INTO TB_RoleTask (RoleName, TaskId, TaskStatus, AllocatorId, CompletedCount, UpdatedAt)
                VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                ON CONFLICT (RoleName, TaskId) DO UPDATE SET
                    TaskStatus=EXCLUDED.TaskStatus,
                    AllocatorId=EXCLUDED.AllocatorId,
                    CompletedCount=EXCLUDED.CompletedCount,
                    UpdatedAt=CURRENT_TIMESTAMP
                """,
                (role_name, task_id, status, allocator_id, completed_count),
            )
        else:
            self.execute_non_query(
                """
                INSERT INTO TB_RoleTask (RoleName, TaskId, TaskStatus, AllocatorId, CompletedCount, UpdatedAt)
                VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                ON CONFLICT(RoleName, TaskId) DO UPDATE SET
                    TaskStatus=excluded.TaskStatus,
                    AllocatorId=excluded.AllocatorId,
                    CompletedCount=excluded.CompletedCount,
                    UpdatedAt=CURRENT_TIMESTAMP
                """,
                (role_name, task_id, status, allocator_id, completed_count),
            )

    def remove_task_status(self, role_name: str, task_id: int) -> None:
        self.execute_non_query(
            "DELETE FROM TB_RoleTask WHERE RoleName=? AND TaskId=?",
            (role_name, task_id),
        )

    def get_role_skills(self, role_name: str) -> Dict[str, int]:
        rows = self.execute_query(
            "SELECT SkillCode, SkillLevel FROM TB_RoleSkill WHERE RoleName=?",
            (role_name,)
        )
        skills = {}
        for r in rows:
            code = r.get("SkillCode") or r.get("skillcode")
            level = r.get("SkillLevel") or r.get("skilllevel") or 1
            if code:
                skills[code] = int(level)
        return skills

    def save_role_skill(self, role_name: str, skill_code: str, level: int):
        if self.backend == "postgres":
            self.execute_non_query(
                """
                INSERT INTO TB_RoleSkill (RoleName, SkillCode, SkillLevel)
                VALUES (?, ?, ?)
                ON CONFLICT (RoleName, SkillCode) DO UPDATE SET
                    SkillLevel=EXCLUDED.SkillLevel
                """,
                (role_name, skill_code, level)
            )
        else:
            self.execute_non_query(
                """
                INSERT INTO TB_RoleSkill (RoleName, SkillCode, SkillLevel)
                VALUES (?, ?, ?)
                ON CONFLICT(RoleName, SkillCode) DO UPDATE SET
                    SkillLevel=excluded.SkillLevel
                """,
                (role_name, skill_code, level)
            )

    def _init_schema(self):
        if self.backend == "postgres":
            statements = [
            """
            CREATE TABLE IF NOT EXISTS TB_Account (
                Id SERIAL PRIMARY KEY,
                Username TEXT NOT NULL UNIQUE,
                PasswordHash TEXT NOT NULL,
                Email TEXT,
                Status INTEGER DEFAULT 1,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                LastLoginAt TIMESTAMP,
                LastLoginIP TEXT
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Session (
                Id SERIAL PRIMARY KEY,
                AccountId INTEGER NOT NULL,
                SessionKey TEXT NOT NULL UNIQUE,
                ClientIP TEXT,
                IPAddress TEXT,
                ServerId INTEGER DEFAULT 1,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                ExpiresAt TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Server (
                Id INTEGER PRIMARY KEY,
                ServerName TEXT NOT NULL,
                ServerIP TEXT NOT NULL,
                ServerPort INTEGER NOT NULL,
                Status INTEGER DEFAULT 1
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Role (
                Id SERIAL PRIMARY KEY,
                AccountId INTEGER NOT NULL,
                Name TEXT NOT NULL UNIQUE,
                JobCode INTEGER NOT NULL,
                Sex INTEGER NOT NULL,
                Level INTEGER DEFAULT 1,
                Exp BIGINT DEFAULT 0,
                HeadIconIndex INTEGER DEFAULT 0,
                HairStyleIndex INTEGER DEFAULT 0,
                MapId TEXT DEFAULT 'a1',
                PosX INTEGER DEFAULT 1120,
                PosY INTEGER DEFAULT 2080,
                LineIndex INTEGER DEFAULT 0,
                HP INTEGER DEFAULT 100,
                MaxHP INTEGER DEFAULT 100,
                MP INTEGER DEFAULT 100,
                MaxMP INTEGER DEFAULT 100,
                PetBkHp INTEGER DEFAULT 0,
                PetBkHpMax INTEGER DEFAULT 0,
                PetBkMp INTEGER DEFAULT 0,
                PetBkMpMax INTEGER DEFAULT 0,
                Gold BIGINT DEFAULT 1000,
                Money INTEGER DEFAULT 100,
                BagCapacityPlayer INTEGER DEFAULT 36,
                BagCapacityPet INTEGER DEFAULT 3,
                BagCapacityRide INTEGER DEFAULT 3,
                IsUseFashion INTEGER DEFAULT 1,
                DeletedFlag INTEGER DEFAULT 0,
                WillDeleteTime TIMESTAMP,
                HasRolePassword INTEGER DEFAULT 0,
                EquipmentModelsJson TEXT,
                ClientConfig TEXT,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                LastPlayTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_ItemDefinition (
                ItemCode TEXT PRIMARY KEY,
                ItemName TEXT NOT NULL,
                ItemType INTEGER DEFAULT 0,
                ItemSubType INTEGER DEFAULT 0,
                MainType INTEGER DEFAULT 0,
                SubType INTEGER DEFAULT 0,
                Quality INTEGER DEFAULT 1,
                IconRes TEXT,
                ModelRes TEXT,
                EquipModelCode TEXT,
                MaxStack INTEGER DEFAULT 1,
                BuyPrice INTEGER DEFAULT 0,
                SellPrice INTEGER DEFAULT 0,
                ExtraDataJson TEXT
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleInventory (
                InventoryID SERIAL PRIMARY KEY,
                Id INTEGER,
                RoleId INTEGER NOT NULL,
                RoleName TEXT NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                BagIndex INTEGER NOT NULL,
                SlotIndex INTEGER NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                IsBound INTEGER DEFAULT 0,
                EnhanceLevel INTEGER DEFAULT 0,
                Durability INTEGER DEFAULT 100,
                MaxDurability INTEGER DEFAULT 100,
                RenewRuleIndex INTEGER DEFAULT 0,
                ExtraData TEXT,
                ExtraDataJson TEXT,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                UNIQUE(RoleName, BagIndex, SlotIndex)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleTask (
                RoleName TEXT NOT NULL,
                TaskId INTEGER NOT NULL,
                TaskStatus TEXT NOT NULL,
                AllocatorId INTEGER DEFAULT 0,
                CompletedCount INTEGER DEFAULT 1,
                UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY(RoleName, TaskId)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleSkill (
                RoleName TEXT NOT NULL,
                SkillCode TEXT NOT NULL,
                SkillLevel INTEGER DEFAULT 1,
                PRIMARY KEY(RoleName, SkillCode)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_AgentItem (
                AgentRecId SERIAL PRIMARY KEY,
                SellerRoleName TEXT NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                Price INTEGER DEFAULT 0,
                State INTEGER DEFAULT 0,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleBooth (
                RoleName TEXT PRIMARY KEY,
                BoothTitle TEXT,
                IsBooth INTEGER DEFAULT 0,
                UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_BoothItem (
                BoothItemId SERIAL PRIMARY KEY,
                OwnerRoleName TEXT NOT NULL,
                ItemIndex INTEGER NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                ItemPrice INTEGER DEFAULT 0,
                Kind TEXT DEFAULT 'sell',
                UNIQUE(OwnerRoleName, ItemIndex, Kind)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleArmory (
                RoleName TEXT NOT NULL,
                GridToMCName TEXT NOT NULL,
                GridKind INTEGER DEFAULT 0,
                EquipmentItemId TEXT,
                ArmoryLevel INTEGER DEFAULT 1,
                ArmoryExp INTEGER DEFAULT 0,
                PRIMARY KEY(RoleName, GridToMCName)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleWardrobe (
                RoleName TEXT NOT NULL,
                WardrobeIndex INTEGER NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                WardrobeLevel INTEGER DEFAULT 1,
                PRIMARY KEY(RoleName, WardrobeIndex)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleArtifactState (
                RoleName TEXT NOT NULL,
                EquipmentItemId TEXT NOT NULL,
                HoleCount INTEGER DEFAULT 0,
                RefineLevel INTEGER DEFAULT 0,
                SoulLevel INTEGER DEFAULT 0,
                EquLevel INTEGER DEFAULT 0,
                EquExp INTEGER DEFAULT 0,
                WashPoint REAL DEFAULT 0,
                LetteringWord TEXT,
                ExtraJson TEXT,
                PRIMARY KEY(RoleName, EquipmentItemId)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleKindGrow (
                RoleName TEXT NOT NULL,
                Kind INTEGER NOT NULL,
                Level INTEGER DEFAULT 0,
                Exp INTEGER DEFAULT 0,
                TemperJson TEXT,
                NewTemperJson TEXT,
                PRIMARY KEY(RoleName, Kind)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Task (
                TaskId INTEGER PRIMARY KEY,
                TaskName TEXT NOT NULL,
                TaskType INTEGER NOT NULL DEFAULT 1,
                PreTaskId INTEGER DEFAULT 0,
                NextTaskId INTEGER DEFAULT 0,
                NpcId TEXT,
                MapId TEXT,
                ConditionType TEXT,
                ConditionValue TEXT,
                RewardGold BIGINT DEFAULT 0,
                RewardExp BIGINT DEFAULT 0,
                RewardItems JSONB DEFAULT '[]'::jsonb,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleWing (
                RoleName TEXT PRIMARY KEY REFERENCES TB_Role(Name) ON DELETE CASCADE,
                WingModelCode TEXT DEFAULT '',
                WingLevel INTEGER DEFAULT 0,
                WingExp BIGINT DEFAULT 0,
                WingSkillIds JSONB DEFAULT '[]'::jsonb,
                WingActivated BOOLEAN DEFAULT FALSE,
                UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            ]
        else:
            statements = [
            """
            CREATE TABLE IF NOT EXISTS TB_Account (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Username TEXT NOT NULL UNIQUE,
                PasswordHash TEXT NOT NULL,
                Email TEXT,
                Status INTEGER DEFAULT 1,
                CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
                LastLoginAt TEXT,
                LastLoginIP TEXT
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Session (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                AccountId INTEGER NOT NULL,
                SessionKey TEXT NOT NULL UNIQUE,
                ClientIP TEXT,
                IPAddress TEXT,
                ServerId INTEGER DEFAULT 1,
                CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
                ExpiresAt TEXT
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Server (
                Id INTEGER PRIMARY KEY,
                ServerName TEXT NOT NULL,
                ServerIP TEXT NOT NULL,
                ServerPort INTEGER NOT NULL,
                Status INTEGER DEFAULT 1
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Role (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                AccountId INTEGER NOT NULL,
                Name TEXT NOT NULL UNIQUE,
                JobCode INTEGER NOT NULL,
                Sex INTEGER NOT NULL,
                Level INTEGER DEFAULT 1,
                Exp INTEGER DEFAULT 0,
                HeadIconIndex INTEGER DEFAULT 0,
                HairStyleIndex INTEGER DEFAULT 0,
                MapId TEXT DEFAULT 'a1',
                PosX INTEGER DEFAULT 1120,
                PosY INTEGER DEFAULT 2080,
                LineIndex INTEGER DEFAULT 0,
                HP INTEGER DEFAULT 100,
                MaxHP INTEGER DEFAULT 100,
                MP INTEGER DEFAULT 100,
                MaxMP INTEGER DEFAULT 100,
                PetBkHp INTEGER DEFAULT 0,
                PetBkHpMax INTEGER DEFAULT 0,
                PetBkMp INTEGER DEFAULT 0,
                PetBkMpMax INTEGER DEFAULT 0,
                Gold INTEGER DEFAULT 1000,
                Money INTEGER DEFAULT 100,
                BagCapacityPlayer INTEGER DEFAULT 36,
                BagCapacityPet INTEGER DEFAULT 3,
                BagCapacityRide INTEGER DEFAULT 3,
                IsUseFashion INTEGER DEFAULT 1,
                DeletedFlag INTEGER DEFAULT 0,
                WillDeleteTime TEXT,
                HasRolePassword INTEGER DEFAULT 0,
                EquipmentModelsJson TEXT,
                ClientConfig TEXT,
                CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
                LastPlayTime TEXT DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_ItemDefinition (
                ItemCode TEXT PRIMARY KEY,
                ItemName TEXT NOT NULL,
                ItemType INTEGER DEFAULT 0,
                ItemSubType INTEGER DEFAULT 0,
                MainType INTEGER DEFAULT 0,
                SubType INTEGER DEFAULT 0,
                Quality INTEGER DEFAULT 1,
                IconRes TEXT,
                ModelRes TEXT,
                EquipModelCode TEXT,
                MaxStack INTEGER DEFAULT 1,
                BuyPrice INTEGER DEFAULT 0,
                SellPrice INTEGER DEFAULT 0,
                ExtraDataJson TEXT
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleInventory (
                InventoryID INTEGER PRIMARY KEY AUTOINCREMENT,
                Id INTEGER,
                RoleId INTEGER NOT NULL,
                RoleName TEXT NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                BagIndex INTEGER NOT NULL,
                SlotIndex INTEGER NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                IsBound INTEGER DEFAULT 0,
                EnhanceLevel INTEGER DEFAULT 0,
                Durability INTEGER DEFAULT 100,
                MaxDurability INTEGER DEFAULT 100,
                RenewRuleIndex INTEGER DEFAULT 0,
                ExtraData TEXT,
                ExtraDataJson TEXT,
                CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
                UNIQUE(RoleName, BagIndex, SlotIndex)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleTask (
                RoleName TEXT NOT NULL,
                TaskId INTEGER NOT NULL,
                TaskStatus TEXT NOT NULL,
                AllocatorId INTEGER DEFAULT 0,
                CompletedCount INTEGER DEFAULT 1,
                UpdatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
                PRIMARY KEY(RoleName, TaskId)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleSkill (
                RoleName TEXT NOT NULL,
                SkillCode TEXT NOT NULL,
                SkillLevel INTEGER DEFAULT 1,
                PRIMARY KEY(RoleName, SkillCode)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_AgentItem (
                AgentRecId INTEGER PRIMARY KEY AUTOINCREMENT,
                SellerRoleName TEXT NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                Price INTEGER DEFAULT 0,
                State INTEGER DEFAULT 0,
                CreatedAt TEXT DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleBooth (
                RoleName TEXT PRIMARY KEY,
                BoothTitle TEXT,
                IsBooth INTEGER DEFAULT 0,
                UpdatedAt TEXT DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_BoothItem (
                BoothItemId INTEGER PRIMARY KEY AUTOINCREMENT,
                OwnerRoleName TEXT NOT NULL,
                ItemIndex INTEGER NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                ItemPrice INTEGER DEFAULT 0,
                Kind TEXT DEFAULT 'sell',
                UNIQUE(OwnerRoleName, ItemIndex, Kind)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleArmory (
                RoleName TEXT NOT NULL,
                GridToMCName TEXT NOT NULL,
                GridKind INTEGER DEFAULT 0,
                EquipmentItemId TEXT,
                ArmoryLevel INTEGER DEFAULT 1,
                ArmoryExp INTEGER DEFAULT 0,
                PRIMARY KEY(RoleName, GridToMCName)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleWardrobe (
                RoleName TEXT NOT NULL,
                WardrobeIndex INTEGER NOT NULL,
                ItemId TEXT NOT NULL,
                ItemCode TEXT NOT NULL,
                ItemCount INTEGER DEFAULT 1,
                WardrobeLevel INTEGER DEFAULT 1,
                PRIMARY KEY(RoleName, WardrobeIndex)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleArtifactState (
                RoleName TEXT NOT NULL,
                EquipmentItemId TEXT NOT NULL,
                HoleCount INTEGER DEFAULT 0,
                RefineLevel INTEGER DEFAULT 0,
                SoulLevel INTEGER DEFAULT 0,
                EquLevel INTEGER DEFAULT 0,
                EquExp INTEGER DEFAULT 0,
                WashPoint REAL DEFAULT 0,
                LetteringWord TEXT,
                ExtraJson TEXT,
                PRIMARY KEY(RoleName, EquipmentItemId)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleKindGrow (
                RoleName TEXT NOT NULL,
                Kind INTEGER NOT NULL,
                Level INTEGER DEFAULT 0,
                Exp INTEGER DEFAULT 0,
                TemperJson TEXT,
                NewTemperJson TEXT,
                PRIMARY KEY(RoleName, Kind)
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_Task (
                TaskId INTEGER PRIMARY KEY,
                TaskName TEXT NOT NULL,
                TaskType INTEGER NOT NULL DEFAULT 1,
                PreTaskId INTEGER DEFAULT 0,
                NextTaskId INTEGER DEFAULT 0,
                NpcId TEXT,
                MapId TEXT,
                ConditionType TEXT,
                ConditionValue TEXT,
                RewardGold BIGINT DEFAULT 0,
                RewardExp BIGINT DEFAULT 0,
                RewardItems JSONB DEFAULT '[]'::jsonb,
                CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
            """
            CREATE TABLE IF NOT EXISTS TB_RoleWing (
                RoleName TEXT PRIMARY KEY REFERENCES TB_Role(Name) ON DELETE CASCADE,
                WingModelCode TEXT DEFAULT '',
                WingLevel INTEGER DEFAULT 0,
                WingExp BIGINT DEFAULT 0,
                WingSkillIds JSONB DEFAULT '[]'::jsonb,
                WingActivated BOOLEAN DEFAULT FALSE,
                UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
            """,
        ]
        for statement in statements:
            self.execute_non_query(statement)
        self._ensure_role_extra_columns()
        self._ensure_inventory_extra_columns()
        if self.backend == "postgres":
            self.execute_non_query(
                "INSERT INTO TB_Server (Id, ServerName, ServerIP, ServerPort, Status) VALUES (1, 'Localhost', '127.0.0.1', 8888, 1) ON CONFLICT (Id) DO NOTHING"
            )
            self.execute_non_query(
                "INSERT INTO TB_Account (Id, Username, PasswordHash, Status) VALUES (1, 'debug', 'debug', 1) ON CONFLICT (Id) DO NOTHING"
            )
            self.execute_non_query(
                "SELECT setval(pg_get_serial_sequence('TB_Account','id'), COALESCE((SELECT MAX(Id) FROM TB_Account), 1), true)"
            )
            self.execute_non_query(
                "SELECT setval(pg_get_serial_sequence('TB_Role','id'), COALESCE((SELECT MAX(Id) FROM TB_Role), 1), true)"
            )
        else:
            self.execute_non_query(
                "INSERT OR IGNORE INTO TB_Server (Id, ServerName, ServerIP, ServerPort, Status) VALUES (1, 'Localhost', '127.0.0.1', 8888, 1)"
            )
            self.execute_non_query(
                "INSERT OR IGNORE INTO TB_Account (Id, Username, PasswordHash, Status) VALUES (1, 'debug', 'debug', 1)"
            )
        self._seed_item_definitions()

    def _ensure_role_extra_columns(self):
        columns = {
            "HonorValue": "INTEGER DEFAULT 0",
            "AttrForce": "INTEGER DEFAULT 10",
            "AttrSpirit": "INTEGER DEFAULT 10",
            "AttrAgility": "INTEGER DEFAULT 10",
            "AttrVitality": "INTEGER DEFAULT 10",
            "AttrRemainPoints": "INTEGER DEFAULT 0",
            "MaxLevel": "INTEGER DEFAULT 999",
            "PhysicalAttack": "INTEGER DEFAULT 10",
            "PhysicalDefense": "INTEGER DEFAULT 5",
            "MagicAttack": "INTEGER DEFAULT 10",
            "MagicDefense": "INTEGER DEFAULT 5",
            "WalkSpeed": "INTEGER DEFAULT 200",
            "IsDead": "INTEGER DEFAULT 0",
            "WingModelCode": "TEXT DEFAULT ''",
            "WingLevel": "INTEGER DEFAULT 0",
            "WingExp": "BIGINT DEFAULT 0",
            "WingSkillIds": "JSONB DEFAULT '[]'::jsonb",
            "WingActivated": "BOOLEAN DEFAULT FALSE",
        }
        for column, ddl in columns.items():
            try:
                if self.backend == "postgres":
                    self.execute_non_query(f"ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS {column} {ddl}")
                else:
                    existing = self.execute_query("PRAGMA table_info(TB_Role)")
                    names = {row.get("name") or row.get("Name") for row in existing}
                    if column not in names:
                        self.execute_non_query(f"ALTER TABLE TB_Role ADD COLUMN {column} {ddl}")
            except Exception:
                pass

    def _ensure_inventory_extra_columns(self):
        columns = {
            "Durability": "INTEGER DEFAULT 100",
            "MaxDurability": "INTEGER DEFAULT 100",
            "RenewRuleIndex": "INTEGER DEFAULT 0",
        }
        existing = set()
        if self.backend != "postgres":
            try:
                existing = {row.get("name") or row.get("Name") for row in self.execute_query("PRAGMA table_info(TB_RoleInventory)")}
            except Exception:
                existing = set()
        for column, ddl in columns.items():
            try:
                if self.backend == "postgres":
                    self.execute_non_query(f"ALTER TABLE TB_RoleInventory ADD COLUMN IF NOT EXISTS {column} {ddl}")
                elif column not in existing:
                    self.execute_non_query(f"ALTER TABLE TB_RoleInventory ADD COLUMN {column} {ddl}")
            except Exception:
                pass

    def _seed_item_definitions(self):
        count = self.execute_query("SELECT COUNT(*) AS C FROM TB_ItemDefinition")
        if count and int(count[0].get("C", count[0].get("c", 0))) > 0:
            return
        decoded_dir = os.path.join(SCRIPT_DIR, "game_resources", "decoded")
        files = ["iie.json", "iic.json", "iix.json", "iis.json", "iip.json", "iig.json", "iid.json"]
        inserted = 0
        for filename in files:
            path = os.path.join(decoded_dir, filename)
            if not os.path.exists(path):
                continue
            try:
                with open(path, "r", encoding="utf-8") as file:
                    items = json.load(file)
            except Exception:
                continue
            if not isinstance(items, list):
                continue
            for item in items:
                code = item.get("code")
                if not code:
                    continue
                props = item.get("properties") or {}
                if self.backend == "postgres":
                    sql = """
                    INSERT INTO TB_ItemDefinition
                    (ItemCode, ItemName, ItemType, ItemSubType, MainType, SubType, Quality,
                     IconRes, ModelRes, EquipModelCode, MaxStack, BuyPrice, SellPrice, ExtraDataJson)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ON CONFLICT (ItemCode) DO NOTHING
                    """
                else:
                    sql = """
                    INSERT OR IGNORE INTO TB_ItemDefinition
                    (ItemCode, ItemName, ItemType, ItemSubType, MainType, SubType, Quality,
                     IconRes, ModelRes, EquipModelCode, MaxStack, BuyPrice, SellPrice, ExtraDataJson)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """
                self.execute_non_query(
                    sql,
                    (
                        code,
                        item.get("name", code),
                        int(item.get("type") or 0),
                        int(item.get("subtype") or 0),
                        int(item.get("type") or 0),
                        int(item.get("subtype") or 0),
                        int(item.get("quality") or item.get("rank") or 1),
                        item.get("icon", ""),
                        props.get("modelCode", item.get("modelCode", "")),
                        props.get("modelCode", item.get("modelCode", "")),
                        int(item.get("stackSize") or 1),
                        int(item.get("goldPrice") or item.get("buyPrice") or 0),
                        int(item.get("sellPrice") or 0),
                        json.dumps(item, ensure_ascii=False),
                    ),
                )
                inserted += 1
        print(f"[DB] Item definitions carregadas: {inserted}")

    def _resource_item_stack_size(self, item_code: str) -> int:
        decoded_dir = os.path.join(SCRIPT_DIR, "game_resources", "decoded")
        for filename in ("iix.json", "iie.json", "iic.json", "iis.json", "iip.json", "iig.json", "iid.json"):
            path = os.path.join(decoded_dir, filename)
            if not os.path.exists(path):
                continue
            try:
                with open(path, "r", encoding="utf-8") as file:
                    items = json.load(file)
            except Exception:
                continue
            if not isinstance(items, list):
                continue
            for item in items:
                if item.get("code") != item_code:
                    continue
                try:
                    return max(1, int(item.get("stackSize") or item.get("maxStack") or 1))
                except (TypeError, ValueError):
                    return 1
        return 1

    def _role_id(self, role_name: str) -> int:
        rows = self.execute_query("SELECT Id FROM TB_Role WHERE Name=?", (role_name,))
        return int(rows[0]["Id"]) if rows else 0

    def add_item_to_inventory(self, role_name: str, item_code: str, count: int = 1, bag_index: int = 1) -> Dict:
        if count <= 0:
            return {"Success": False, "ErrorMsg": "Quantidade invalida"}
        role_id = self._role_id(role_name)
        if not role_id:
            return {"Success": False, "ErrorMsg": "Role nao encontrada"}
        capacity = 36
        rows = self.execute_query("SELECT BagCapacityPlayer FROM TB_Role WHERE Name=?", (role_name,))
        if rows:
            capacity = int(rows[0].get("BagCapacityPlayer") or 36)
        defs = self.execute_query("SELECT MaxStack FROM TB_ItemDefinition WHERE ItemCode=?", (item_code,))
        if not defs:
            return {"Success": False, "ErrorMsg": "Item inexistente"}
        max_stack = max(1, int(defs[0].get("MaxStack") or 1))
        resource_stack = self._resource_item_stack_size(item_code)
        if resource_stack > max_stack:
            max_stack = resource_stack
            self.execute_non_query("UPDATE TB_ItemDefinition SET MaxStack=? WHERE ItemCode=?", (max_stack, item_code))
        rows = self.execute_query(
            "SELECT InventoryID, SlotIndex, ItemCount FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND ItemCode=? ORDER BY SlotIndex",
            (role_name, bag_index, item_code),
        )
        occupied = {
            int(r["SlotIndex"])
            for r in self.execute_query("SELECT SlotIndex FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=?", (role_name, bag_index))
        }
        free_slots = [i for i in range(capacity) if i not in occupied]
        stack_space = sum(max_stack - int(r["ItemCount"]) for r in rows if int(r["ItemCount"]) < max_stack)
        needed_new = max(0, count - stack_space)
        needed_slots = (needed_new + max_stack - 1) // max_stack
        if needed_slots > len(free_slots):
            return {"Success": False, "ErrorMsg": "Inventario cheio"}

        remaining = count
        first_slot = None
        first_item_id = None
        for row in rows:
            current = int(row["ItemCount"])
            add = min(remaining, max_stack - current)
            if add > 0:
                self.execute_non_query("UPDATE TB_RoleInventory SET ItemCount=ItemCount+? WHERE InventoryID=?", (add, row["InventoryID"]))
                remaining -= add
                first_slot = first_slot if first_slot is not None else int(row["SlotIndex"])
            if remaining <= 0:
                break
        while remaining > 0:
            slot = free_slots.pop(0)
            item_id = str(uuid.uuid4())
            stack_count = min(remaining, max_stack)
            self.execute_non_query(
                "INSERT INTO TB_RoleInventory (Id, RoleId, RoleName, ItemId, ItemCode, BagIndex, SlotIndex, ItemCount) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?)",
                (role_id, role_name, item_id, item_code, bag_index, slot, stack_count),
            )
            first_slot = first_slot if first_slot is not None else slot
            first_item_id = first_item_id or item_id
            remaining -= stack_count
        return {"Success": True, "ErrorMsg": "", "SlotIndex": first_slot, "ItemId": first_item_id or ""}

    def purchase_item(self, role_name: str, item_code: str, count: int, currency: str, unit_price: int, bag_index: int = 1) -> Dict:
        if count <= 0 or unit_price < 0 or currency not in ("Gold", "Money"):
            return {"Success": False, "ErrorMsg": "Compra invalida"}
        def operation():
            role = self.execute_query(f"SELECT {currency} FROM TB_Role WHERE Name=?", (role_name,))
            total = int(unit_price) * int(count)
            if not role or int(role[0].get(currency) or 0) < total:
                return {"Success": False, "ErrorMsg": "Moeda insuficiente"}
            added = self.add_item_to_inventory(role_name, item_code, count, bag_index)
            if not added.get("Success"):
                return added
            changed = self.execute_non_query(
                f"UPDATE TB_Role SET {currency}={currency}-? WHERE Name=? AND {currency}>=?",
                (total, role_name, total),
            )
            if changed != 1:
                raise RuntimeError("Falha ao descontar moeda")
            new_value = self.execute_query(f"SELECT {currency} FROM TB_Role WHERE Name=?", (role_name,))[0][currency]
            return {**added, "Spent": total, "NewCurrency": int(new_value)}
        return self.run_transaction(operation)

    def purchase_items(self, role_name: str, purchases: List[Dict], currency: str, bag_index: int = 1) -> Dict:
        if currency not in ("Gold", "Money") or not purchases:
            return {"Success": False, "ErrorMsg": "Compra invalida"}
        def operation():
            total = sum(int(row["count"]) * int(row["unit_price"]) for row in purchases)
            role = self.execute_query(f"SELECT {currency} FROM TB_Role WHERE Name=?", (role_name,))
            if not role or int(role[0].get(currency) or 0) < total:
                return {"Success": False, "ErrorMsg": "Moeda insuficiente"}
            added = []
            for row in purchases:
                result = self.add_item_to_inventory(role_name, row["item_code"], int(row["count"]), bag_index)
                if not result.get("Success"):
                    raise ValueError(result.get("ErrorMsg", "Falha ao adicionar item"))
                added.append({**result, "ItemCode": row["item_code"], "ItemCount": int(row["count"])})
            changed = self.execute_non_query(f"UPDATE TB_Role SET {currency}={currency}-? WHERE Name=? AND {currency}>=?", (total, role_name, total))
            if changed != 1:
                raise RuntimeError("Falha ao descontar moeda")
            value = self.execute_query(f"SELECT {currency} FROM TB_Role WHERE Name=?", (role_name,))[0][currency]
            return {"Success": True, "Spent": total, "NewCurrency": int(value), "Added": added}
        try:
            return self.run_transaction(operation)
        except ValueError as exc:
            return {"Success": False, "ErrorMsg": str(exc)}

    def get_inventory_item_by_id(self, role_name: str, item_id: str) -> Optional[Dict]:
        rows = self.execute_query(
            "SELECT * FROM TB_RoleInventory WHERE RoleName=? AND ItemId=?",
            (role_name, item_id),
        )
        return rows[0] if rows else None

    def renew_inventory_item(self, role_name: str, item_id: str, renew_rule_index: int) -> Dict:
        row = self.get_inventory_item_by_id(role_name, item_id)
        if not row:
            return {"Success": False, "ErrorMsg": "Item nao encontrado"}
        self.execute_non_query(
            "UPDATE TB_RoleInventory SET RenewRuleIndex=? WHERE InventoryID=?",
            (int(renew_rule_index), row["InventoryID"]),
        )
        return {"Success": True, "ErrorMsg": "", "ItemId": item_id, "RenewRuleIndex": int(renew_rule_index)}

    def get_equipment_repair_info(self, role_name: str, equipment_id: str) -> Dict:
        row = self.get_inventory_item_by_id(role_name, equipment_id)
        if not row:
            return {"Success": False, "ErrorMsg": "Equipamento nao encontrado"}
        current = int(row.get("Durability") if row.get("Durability") is not None else 100)
        maximum = max(1, int(row.get("MaxDurability") if row.get("MaxDurability") is not None else 100))
        missing = max(0, maximum - current)
        return {
            "Success": True,
            "Item": row,
            "Durability": current,
            "MaxDurability": maximum,
            "IsWornOut": current <= 0,
            "IsFullDurability": missing <= 0,
            "RepairGold": missing,
            "PerfectRepairGold": missing * 2,
        }

    def repair_equipment(self, role_name: str, equipment_id: str, is_perfect: bool) -> Dict:
        def operation():
            info = self.get_equipment_repair_info(role_name, equipment_id)
            if not info.get("Success"):
                return info
            cost = int(info["PerfectRepairGold"] if is_perfect else info["RepairGold"])
            role = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (role_name,))
            if not role:
                return {"Success": False, "ErrorMsg": "Role nao encontrada"}
            if int(role[0].get("Gold") or 0) < cost:
                return {"Success": False, "ErrorMsg": "Gold insuficiente"}
            self.execute_non_query(
                "UPDATE TB_RoleInventory SET Durability=MaxDurability WHERE InventoryID=?",
                (info["Item"]["InventoryID"],),
            )
            if cost:
                self.execute_non_query(
                    "UPDATE TB_Role SET Gold=Gold-? WHERE Name=? AND Gold>=?",
                    (cost, role_name, cost),
                )
            new_gold = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (role_name,))[0]["Gold"]
            return {
                "Success": True,
                "ErrorMsg": "",
                "Cost": cost,
                "NewGold": int(new_gold),
                "Durability": int(info["MaxDurability"]),
                "MaxDurability": int(info["MaxDurability"]),
            }
        return self.run_transaction(operation)

    def sell_inventory_items(self, role_name: str, bag_index: int, slot_indexes: List[int]) -> Dict:
        if not slot_indexes:
            return {"Success": False, "ErrorMsg": "Nenhum item selecionado"}
        from item_config_loader import item_config
        def operation():
            total = 0
            for slot in sorted(set(int(x) for x in slot_indexes)):
                rows = self.execute_query(
                    "SELECT i.InventoryID, i.ItemCount, i.ItemCode, d.SellPrice FROM TB_RoleInventory i LEFT JOIN TB_ItemDefinition d ON d.ItemCode=i.ItemCode WHERE i.RoleName=? AND i.BagIndex=? AND i.SlotIndex=?",
                    (role_name, bag_index, slot),
                )
                if not rows:
                    raise ValueError("Item nao encontrado no inventario")
                item_code = rows[0]["ItemCode"]
                sell_price = int(rows[0].get("SellPrice") or 0)
                # Fallback to iie.json for items not in TB_ItemDefinition
                if sell_price <= 0:
                    resource_def = item_config.get_item(item_code)
                    if resource_def:
                        sell_price = int(resource_def.get("recycleGoldPrice", 0) or 0)
                if sell_price <= 0:
                    raise ValueError("Item nao pode ser vendido")
                total += int(rows[0]["ItemCount"]) * sell_price
                self.execute_non_query("DELETE FROM TB_RoleInventory WHERE InventoryID=?", (rows[0]["InventoryID"],))
            self.execute_non_query("UPDATE TB_Role SET Gold=Gold+? WHERE Name=?", (total, role_name))
            gold = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (role_name,))[0]["Gold"]
            return {"Success": True, "GoldAdded": total, "NewGold": int(gold)}
        try:
            return self.run_transaction(operation)
        except ValueError as exc:
            return {"Success": False, "ErrorMsg": str(exc)}

    def split_inventory_item(self, role_name: str, bag_index: int, from_slot: int, to_slot: int, count: int) -> Dict:
        if count <= 0:
            return {"Success": False, "ErrorMsg": "Quantidade invalida"}
        def operation():
            source = self.execute_query("SELECT * FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?", (role_name, bag_index, from_slot))
            dest = self.execute_query("SELECT 1 FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?", (role_name, bag_index, to_slot))
            if not source or dest or int(source[0]["ItemCount"]) <= count:
                return {"Success": False, "ErrorMsg": "Divisao invalida"}
            row = source[0]
            self.execute_non_query("UPDATE TB_RoleInventory SET ItemCount=ItemCount-? WHERE InventoryID=?", (count, row["InventoryID"]))
            self.execute_non_query(
                "INSERT INTO TB_RoleInventory (Id, RoleId, RoleName, ItemId, ItemCode, BagIndex, SlotIndex, ItemCount, IsBound, EnhanceLevel, ExtraData, ExtraDataJson) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                (row["RoleId"], role_name, str(uuid.uuid4()), row["ItemCode"], bag_index, to_slot, count, row.get("IsBound", 0), row.get("EnhanceLevel", 0), row.get("ExtraData"), row.get("ExtraDataJson")),
            )
            return {"Success": True, "ErrorMsg": ""}
        return self.run_transaction(operation)

    def move_inventory_item_cross_bag(self, role_name: str, from_bag: int, from_slot: int, to_bag: int, to_slot: int) -> Dict:
        def operation():
            source = self.execute_query("SELECT InventoryID FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?", (role_name, from_bag, from_slot))
            if not source:
                return {"Success": False, "ErrorMsg": "Item origem nao encontrado"}
            dest = self.execute_query("SELECT InventoryID FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?", (role_name, to_bag, to_slot))
            if dest:
                temp_bag, temp_slot = -1, -100000 - from_slot
                self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (temp_bag, temp_slot, source[0]["InventoryID"]))
                self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (from_bag, from_slot, dest[0]["InventoryID"]))
            self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (to_bag, to_slot, source[0]["InventoryID"]))
            return {"Success": True, "ErrorMsg": ""}
        return self.run_transaction(operation)

    def move_inventory_item(self, role_name: str, bag_index: int, from_slot: int, to_slot: int) -> Dict:
        source = self.execute_query(
            "SELECT InventoryID FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
            (role_name, bag_index, from_slot),
        )
        if not source:
            return {"Success": False, "ErrorMsg": "Item origem nao encontrado"}
        dest = self.execute_query(
            "SELECT InventoryID FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
            (role_name, bag_index, to_slot),
        )
        if dest:
            temp = -100000 - from_slot
            self.execute_non_query("UPDATE TB_RoleInventory SET SlotIndex=? WHERE InventoryID=?", (temp, source[0]["InventoryID"]))
            self.execute_non_query("UPDATE TB_RoleInventory SET SlotIndex=? WHERE InventoryID=?", (from_slot, dest[0]["InventoryID"]))
            self.execute_non_query("UPDATE TB_RoleInventory SET SlotIndex=? WHERE InventoryID=?", (to_slot, source[0]["InventoryID"]))
        else:
            self.execute_non_query("UPDATE TB_RoleInventory SET SlotIndex=? WHERE InventoryID=?", (to_slot, source[0]["InventoryID"]))
        return {"Success": True, "ErrorMsg": ""}

    def remove_item(self, role_name: str, bag_index: int, slot_index: int, count=None) -> Dict:
        rows = self.execute_query(
            "SELECT InventoryID, ItemCount FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
            (role_name, bag_index, slot_index),
        )
        if not rows:
            return {"Success": False, "ErrorMsg": "Item nao encontrado", "RemainingCount": 0}
        current = int(rows[0]["ItemCount"])
        remove_count = current if count is None else int(count)
        remaining = current - remove_count
        if remaining > 0:
            self.execute_non_query("UPDATE TB_RoleInventory SET ItemCount=? WHERE InventoryID=?", (remaining, rows[0]["InventoryID"]))
        else:
            self.execute_non_query("DELETE FROM TB_RoleInventory WHERE InventoryID=?", (rows[0]["InventoryID"],))
            remaining = 0
        return {"Success": True, "ErrorMsg": "", "RemainingCount": remaining}

    def remove_inventory_item_by_id(self, role_name: str, item_id: str, count=None) -> Dict:
        rows = self.execute_query(
            "SELECT BagIndex, SlotIndex FROM TB_RoleInventory WHERE RoleName=? AND ItemId=?",
            (role_name, item_id),
        )
        if not rows:
            return {"Success": False, "ErrorMsg": "Item nao encontrado", "RemainingCount": 0}
        return self.remove_item(role_name, int(rows[0]["BagIndex"]), int(rows[0]["SlotIndex"]), count)

    def agent_sell_item(self, role_name: str, bag_index: int, item_index: int, price: int) -> Dict:
        if price < 0:
            return {"Success": False, "ErrorMsg": "Preco invalido"}
        def operation():
            rows = self.execute_query(
                "SELECT * FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
                (role_name, bag_index, item_index),
            )
            if not rows:
                return {"Success": False, "ErrorMsg": "Item nao encontrado"}
            item = rows[0]
            self.execute_non_query("DELETE FROM TB_RoleInventory WHERE InventoryID=?", (item["InventoryID"],))
            self.execute_non_query(
                "INSERT INTO TB_AgentItem (SellerRoleName, ItemId, ItemCode, ItemCount, Price, State) VALUES (?, ?, ?, ?, ?, 0)",
                (role_name, item["ItemId"], item["ItemCode"], int(item.get("ItemCount") or 1), int(price)),
            )
            rec = self.execute_query("SELECT MAX(AgentRecId) AS AgentRecId FROM TB_AgentItem WHERE SellerRoleName=?", (role_name,))[0]
            return {"Success": True, "AgentRecId": int(rec["AgentRecId"]), "Item": item}
        return self.run_transaction(operation)

    def list_agent_items(self, role_name: str = None, subtype: int = 0, name: str = "") -> List[Dict]:
        sql = "SELECT * FROM TB_AgentItem WHERE State=0"
        params = []
        if role_name:
            sql += " AND SellerRoleName=?"
            params.append(role_name)
        if name:
            sql += " AND (ItemCode LIKE ? OR ItemId LIKE ?)"
            params.extend([f"%{name}%", f"%{name}%"])
        sql += " ORDER BY AgentRecId DESC"
        return self.execute_query(sql, tuple(params))

    def agent_cancel_or_take_back(self, role_name: str, agent_rec_id: int) -> Dict:
        def operation():
            rows = self.execute_query("SELECT * FROM TB_AgentItem WHERE AgentRecId=? AND SellerRoleName=? AND State=0", (agent_rec_id, role_name))
            if not rows:
                return {"Success": False, "ErrorMsg": "Registro nao encontrado"}
            item = rows[0]
            added = self.add_item_to_inventory(role_name, item["ItemCode"], int(item.get("ItemCount") or 1), 1)
            if not added.get("Success"):
                return added
            self.execute_non_query("DELETE FROM TB_AgentItem WHERE AgentRecId=?", (agent_rec_id,))
            return {"Success": True, "Added": added, "Item": item}
        return self.run_transaction(operation)

    def agent_buy_item(self, buyer_role_name: str, agent_rec_id: int) -> Dict:
        def operation():
            rows = self.execute_query("SELECT * FROM TB_AgentItem WHERE AgentRecId=? AND State=0", (agent_rec_id,))
            if not rows:
                return {"Success": False, "ErrorMsg": "Item nao encontrado"}
            item = rows[0]
            if item["SellerRoleName"] == buyer_role_name:
                return {"Success": False, "ErrorMsg": "Nao pode comprar proprio item"}
            price = int(item.get("Price") or 0)
            role = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (buyer_role_name,))
            if not role or int(role[0].get("Gold") or 0) < price:
                return {"Success": False, "ErrorMsg": "Gold insuficiente"}
            added = self.add_item_to_inventory(buyer_role_name, item["ItemCode"], int(item.get("ItemCount") or 1), 1)
            if not added.get("Success"):
                return added
            self.execute_non_query("UPDATE TB_Role SET Gold=Gold-? WHERE Name=? AND Gold>=?", (price, buyer_role_name, price))
            self.execute_non_query("UPDATE TB_Role SET Gold=Gold+? WHERE Name=?", (price, item["SellerRoleName"]))
            self.execute_non_query("DELETE FROM TB_AgentItem WHERE AgentRecId=?", (agent_rec_id,))
            gold = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (buyer_role_name,))[0]["Gold"]
            return {"Success": True, "Added": added, "Item": item, "NewGold": int(gold)}
        return self.run_transaction(operation)

    def set_booth(self, role_name: str, title: str, is_booth: bool, sell_items: List[Dict] = None, purchase_items: List[Dict] = None) -> Dict:
        def operation():
            if self.backend == "postgres":
                self.execute_non_query(
                    "INSERT INTO TB_RoleBooth (RoleName, BoothTitle, IsBooth) VALUES (?, ?, ?) ON CONFLICT(RoleName) DO UPDATE SET BoothTitle=excluded.BoothTitle, IsBooth=excluded.IsBooth, UpdatedAt=CURRENT_TIMESTAMP",
                    (role_name, title, 1 if is_booth else 0),
                )
            else:
                self.execute_non_query(
                    "INSERT OR REPLACE INTO TB_RoleBooth (RoleName, BoothTitle, IsBooth, UpdatedAt) VALUES (?, ?, ?, CURRENT_TIMESTAMP)",
                    (role_name, title, 1 if is_booth else 0),
                )
            self.execute_non_query("DELETE FROM TB_BoothItem WHERE OwnerRoleName=?", (role_name,))
            if is_booth:
                for item in sell_items or []:
                    self.execute_non_query(
                        "INSERT INTO TB_BoothItem (OwnerRoleName, ItemIndex, ItemId, ItemCode, ItemCount, ItemPrice, Kind) VALUES (?, ?, ?, ?, ?, ?, 'sell')",
                        (role_name, int(item["item_index"]), item["item_id"], item["item_code"], int(item["count"]), int(item["price"])),
                    )
                for item in purchase_items or []:
                    self.execute_non_query(
                        "INSERT INTO TB_BoothItem (OwnerRoleName, ItemIndex, ItemId, ItemCode, ItemCount, ItemPrice, Kind) VALUES (?, ?, ?, ?, ?, ?, 'purchase')",
                        (role_name, int(item["item_index"]), item.get("item_id", ""), item["item_code"], int(item["count"]), int(item["price"])),
                    )
            return {"Success": True}
        return self.run_transaction(operation)

    def get_booth(self, owner_role_name: str) -> Dict:
        rows = self.execute_query("SELECT * FROM TB_RoleBooth WHERE RoleName=?", (owner_role_name,))
        booth = rows[0] if rows else {"RoleName": owner_role_name, "BoothTitle": "", "IsBooth": 0}
        items = self.execute_query("SELECT * FROM TB_BoothItem WHERE OwnerRoleName=? ORDER BY Kind, ItemIndex", (owner_role_name,))
        return {
            "RoleName": owner_role_name,
            "BoothTitle": booth.get("BoothTitle") or "",
            "IsBooth": bool(int(booth.get("IsBooth") or 0)),
            "SellItems": [i for i in items if i.get("Kind") == "sell"],
            "PurchaseItems": [i for i in items if i.get("Kind") == "purchase"],
        }

    def booth_buy_item(self, buyer_role_name: str, owner_role_name: str, item_index: int) -> Dict:
        def operation():
            rows = self.execute_query("SELECT * FROM TB_BoothItem WHERE OwnerRoleName=? AND ItemIndex=? AND Kind='sell'", (owner_role_name, item_index))
            if not rows:
                return {"Success": False, "ErrorMsg": "Item nao encontrado"}
            item = rows[0]
            price = int(item.get("ItemPrice") or 0)
            role = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (buyer_role_name,))
            if not role or int(role[0].get("Gold") or 0) < price:
                return {"Success": False, "ErrorMsg": "Gold insuficiente"}
            removed = self.remove_inventory_item_by_id(owner_role_name, item["ItemId"], int(item.get("ItemCount") or 1))
            if not removed.get("Success"):
                return removed
            added = self.add_item_to_inventory(buyer_role_name, item["ItemCode"], int(item.get("ItemCount") or 1), 1)
            if not added.get("Success"):
                raise ValueError(added.get("ErrorMsg", "Falha ao adicionar item"))
            self.execute_non_query("UPDATE TB_Role SET Gold=Gold-? WHERE Name=? AND Gold>=?", (price, buyer_role_name, price))
            self.execute_non_query("UPDATE TB_Role SET Gold=Gold+? WHERE Name=?", (price, owner_role_name))
            self.execute_non_query("DELETE FROM TB_BoothItem WHERE BoothItemId=?", (item["BoothItemId"],))
            gold = self.execute_query("SELECT Gold FROM TB_Role WHERE Name=?", (buyer_role_name,))[0]["Gold"]
            return {"Success": True, "Item": item, "Added": added, "NewGold": int(gold)}
        try:
            return self.run_transaction(operation)
        except ValueError as exc:
            return {"Success": False, "ErrorMsg": str(exc)}

    def armory_upgrade(self, role_name: str, exp_add: int = 1) -> Dict:
        rows = self.execute_query("SELECT SUM(ArmoryExp) AS Exp FROM TB_RoleArmory WHERE RoleName=?", (role_name,))
        current = int((rows[0].get("Exp") if rows else 0) or 0) + int(exp_add)
        level = max(1, current // 100 + 1)
        grid = "default"
        if self.backend == "postgres":
            self.execute_non_query(
                "INSERT INTO TB_RoleArmory (RoleName, GridToMCName, ArmoryLevel, ArmoryExp) VALUES (?, ?, ?, ?) ON CONFLICT(RoleName, GridToMCName) DO UPDATE SET ArmoryLevel=excluded.ArmoryLevel, ArmoryExp=excluded.ArmoryExp",
                (role_name, grid, level, current),
            )
        else:
            self.execute_non_query(
                "INSERT OR REPLACE INTO TB_RoleArmory (RoleName, GridToMCName, GridKind, ArmoryLevel, ArmoryExp) VALUES (?, ?, 0, ?, ?)",
                (role_name, grid, level, current),
            )
        return {"Success": True, "ArmoryExp": current, "ArmoryLevel": level}

    def wardrobe_add(self, role_name: str, item_id: str) -> Dict:
        def operation():
            row = self.get_inventory_item_by_id(role_name, item_id)
            if not row:
                return {"Success": False, "ErrorMsg": "Item nao encontrado"}
            idx_row = self.execute_query("SELECT COALESCE(MAX(WardrobeIndex), -1) + 1 AS NextIndex FROM TB_RoleWardrobe WHERE RoleName=?", (role_name,))[0]
            index = int(idx_row.get("NextIndex") or 0)
            self.execute_non_query(
                "INSERT INTO TB_RoleWardrobe (RoleName, WardrobeIndex, ItemId, ItemCode, ItemCount, WardrobeLevel) VALUES (?, ?, ?, ?, ?, 1)",
                (role_name, index, row["ItemId"], row["ItemCode"], int(row.get("ItemCount") or 1)),
            )
            self.remove_inventory_item_by_id(role_name, item_id)
            return {"Success": True, "Index": index}
        return self.run_transaction(operation)

    def wardrobe_remove(self, role_name: str, index: int, item_id: str) -> Dict:
        def operation():
            rows = self.execute_query("SELECT * FROM TB_RoleWardrobe WHERE RoleName=? AND WardrobeIndex=? AND ItemId=?", (role_name, index, item_id))
            if not rows:
                return {"Success": False, "ErrorMsg": "Wardrobe item nao encontrado"}
            item = rows[0]
            added = self.add_item_to_inventory(role_name, item["ItemCode"], int(item.get("ItemCount") or 1), 1)
            if not added.get("Success"):
                return added
            self.execute_non_query("DELETE FROM TB_RoleWardrobe WHERE RoleName=? AND WardrobeIndex=?", (role_name, index))
            return {"Success": True, "Added": added}
        return self.run_transaction(operation)

    def wardrobe_uplevel(self, role_name: str) -> Dict:
        self.execute_non_query("UPDATE TB_RoleWardrobe SET WardrobeLevel=WardrobeLevel+1 WHERE RoleName=?", (role_name,))
        rows = self.execute_query("SELECT COALESCE(MAX(WardrobeLevel), 1) AS Lv, COUNT(*) AS Cnt FROM TB_RoleWardrobe WHERE RoleName=?", (role_name,))
        return {"Success": True, "Level": int(rows[0].get("Lv") or 1), "Count": int(rows[0].get("Cnt") or 0)}

    def list_wardrobe(self, role_name: str) -> List[Dict]:
        return self.execute_query("SELECT * FROM TB_RoleWardrobe WHERE RoleName=? ORDER BY WardrobeIndex", (role_name,))

    def artifact_update(self, role_name: str, equipment_id: str, **changes) -> Dict:
        state = self.execute_query("SELECT * FROM TB_RoleArtifactState WHERE RoleName=? AND EquipmentItemId=?", (role_name, equipment_id))
        values = {
            "HoleCount": int(changes.get("HoleCount", state[0].get("HoleCount") if state else 0) or 0),
            "RefineLevel": int(changes.get("RefineLevel", state[0].get("RefineLevel") if state else 0) or 0),
            "SoulLevel": int(changes.get("SoulLevel", state[0].get("SoulLevel") if state else 0) or 0),
            "EquLevel": int(changes.get("EquLevel", state[0].get("EquLevel") if state else 0) or 0),
            "EquExp": int(changes.get("EquExp", state[0].get("EquExp") if state else 0) or 0),
            "WashPoint": float(changes.get("WashPoint", state[0].get("WashPoint") if state else 0) or 0),
            "LetteringWord": changes.get("LetteringWord", state[0].get("LetteringWord") if state else None),
        }
        if state:
            self.execute_non_query(
                "UPDATE TB_RoleArtifactState SET HoleCount=?, RefineLevel=?, SoulLevel=?, EquLevel=?, EquExp=?, WashPoint=?, LetteringWord=? WHERE RoleName=? AND EquipmentItemId=?",
                (values["HoleCount"], values["RefineLevel"], values["SoulLevel"], values["EquLevel"], values["EquExp"], values["WashPoint"], values["LetteringWord"], role_name, equipment_id),
            )
        else:
            self.execute_non_query(
                "INSERT INTO TB_RoleArtifactState (RoleName, EquipmentItemId, HoleCount, RefineLevel, SoulLevel, EquLevel, EquExp, WashPoint, LetteringWord) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                (role_name, equipment_id, values["HoleCount"], values["RefineLevel"], values["SoulLevel"], values["EquLevel"], values["EquExp"], values["WashPoint"], values["LetteringWord"]),
            )
        return {"Success": True, **values}

    def kind_grow_get(self, role_name: str, kind: int) -> Dict:
        rows = self.execute_query("SELECT * FROM TB_RoleKindGrow WHERE RoleName=? AND Kind=?", (role_name, kind))
        if rows:
            return rows[0]
        return {"RoleName": role_name, "Kind": kind, "Level": 0, "Exp": 0, "TemperJson": None, "NewTemperJson": None}

    def kind_grow_save(self, role_name: str, kind: int, level: int, exp: int, temper=None, new_temper=None) -> Dict:
        temper_json = json.dumps(temper or {}, ensure_ascii=False)
        new_temper_json = json.dumps(new_temper or {}, ensure_ascii=False)
        if self.backend == "postgres":
            self.execute_non_query(
                "INSERT INTO TB_RoleKindGrow (RoleName, Kind, Level, Exp, TemperJson, NewTemperJson) VALUES (?, ?, ?, ?, ?, ?) ON CONFLICT(RoleName, Kind) DO UPDATE SET Level=excluded.Level, Exp=excluded.Exp, TemperJson=excluded.TemperJson, NewTemperJson=excluded.NewTemperJson",
                (role_name, kind, level, exp, temper_json, new_temper_json),
            )
        else:
            self.execute_non_query(
                "INSERT OR REPLACE INTO TB_RoleKindGrow (RoleName, Kind, Level, Exp, TemperJson, NewTemperJson) VALUES (?, ?, ?, ?, ?, ?)",
                (role_name, kind, level, exp, temper_json, new_temper_json),
            )
        return self.kind_grow_get(role_name, kind)

    def equip_item(self, role_name: str, from_bag: int, from_slot: int, to_bag: int, to_slot: int) -> Dict:
        source = self.execute_query(
            "SELECT InventoryID FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
            (role_name, from_bag, from_slot),
        )
        if not source:
            return {"Success": False, "ErrorMsg": "Item origem nao encontrado", "SwappedItemCode": None}
        dest = self.execute_query(
            "SELECT InventoryID, ItemCode FROM TB_RoleInventory WHERE RoleName=? AND BagIndex=? AND SlotIndex=?",
            (role_name, to_bag, to_slot),
        )
        swapped = dest[0]["ItemCode"] if dest else None
        if dest:
            temp = -100000 - from_slot
            self.execute_non_query("UPDATE TB_RoleInventory SET SlotIndex=? WHERE InventoryID=?", (temp, source[0]["InventoryID"]))
            self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (from_bag, from_slot, dest[0]["InventoryID"]))
            self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (to_bag, to_slot, source[0]["InventoryID"]))
        else:
            self.execute_non_query("UPDATE TB_RoleInventory SET BagIndex=?, SlotIndex=? WHERE InventoryID=?", (to_bag, to_slot, source[0]["InventoryID"]))
        return {"Success": True, "ErrorMsg": "", "SwappedItemCode": swapped}


DatabaseManager = Database


class AccountRepository:
    def __init__(self, db: Database):
        self.db = db

    def get_account(self, username: str) -> Optional[Dict]:
        result = self.db.execute_query(
            "SELECT Id, Username, PasswordHash, Status FROM TB_Account WHERE Username=?",
            (username,),
        )
        if not result:
            return None
        r = result[0]
        return {
            "AccountUID": r.get("Id"),
            "Username": r.get("Username"),
            "LoginPwd": r.get("PasswordHash", ""),
            "IsBanned": int(r.get("Status", 1)) == 0,
            "IsAdult": True,
        }

    def create_session(self, account_id: int, client_ip: str) -> Dict:
        ticket = str(uuid.uuid4())
        expires = (datetime.now() + timedelta(hours=12)).isoformat(timespec="seconds")
        self.db.execute_non_query("DELETE FROM TB_Session WHERE AccountId=?", (account_id,))
        self.db.execute_non_query(
            """
            INSERT INTO TB_Session (AccountId, SessionKey, ClientIP, IPAddress, ServerId, ExpiresAt)
            VALUES (?, ?, ?, ?, 1, ?)
            """,
            (account_id, ticket, client_ip, client_ip, expires),
        )
        return {"Ticket": ticket}

    def authenticate(self, username: str, password: str) -> Optional[Dict]:
        result = self.db.execute_query(
            "SELECT Id, Username, Status FROM TB_Account WHERE Username=? AND PasswordHash=?",
            (username, password),
        )
        return result[0] if result else None


class ServerRepository:
    def __init__(self, db: Database):
        self.db = db

    def get_server_list(self) -> List[Dict]:
        return self.db.execute_query(
            "SELECT Id as ServerID, ServerName, ServerIP, ServerPort, Status FROM TB_Server WHERE Status=1"
        )


class RoleRepository:
    def __init__(self, db: Database):
        self.db = db

    def get_account_by_ticket(self, ticket: str) -> Optional[Dict]:
        result = self.db.execute_query(
            "SELECT AccountId as AccountUID FROM TB_Session WHERE SessionKey=?",
            (ticket,),
        )
        return result[0] if result else {"AccountUID": 1}

    def get_roles_by_account(self, account_id) -> List[Dict]:
        return self.db.execute_query(
            "SELECT * FROM TB_Role WHERE AccountId=? AND DeletedFlag=0",
            (account_id,),
        )

    def check_name(self, name: str) -> bool:
        result = self.db.execute_query("SELECT 1 FROM TB_Role WHERE Name=?", (name,))
        return len(result) == 0

    def create_role(
        self,
        account_uid: int = None,
        account_id: int = None,
        name: str = "",
        job_code: int = 1,
        sex: int = 0,
        head_icon_index: int = 0,
        hair_style_index: int = 0,
        data: Dict = None,
    ) -> Dict:
        acc_id = account_uid or account_id or 1
        if data:
            name = data.get("name", name)
            job_code = data.get("jobCode", job_code)
            sex = data.get("sex", sex)
            head_icon_index = data.get("headIconIndex", head_icon_index)
            hair_style_index = data.get("hairStyleIndex", hair_style_index)

        self.db.execute_non_query(
            """
            INSERT INTO TB_Role
            (AccountId, Name, JobCode, Sex, Level, HeadIconIndex, HairStyleIndex, MapId, PosX, PosY)
            VALUES (?, ?, ?, ?, 1, ?, ?, 'a1', 1120, 2080)
            """,
            (acc_id, name, max(1, int(job_code or 1)), sex, head_icon_index, hair_style_index),
        )
        result = self.db.execute_query("SELECT * FROM TB_Role WHERE Name=?", (name,))
        if result:
            r = result[0]
            return {
                "Status": 0,
                "RoleID": r.get("Id"),
                "Name": r.get("Name"),
                "JobCode": r.get("JobCode"),
                "Sex": r.get("Sex"),
                "Level": r.get("Level", 1),
                "HeadIconIndex": r.get("HeadIconIndex", 0),
                "HairStyleIndex": r.get("HairStyleIndex", 0),
                "AccountUID": acc_id,
                "CreateTime": str(r.get("CreatedAt", "")),
                "LastPlayTime": str(r.get("LastPlayTime", "")),
            }
        return {"Status": 1, "Message": "Erro ao criar"}

    def delete_role(self, account_id: int, name: str) -> bool:
        return self.db.execute_non_query(
            "UPDATE TB_Role SET DeletedFlag=1 WHERE AccountId=? AND Name=?",
            (account_id, name),
        ) > 0

    def select_role(self, account_id: int, name: str, password: str = None) -> Dict:
        result = self.db.execute_query(
            "SELECT 1 FROM TB_Role WHERE AccountId=? AND Name=? AND DeletedFlag=0",
            (account_id, name),
        )
        if result:
            self.db.execute_non_query(
                "UPDATE TB_Role SET LastPlayTime=CURRENT_TIMESTAMP WHERE AccountId=? AND Name=?",
                (account_id, name),
            )
            return {"IsDone": True, "FailureReason": ""}
        return {"IsDone": False, "FailureReason": "Personagem nao encontrado"}


def get_db() -> Database:
    global _db_instance
    if not _db_instance:
        _db_instance = Database()
    return _db_instance


def get_account_repo() -> AccountRepository:
    return AccountRepository(get_db())


def get_server_repo() -> ServerRepository:
    return ServerRepository(get_db())


def get_role_repo() -> RoleRepository:
    return RoleRepository(get_db())
