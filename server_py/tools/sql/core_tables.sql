-- ==============================================
-- Asa de Cristal - Core Tables
-- Tabelas principais: Contas, Sessões, Servidores, Personagens
-- ==============================================

-- ==============================================
-- ACCOUNT SYSTEM
-- ==============================================
USE mspt1;
GO

IF OBJECT_ID('TB_Account', 'U') IS NOT NULL DROP TABLE TB_Account;
GO

CREATE TABLE TB_Account (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(128) NOT NULL,
    Email NVARCHAR(100) NULL,
    Status TINYINT DEFAULT 1,              -- 0=Banido, 1=Ativo, 2=VIP
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLoginAt DATETIME NULL,
    LastLoginIP NVARCHAR(45) NULL,
    BanReason NVARCHAR(255) NULL,
    BanUntil DATETIME NULL,
    
    INDEX IX_Account_Username (Username),
    INDEX IX_Account_Status (Status)
);
GO

-- ==============================================
-- SESSION MANAGEMENT
-- ==============================================

IF OBJECT_ID('TB_Session', 'U') IS NOT NULL DROP TABLE TB_Session;
GO

CREATE TABLE TB_Session (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AccountId INT NOT NULL,
    SessionKey NVARCHAR(64) NOT NULL,
    ServerId INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    ExpiresAt DATETIME NOT NULL,
    IPAddress NVARCHAR(45) NULL,
    
    INDEX IX_Session_AccountId (AccountId),
    INDEX IX_Session_Key (SessionKey),
    CONSTRAINT FK_Session_Account FOREIGN KEY (AccountId) REFERENCES TB_Account(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- SERVER LIST
-- ==============================================

IF OBJECT_ID('TB_Server', 'U') IS NOT NULL DROP TABLE TB_Server;
GO

CREATE TABLE TB_Server (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ServerName NVARCHAR(50) NOT NULL,
    ServerIP NVARCHAR(45) NOT NULL,
    ServerPort INT NOT NULL,
    Status TINYINT DEFAULT 1,              -- 0=Offline, 1=Online, 2=Manutenção
    MaxPlayers INT DEFAULT 1000,
    CurrentPlayers INT DEFAULT 0,
    OpenDate DATETIME NULL,
    IsRecommended BIT DEFAULT 0,
    IsNew BIT DEFAULT 0,
    
    INDEX IX_Server_Status (Status)
);
GO

-- ==============================================
-- ROLE (PERSONAGEM) TABLE
-- ==============================================

IF OBJECT_ID('TB_Role', 'U') IS NOT NULL DROP TABLE TB_Role;
GO

CREATE TABLE TB_Role (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AccountId INT NOT NULL,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    
    -- Basic Info
    JobCode TINYINT NOT NULL,
    Sex TINYINT NOT NULL,
    Level SMALLINT DEFAULT 1,
    Exp BIGINT DEFAULT 0,
    HeadIconIndex SMALLINT DEFAULT 0,
    HairStyleIndex TINYINT DEFAULT 0,
    
    -- Position
    MapId NVARCHAR(20) DEFAULT 'a1',
    PosX INT DEFAULT 32,
    PosY INT DEFAULT 63,
    LineIndex TINYINT DEFAULT 0,
    
    -- Attributes (primários)
    AttrForce INT DEFAULT 5,
    AttrAgility INT DEFAULT 5,
    AttrVitality INT DEFAULT 5,
    AttrSpirit INT DEFAULT 5,
    AttrRemainPoints INT DEFAULT 0,
    
    -- Combat Stats
    HP INT DEFAULT 100,
    MaxHP INT DEFAULT 100,
    MP INT DEFAULT 100,
    MaxMP INT DEFAULT 100,
    SP INT DEFAULT 100,
    MaxSP INT DEFAULT 100,
    Pet_HP INT DEFAULT 100,
    Pet_MaxHP INT DEFAULT 100,
    Pet_MP INT DEFAULT 100,
    Pet_MaxMP INT DEFAULT 100,
    
    -- Currency
    Gold BIGINT DEFAULT 0,
    Money INT DEFAULT 0,                   -- Cristal/Cash
    BankGold BIGINT DEFAULT 0,
    BindMoney INT DEFAULT 0,
    
    -- Bags Capacity
    BagCapacityPlayer INT DEFAULT 36,
    BagCapacityPet INT DEFAULT 3,
    BagCapacityRide INT DEFAULT 3,
    
    -- State flags
    IsUseFashion BIT DEFAULT 1,
    PvPFlag TINYINT DEFAULT 0,
    PKValue INT DEFAULT 0,
    
    -- Guild
    GuildId INT DEFAULT 0,
    GuildName NVARCHAR(50) NULL,
    GuildPost TINYINT DEFAULT 0,
    
    -- Spouse
    SpouseName NVARCHAR(50) NULL,
    
    -- Title/Honor
    CurTitle INT DEFAULT 0,
    TitleBits BIGINT DEFAULT 0,
    Honor INT DEFAULT 0,
    
    -- Pet
    PetId INT DEFAULT 0,
    PetName NVARCHAR(50) NULL,
    RideId INT DEFAULT 0,
    
    -- Date/Time info
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastPlayTime DATETIME DEFAULT GETDATE(),
    TotalPlayTime INT DEFAULT 0,
    
    -- Delete flags
    DeletedFlag BIT DEFAULT 0,
    WillDeleteTime DATETIME NULL,
    
    -- Password protection
    HasRolePassword BIT DEFAULT 0,
    RolePasswordHash NVARCHAR(128) NULL,
    
    -- Equipment models JSON (para mostrar na lista de personagens)
    EquipmentModelsJson NVARCHAR(MAX) NULL,
    
    -- Client config string
    ClientConfig NVARCHAR(MAX) NULL,
    
    INDEX IX_Role_AccountId (AccountId),
    INDEX IX_Role_Name (Name),
    INDEX IX_Role_GuildId (GuildId),
    CONSTRAINT FK_Role_Account FOREIGN KEY (AccountId) REFERENCES TB_Account(Id)
);
GO

-- ==============================================
-- ROLE VARS (Variáveis dinâmicas do personagem)
-- ==============================================

IF OBJECT_ID('TB_RoleVars', 'U') IS NOT NULL DROP TABLE TB_RoleVars;
GO

CREATE TABLE TB_RoleVars (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    VarType TINYINT NOT NULL,              -- 1=bool, 2=int, 3=string
    VarName NVARCHAR(100) NOT NULL,
    VarValueBool BIT NULL,
    VarValueInt BIGINT NULL,
    VarValueStr NVARCHAR(MAX) NULL,
    
    INDEX IX_RoleVars_RoleId (RoleId),
    INDEX IX_RoleVars_Name (VarName),
    CONSTRAINT FK_RoleVars_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_RoleVars_RoleVar UNIQUE (RoleId, VarName)
);
GO

-- ==============================================
-- ROLE KILLED MONSTERS (tracking de monstros mortos)
-- ==============================================

IF OBJECT_ID('TB_RoleKilledMonsters', 'U') IS NOT NULL DROP TABLE TB_RoleKilledMonsters;
GO

CREATE TABLE TB_RoleKilledMonsters (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    MonsterCode NVARCHAR(50) NOT NULL,
    KillCount INT DEFAULT 0,
    
    INDEX IX_RoleKilled_RoleId (RoleId),
    CONSTRAINT FK_RoleKilled_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_RoleKilled_Monster UNIQUE (RoleId, MonsterCode)
);
GO

-- ==============================================
-- FRIENDS SYSTEM
-- ==============================================

IF OBJECT_ID('TB_RoleFriends', 'U') IS NOT NULL DROP TABLE TB_RoleFriends;
GO

CREATE TABLE TB_RoleFriends (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    FriendRoleId INT NOT NULL,
    FriendName NVARCHAR(50) NOT NULL,
    GroupId TINYINT DEFAULT 0,             -- 0=Amigos, 1=Bloqueados, etc.
    Intimacy INT DEFAULT 0,
    AddedAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_Friends_RoleId (RoleId),
    INDEX IX_Friends_FriendId (FriendRoleId),
    CONSTRAINT FK_Friends_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Friends_Pair UNIQUE (RoleId, FriendRoleId)
);
GO

-- ==============================================
-- TASK/QUEST SYSTEM
-- ==============================================

IF OBJECT_ID('TB_RoleTasks', 'U') IS NOT NULL DROP TABLE TB_RoleTasks;
GO

CREATE TABLE TB_RoleTasks (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    TaskId INT NOT NULL,
    Status TINYINT NOT NULL,               -- 0=Doing, 1=Done
    AllocatorId INT DEFAULT 0,
    ProgressJson NVARCHAR(MAX) NULL,       -- {"objectives": [...]}
    AcceptedAt DATETIME DEFAULT GETDATE(),
    CompletedAt DATETIME NULL,
    
    INDEX IX_Tasks_RoleId (RoleId),
    INDEX IX_Tasks_Status (Status),
    CONSTRAINT FK_Tasks_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- FARM SYSTEM
-- ==============================================

IF OBJECT_ID('TB_RoleFarms', 'U') IS NOT NULL DROP TABLE TB_RoleFarms;
GO

CREATE TABLE TB_RoleFarms (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    FarmIndex INT NOT NULL,
    FarmType TINYINT NOT NULL,             -- Tipo de farm
    Level INT DEFAULT 1,
    PlantedAt DATETIME NULL,
    HarvestAt DATETIME NULL,
    DataJson NVARCHAR(MAX) NULL,
    
    INDEX IX_Farms_RoleId (RoleId),
    CONSTRAINT FK_Farms_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- MAP HONOR (ranking por mapa)
-- ==============================================

IF OBJECT_ID('TB_MapHonor', 'U') IS NOT NULL DROP TABLE TB_MapHonor;
GO

CREATE TABLE TB_MapHonor (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MapId NVARCHAR(20) NOT NULL,
    RoleId INT NOT NULL,
    RoleName NVARCHAR(50) NOT NULL,
    HonorPoints INT DEFAULT 0,
    Rank INT DEFAULT 0,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_MapHonor_MapId (MapId),
    INDEX IX_MapHonor_RoleId (RoleId),
    CONSTRAINT UQ_MapHonor UNIQUE (MapId, RoleId)
);
GO

-- ==============================================
-- PEARL SYSTEM (Pérolas/Sorteio)
-- ==============================================

IF OBJECT_ID('TB_RolePearls', 'U') IS NOT NULL DROP TABLE TB_RolePearls;
GO

CREATE TABLE TB_RolePearls (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    PearlId INT NOT NULL,
    Quantity INT DEFAULT 0,
    
    INDEX IX_Pearls_RoleId (RoleId),
    CONSTRAINT FK_Pearls_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Pearls UNIQUE (RoleId, PearlId)
);
GO

-- ==============================================
-- ARMORY SYSTEM (Armadura/Arsenal)
-- ==============================================

IF OBJECT_ID('TB_RoleArmory', 'U') IS NOT NULL DROP TABLE TB_RoleArmory;
GO

CREATE TABLE TB_RoleArmory (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    SetId INT NOT NULL,
    SetName NVARCHAR(50) NULL,
    EquipmentJson NVARCHAR(MAX) NULL,      -- JSON dos equipamentos salvos
    CreatedAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_Armory_RoleId (RoleId),
    CONSTRAINT FK_Armory_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- SKILLS
-- ==============================================

IF OBJECT_ID('TB_RoleSkills', 'U') IS NOT NULL DROP TABLE TB_RoleSkills;
GO

CREATE TABLE TB_RoleSkills (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    SkillId INT NOT NULL,
    SkillLevel INT DEFAULT 1,
    CooldownEnd DATETIME NULL,
    
    INDEX IX_Skills_RoleId (RoleId),
    CONSTRAINT FK_Skills_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Skills UNIQUE (RoleId, SkillId)
);
GO

-- ==============================================
-- INITIAL DATA - Servers
-- ==============================================

INSERT INTO TB_Server (ServerName, ServerIP, ServerPort, Status, IsRecommended, IsNew)
VALUES 
    ('Servidor 1', '127.0.0.1', 8888, 1, 1, 1),
    ('Servidor 2', '127.0.0.1', 8889, 1, 0, 0);
GO

-- ==============================================
-- INITIAL DATA - Test Account
-- ==============================================

INSERT INTO TB_Account (Username, PasswordHash, Email, Status)
VALUES ('test', 'test', 'test@test.com', 1);
GO

PRINT 'Core tables created successfully!';
GO
