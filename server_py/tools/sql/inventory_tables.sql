-- ==============================================
-- Asa de Cristal - Inventory & Item Tables
-- Tabelas de Itens, Inventário, Equipamentos
-- ==============================================

-- ==============================================
-- ITEM DEFINITION (Configuração de todos os itens)
-- ==============================================
USE mspt1;
GO

IF OBJECT_ID('TB_ItemDefinition', 'U') IS NOT NULL DROP TABLE TB_ItemDefinition;
GO

CREATE TABLE TB_ItemDefinition (
    ItemCode NVARCHAR(50) PRIMARY KEY,
    ItemName NVARCHAR(100) NOT NULL,
    
    -- Classification
    MainType INT NOT NULL,                 -- Tipo principal
    SubType INT NOT NULL,                  -- Subtipo (equipamento, consumível, etc.)
    Quality TINYINT DEFAULT 1,             -- 1=Comum, 2=Incomum, 3=Raro, 4=Épico, 5=Lendário
    
    -- Visual
    IconRes NVARCHAR(100) NULL,
    ModelRes NVARCHAR(100) NULL,
    Description NVARCHAR(500) NULL,
    
    -- Stack & Trade
    MaxStack INT DEFAULT 1,
    IsTradeable BIT DEFAULT 1,
    IsSellable BIT DEFAULT 1,
    IsDroppable BIT DEFAULT 1,
    BindType TINYINT DEFAULT 0,            -- 0=None, 1=OnPickup, 2=OnEquip
    
    -- Requirements
    RequiredLevel INT DEFAULT 0,
    RequiredJob TINYINT DEFAULT 0,         -- 0=Todos
    RequiredSex TINYINT DEFAULT 0,         -- 0=Todos, 1=Male, 2=Female
    
    -- Economics
    BuyPrice INT DEFAULT 0,
    SellPrice INT DEFAULT 0,
    CrystalPrice INT DEFAULT 0,
    
    -- Equipment specific
    EquipSlot TINYINT NULL,                -- Slot onde equipa (0-14)
    EquipModelCode NVARCHAR(50) NULL,
    
    -- Combat Stats (para equipamentos)
    HP INT DEFAULT 0,
    MP INT DEFAULT 0,
    PhysicalAttack INT DEFAULT 0,
    MagicAttack INT DEFAULT 0,
    PhysicalDefense INT DEFAULT 0,
    MagicDefense INT DEFAULT 0,
    HitValue INT DEFAULT 0,
    DodgeValue INT DEFAULT 0,
    CritValue INT DEFAULT 0,
    CritDamage INT DEFAULT 0,
    AttackSpeed INT DEFAULT 0,
    MoveSpeed INT DEFAULT 0,
    
    -- Attributes bonus
    BonusForce INT DEFAULT 0,
    BonusAgility INT DEFAULT 0,
    BonusVitality INT DEFAULT 0,
    BonusSpirit INT DEFAULT 0,
    
    -- Consumable effects
    UseEffect NVARCHAR(100) NULL,
    UseCooldown INT DEFAULT 0,
    HealHP INT DEFAULT 0,
    HealMP INT DEFAULT 0,
    BuffId INT NULL,
    
    -- Extra data
    ExtraDataJson NVARCHAR(MAX) NULL,
    
    INDEX IX_Item_MainType (MainType),
    INDEX IX_Item_SubType (SubType),
    INDEX IX_Item_Quality (Quality)
);
GO

-- ==============================================
-- ROLE INVENTORY (Itens no inventário do personagem)
-- ==============================================

IF OBJECT_ID('TB_RoleInventory', 'U') IS NOT NULL DROP TABLE TB_RoleInventory;
GO

