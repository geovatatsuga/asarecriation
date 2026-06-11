-- Advanced inventory systems for the Python/PostgreSQL runtime.
-- Safe to run multiple times against the main mspt1 database.

CREATE TABLE IF NOT EXISTS TB_AgentItem (
    AgentRecId SERIAL PRIMARY KEY,
    SellerRoleName TEXT NOT NULL,
    ItemId TEXT NOT NULL,
    ItemCode TEXT NOT NULL,
    ItemCount INTEGER DEFAULT 1,
    Price INTEGER DEFAULT 0,
    State INTEGER DEFAULT 0,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS TB_RoleBooth (
    RoleName TEXT PRIMARY KEY,
    BoothTitle TEXT,
    IsBooth INTEGER DEFAULT 0,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

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
);

CREATE TABLE IF NOT EXISTS TB_RoleArmory (
    RoleName TEXT NOT NULL,
    GridToMCName TEXT NOT NULL,
    GridKind INTEGER DEFAULT 0,
    EquipmentItemId TEXT,
    ArmoryLevel INTEGER DEFAULT 1,
    ArmoryExp INTEGER DEFAULT 0,
    PRIMARY KEY(RoleName, GridToMCName)
);

CREATE TABLE IF NOT EXISTS TB_RoleWardrobe (
    RoleName TEXT NOT NULL,
    WardrobeIndex INTEGER NOT NULL,
    ItemId TEXT NOT NULL,
    ItemCode TEXT NOT NULL,
    ItemCount INTEGER DEFAULT 1,
    WardrobeLevel INTEGER DEFAULT 1,
    PRIMARY KEY(RoleName, WardrobeIndex)
);

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
);

CREATE TABLE IF NOT EXISTS TB_RoleKindGrow (
    RoleName TEXT NOT NULL,
    Kind INTEGER NOT NULL,
    Level INTEGER DEFAULT 0,
    Exp INTEGER DEFAULT 0,
    TemperJson TEXT,
    NewTemperJson TEXT,
    PRIMARY KEY(RoleName, Kind)
);

ALTER TABLE TB_RoleInventory ADD COLUMN IF NOT EXISTS Durability INTEGER DEFAULT 100;
ALTER TABLE TB_RoleInventory ADD COLUMN IF NOT EXISTS MaxDurability INTEGER DEFAULT 100;
ALTER TABLE TB_RoleInventory ADD COLUMN IF NOT EXISTS RenewRuleIndex INTEGER DEFAULT 0;