CREATE TABLE TB_RoleInventory (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    RoleName NVARCHAR(50) NOT NULL,
    
    -- Item identification
    ItemId NVARCHAR(50) NOT NULL,          -- UUID único do item
    ItemCode NVARCHAR(50) NOT NULL,        -- Código do item (FK para TB_ItemDefinition)
    
    -- Position
    BagIndex TINYINT NOT NULL,             -- 1=Player, 2=Pet, 3=Ride, 10=Equipment
    SlotIndex INT NOT NULL,
    
    -- Quantity
    ItemCount INT DEFAULT 1,
    
    -- Durability
    Durability INT DEFAULT 100,
    MaxDurability INT DEFAULT 100,
    
    -- Enhancement
    EnhanceLevel INT DEFAULT 0,
    EnhanceExp INT DEFAULT 0,
    
    -- Sockets/Gems
    Socket1 NVARCHAR(50) NULL,
    Socket2 NVARCHAR(50) NULL,
    Socket3 NVARCHAR(50) NULL,
    Socket4 NVARCHAR(50) NULL,
    
    -- Random attributes
    RandomAttrsJson NVARCHAR(MAX) NULL,    -- JSON: [{attrId, value}, ...]
    
    -- Binding
    IsBound BIT DEFAULT 0,
    BoundToRoleId INT NULL,
    
    -- Expiration
    ExpireAt DATETIME NULL,
    
    -- Extra
    ExtraDataJson NVARCHAR(MAX) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_Inventory_RoleId (RoleId),
    INDEX IX_Inventory_RoleName (RoleName),
    INDEX IX_Inventory_BagSlot (BagIndex, SlotIndex),
    INDEX IX_Inventory_ItemId (ItemId),
    CONSTRAINT FK_Inventory_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- ROLE EQUIPMENT (View separada para equipamentos)
-- ==============================================

IF OBJECT_ID('VW_RoleEquipment', 'V') IS NOT NULL DROP VIEW VW_RoleEquipment;
GO

CREATE VIEW VW_RoleEquipment AS
SELECT 
    inv.*,
    def.ItemName,
    def.MainType,
    def.SubType,
    def.Quality,
    def.IconRes,
    def.ModelRes,
    def.EquipModelCode
FROM TB_RoleInventory inv
LEFT JOIN TB_ItemDefinition def ON inv.ItemCode = def.ItemCode
WHERE inv.BagIndex = 10;
GO

-- ==============================================
-- ROLE BANK (Armazém/Banco do personagem)
-- ==============================================

IF OBJECT_ID('TB_RoleBank', 'U') IS NOT NULL DROP TABLE TB_RoleBank;
GO

CREATE TABLE TB_RoleBank (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    
    -- Item identification
    ItemId NVARCHAR(50) NOT NULL,
    ItemCode NVARCHAR(50) NOT NULL,
    
    -- Position
    TabIndex TINYINT DEFAULT 0,
    SlotIndex INT NOT NULL,
    
    -- Quantity & State
    ItemCount INT DEFAULT 1,
    Durability INT DEFAULT 100,
    MaxDurability INT DEFAULT 100,
    EnhanceLevel INT DEFAULT 0,
    
    -- Sockets
    Socket1 NVARCHAR(50) NULL,
    Socket2 NVARCHAR(50) NULL,
    Socket3 NVARCHAR(50) NULL,
    Socket4 NVARCHAR(50) NULL,
    
    -- Extra
    RandomAttrsJson NVARCHAR(MAX) NULL,
    ExtraDataJson NVARCHAR(MAX) NULL,
    
    INDEX IX_Bank_RoleId (RoleId),
    CONSTRAINT FK_Bank_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- MAIL SYSTEM (Correio com itens anexados)
-- ==============================================

IF OBJECT_ID('TB_RoleMail', 'U') IS NOT NULL DROP TABLE TB_RoleMail;
GO

CREATE TABLE TB_RoleMail (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ReceiverRoleId INT NOT NULL,
    ReceiverName NVARCHAR(50) NOT NULL,
    SenderRoleId INT NULL,
    SenderName NVARCHAR(50) NOT NULL,
    
    -- Mail content
    Subject NVARCHAR(100) NOT NULL,
    Body NVARCHAR(1000) NULL,
    
    -- Attachments
    AttachedGold BIGINT DEFAULT 0,
    AttachedItemsJson NVARCHAR(MAX) NULL,  -- JSON: [{itemId, itemCode, count, ...}]
    
    -- Status
    IsRead BIT DEFAULT 0,
    IsAttachmentTaken BIT DEFAULT 0,
    
    -- Dates
    SentAt DATETIME DEFAULT GETDATE(),
    ExpireAt DATETIME NULL,
    
    INDEX IX_Mail_ReceiverId (ReceiverRoleId),
    INDEX IX_Mail_SenderName (SenderName),
    CONSTRAINT FK_Mail_Receiver FOREIGN KEY (ReceiverRoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- AUCTION HOUSE (Casa de Leilões)
-- ==============================================

IF OBJECT_ID('TB_AuctionItem', 'U') IS NOT NULL DROP TABLE TB_AuctionItem;
GO

CREATE TABLE TB_AuctionItem (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    SellerRoleId INT NOT NULL,
    SellerName NVARCHAR(50) NOT NULL,
    
    -- Item data
    ItemId NVARCHAR(50) NOT NULL,
    ItemCode NVARCHAR(50) NOT NULL,
    ItemCount INT DEFAULT 1,
    ItemDataJson NVARCHAR(MAX) NULL,       -- Full item state
    
    -- Pricing
    StartPrice BIGINT NOT NULL,
    BuyoutPrice BIGINT NULL,
    CurrentBid BIGINT DEFAULT 0,
    
    -- Bidder
    HighestBidderId INT NULL,
    HighestBidderName NVARCHAR(50) NULL,
    
    -- Timing
    ListedAt DATETIME DEFAULT GETDATE(),
    ExpiresAt DATETIME NOT NULL,
    
    -- Status
    Status TINYINT DEFAULT 0,              -- 0=Active, 1=Sold, 2=Expired, 3=Cancelled
    
    INDEX IX_Auction_Seller (SellerRoleId),
    INDEX IX_Auction_ItemCode (ItemCode),
    INDEX IX_Auction_Status (Status),
    INDEX IX_Auction_Expires (ExpiresAt)
);
GO

-- ==============================================
-- TRADE LOG (Histórico de transações)
-- ==============================================

IF OBJECT_ID('TB_TradeLog', 'U') IS NOT NULL DROP TABLE TB_TradeLog;
GO

CREATE TABLE TB_TradeLog (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TradeType TINYINT NOT NULL,            -- 1=PlayerTrade, 2=NPC, 3=Auction, 4=Mail
    
    FromRoleId INT NULL,
    FromRoleName NVARCHAR(50) NULL,
    ToRoleId INT NULL,
    ToRoleName NVARCHAR(50) NULL,
    
    -- Trade details
    ItemCode NVARCHAR(50) NULL,
    ItemCount INT DEFAULT 0,
    GoldAmount BIGINT DEFAULT 0,
    CrystalAmount INT DEFAULT 0,
    
    -- Context
    TradeDataJson NVARCHAR(MAX) NULL,
    TradeAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_TradeLog_FromRole (FromRoleId),
    INDEX IX_TradeLog_ToRole (ToRoleId),
    INDEX IX_TradeLog_Date (TradeAt)
);
GO

-- ==============================================
-- SAMPLE ITEM DEFINITIONS
-- ==============================================

INSERT INTO TB_ItemDefinition (ItemCode, ItemName, MainType, SubType, Quality, MaxStack, BuyPrice, SellPrice, Description)
VALUES 
    ('gold_coin', 'Moeda de Ouro', 1, 0, 1, 99999, 0, 1, 'Moeda comum'),
    ('hp_potion_s', 'Poção de HP (P)', 2, 1, 1, 99, 50, 25, 'Recupera 100 HP'),
    ('mp_potion_s', 'Poção de MP (P)', 2, 2, 1, 99, 50, 25, 'Recupera 100 MP'),
    ('hp_potion_m', 'Poção de HP (M)', 2, 1, 2, 99, 200, 100, 'Recupera 500 HP'),
    ('mp_potion_m', 'Poção de MP (M)', 2, 2, 2, 99, 200, 100, 'Recupera 500 MP');
GO

INSERT INTO TB_ItemDefinition (ItemCode, ItemName, MainType, SubType, Quality, RequiredLevel, EquipSlot, 
    PhysicalAttack, PhysicalDefense, BuyPrice, SellPrice, Description)
VALUES 
    ('sword_wood', 'Espada de Madeira', 3, 1024, 1, 1, 0, 10, 0, 100, 50, 'Espada básica para iniciantes'),
    ('sword_iron', 'Espada de Ferro', 3, 1024, 2, 10, 0, 50, 0, 1000, 500, 'Espada de ferro resistente'),
    ('armor_cloth', 'Armadura de Pano', 3, 1025, 1, 1, 1, 0, 5, 80, 40, 'Armadura leve de tecido'),
    ('armor_leather', 'Armadura de Couro', 3, 1025, 2, 10, 1, 0, 25, 800, 400, 'Armadura de couro curtido');
GO

PRINT 'Inventory tables created successfully!';
GO
