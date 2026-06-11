-- ==============================================
-- Asa de Cristal - Game Systems Tables
-- Tabelas para Buffs, Monstros, Spawns e Coleta
-- Auto-generated schema
-- ==============================================

-- ==============================================
-- BUFF SYSTEM TABLES
-- ==============================================
USE mspt1;
GO

IF OBJECT_ID('TB_BuffConfig', 'U') IS NOT NULL DROP TABLE TB_BuffConfig;
GO

CREATE TABLE TB_BuffConfig (
    BuffId INT PRIMARY KEY,
    BuffName NVARCHAR(100) NOT NULL,
    IconRes VARCHAR(50) NULL,
    IsDebuff TINYINT DEFAULT 0,
    DurationInSec INT DEFAULT 0,           -- 0 = permanente
    MaxStack INT DEFAULT 1,
    CoverFlag INT DEFAULT 0,               -- Grupo de cobertura
    CoverLevel INT DEFAULT 0,
    RemoveMode INT DEFAULT 0,              -- 0=normal, 1=morte, 2=logout
    ResultAttrJson TEXT NULL,              -- JSON: {"attrId": value, ...}
    ResultStatusJson TEXT NULL,            -- JSON: {"status": true, ...}
    OnTimerJson TEXT NULL,                 -- JSON: {firstTimeInSec, repeatTimeInSec, doMacro}
    OnTimer2Json TEXT NULL,
    OnAttackJson TEXT NULL,                -- JSON: {macroToSelf, macroToOther}
    OnUnderAttackJson TEXT NULL,
    FullConfigJson TEXT NULL               -- JSON completo original para referência
);
GO

CREATE INDEX IX_BuffConfig_CoverFlag ON TB_BuffConfig(CoverFlag);
GO

-- Tabela para buffs ativos de personagens (persistência)
IF OBJECT_ID('TB_RoleActiveBuffs', 'U') IS NOT NULL DROP TABLE TB_RoleActiveBuffs;
GO

CREATE TABLE TB_RoleActiveBuffs (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId INT NOT NULL,
    BuffId INT NOT NULL,
    RemainingTimeMs INT NOT NULL,          -- Tempo restante em ms
    StackCount INT DEFAULT 1,
    AppliedAt DATETIME DEFAULT GETDATE(),
    
    INDEX IX_RoleBuffs_RoleId (RoleId),
    CONSTRAINT FK_RoleBuffs_Role FOREIGN KEY (RoleId) REFERENCES TB_Role(Id) ON DELETE CASCADE
);
GO

-- ==============================================
-- MONSTER DEFINITION TABLES
-- ==============================================

IF OBJECT_ID('TB_MonsterDefinition', 'U') IS NOT NULL DROP TABLE TB_MonsterDefinition;
GO

CREATE TABLE TB_MonsterDefinition (
    Code VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Level INT NOT NULL,
    ModelCode VARCHAR(20) NOT NULL,
    
    -- Atributos de Combate
    HP INT NOT NULL,
    PhysicalAttack INT NOT NULL,
    PhysicalDefense INT NOT NULL,
    MagicDefense INT NOT NULL,
    HitValue INT DEFAULT 100,
    HitRateBase FLOAT DEFAULT 0.5,
    DodgeValue INT DEFAULT 0,
    CritValue INT DEFAULT 0,
    
    -- Comportamento / IA
    WalkSpeed INT DEFAULT 80,
    PatrolRange INT DEFAULT 200,
    GuardRange INT DEFAULT 1500,
    ChaseRange INT DEFAULT 1000,
    ThreatAIMode TINYINT DEFAULT 0,
    Species TINYINT DEFAULT 1,
    
    -- Recompensas
    Exp INT DEFAULT 0,
    PetExp INT DEFAULT 0,
    
    -- JSON Fields
    SkillsJson TEXT NULL,                  -- ["skill1", "skill2"]
    ItemDropRuleJson TEXT NULL,            -- {dropGroups, specialDrop}
    ExtraItemsJson TEXT NULL,              -- [{chance, itemCode}]
    SayInIdleJson TEXT NULL,               -- ["fala1", "fala2"]
    SayInBattleJson TEXT NULL,             -- ["fala1", "fala2"]
    
    -- Referência
    AtPlace VARCHAR(50) NULL
);
GO

CREATE INDEX IX_Monster_Level ON TB_MonsterDefinition(Level);
GO

-- ==============================================
-- DROP GROUP TABLES
-- ==============================================

IF OBJECT_ID('TB_DropGroup', 'U') IS NOT NULL DROP TABLE TB_DropGroup;
GO

CREATE TABLE TB_DropGroup (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GroupCode VARCHAR(20) NOT NULL,
    ItemCode VARCHAR(20) NOT NULL,
    DropChance FLOAT NOT NULL,
    MinQuantity INT DEFAULT 1,
    MaxQuantity INT DEFAULT 1,
    
    INDEX IX_DropGroup_Code (GroupCode)
);
GO

-- ==============================================
-- MAP MONSTER SPAWN TABLES
-- ==============================================

IF OBJECT_ID('TB_MapMonsterSpawn', 'U') IS NOT NULL DROP TABLE TB_MapMonsterSpawn;
GO

CREATE TABLE TB_MapMonsterSpawn (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MapId VARCHAR(20) NOT NULL,
    MonsterCode VARCHAR(20) NOT NULL,
    PosX FLOAT NOT NULL,
    PosY FLOAT NOT NULL,
    FirstTimeMin INT DEFAULT 3,
    FirstTimeMax INT DEFAULT 8,
    RebirthIntervalMin INT DEFAULT 1,
    RebirthIntervalMax INT DEFAULT 0,
    LiveTimeInSec INT DEFAULT 0,
    LiveOnlyInLimit TINYINT DEFAULT 0,
    BossChance FLOAT DEFAULT 0,
    SpecialRefreshJson TEXT NULL,          -- {chance, codes: [{code, weighing}]}
    
    INDEX IX_MonsterSpawn_MapId (MapId)
);
GO

-- ==============================================
-- MAP HARVEST SPAWN TABLES (Coleta/Plantação)
-- ==============================================

IF OBJECT_ID('TB_MapHarvestSpawn', 'U') IS NOT NULL DROP TABLE TB_MapHarvestSpawn;
GO

CREATE TABLE TB_MapHarvestSpawn (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MapId VARCHAR(20) NOT NULL,
    ResourceCode VARCHAR(20) NOT NULL,
    PosX INT NOT NULL,
    PosY INT NOT NULL,
    FirstTimeMin INT DEFAULT 3,
    FirstTimeMax INT DEFAULT 8,
    RebirthIntervalMin INT DEFAULT 3,
    RebirthIntervalMax INT DEFAULT 5,
    LiveTimeInSec INT DEFAULT 0,
    LiveOnlyInLimit TINYINT DEFAULT 0,
    SpecialRefreshJson TEXT NULL,
    
    INDEX IX_HarvestSpawn_MapId (MapId)
);
GO

-- ==============================================
-- HARVEST DEFINITION (tipos de recursos)
-- ==============================================

IF OBJECT_ID('TB_HarvestDefinition', 'U') IS NOT NULL DROP TABLE TB_HarvestDefinition;
GO

CREATE TABLE TB_HarvestDefinition (
    Code VARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Type TINYINT NOT NULL,                 -- 1=Erva, 2=Minério, 3=Madeira, etc.
    RequiredProfession VARCHAR(20) NULL,
    RequiredLevel INT DEFAULT 0,
    RequiredTool VARCHAR(20) NULL,
    HarvestTimeMs INT DEFAULT 2000,
    IconRes VARCHAR(50) NULL,
    ModelRes VARCHAR(50) NULL,
    DropsJson TEXT NULL                    -- [{itemCode, minQty, maxQty, chance}]
);
GO

-- ==============================================
-- STORED PROCEDURES
-- ==============================================

-- Procedure para obter configuração de buff
IF OBJECT_ID('SP_GetBuffConfig', 'P') IS NOT NULL DROP PROCEDURE SP_GetBuffConfig;
GO

CREATE PROCEDURE SP_GetBuffConfig
    @BuffId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM TB_BuffConfig WHERE BuffId = @BuffId;
END
GO

-- Procedure para obter todos buffs ativos de um personagem
IF OBJECT_ID('SP_GetRoleActiveBuffs', 'P') IS NOT NULL DROP PROCEDURE SP_GetRoleActiveBuffs;
GO

CREATE PROCEDURE SP_GetRoleActiveBuffs
    @RoleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT b.BuffId, b.RemainingTimeMs, b.StackCount, b.AppliedAt,
           c.BuffName, c.IconRes, c.IsDebuff, c.MaxStack
    FROM TB_RoleActiveBuffs b
    INNER JOIN TB_BuffConfig c ON b.BuffId = c.BuffId
    WHERE b.RoleId = @RoleId;
END
GO

-- Procedure para adicionar/atualizar buff ativo
IF OBJECT_ID('SP_ApplyBuffToRole', 'P') IS NOT NULL DROP PROCEDURE SP_ApplyBuffToRole;
GO

CREATE PROCEDURE SP_ApplyBuffToRole
    @RoleId INT,
    @BuffId INT,
    @DurationMs INT,
    @StackCount INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verifica se já existe
    IF EXISTS (SELECT 1 FROM TB_RoleActiveBuffs WHERE RoleId = @RoleId AND BuffId = @BuffId)
    BEGIN
        -- Atualiza existente
        UPDATE TB_RoleActiveBuffs 
        SET RemainingTimeMs = @DurationMs,
            StackCount = @StackCount,
            AppliedAt = GETDATE()
        WHERE RoleId = @RoleId AND BuffId = @BuffId;
    END
    ELSE
    BEGIN
        -- Insere novo
        INSERT INTO TB_RoleActiveBuffs (RoleId, BuffId, RemainingTimeMs, StackCount)
        VALUES (@RoleId, @BuffId, @DurationMs, @StackCount);
    END
END
GO

-- Procedure para remover buff
IF OBJECT_ID('SP_RemoveBuffFromRole', 'P') IS NOT NULL DROP PROCEDURE SP_RemoveBuffFromRole;
GO

CREATE PROCEDURE SP_RemoveBuffFromRole
    @RoleId INT,
    @BuffId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM TB_RoleActiveBuffs WHERE RoleId = @RoleId AND BuffId = @BuffId;
END
GO

-- Procedure para obter definição de monstro
IF OBJECT_ID('SP_GetMonsterDefinition', 'P') IS NOT NULL DROP PROCEDURE SP_GetMonsterDefinition;
GO

CREATE PROCEDURE SP_GetMonsterDefinition
    @MonsterCode VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM TB_MonsterDefinition WHERE Code = @MonsterCode;
END
GO

-- Procedure para obter spawns de monstros de um mapa
IF OBJECT_ID('SP_GetMapMonsterSpawns', 'P') IS NOT NULL DROP PROCEDURE SP_GetMapMonsterSpawns;
GO

CREATE PROCEDURE SP_GetMapMonsterSpawns
    @MapId VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.*, m.Name AS MonsterName, m.Level, m.HP, m.ModelCode
    FROM TB_MapMonsterSpawn s
    LEFT JOIN TB_MonsterDefinition m ON s.MonsterCode = m.Code
    WHERE s.MapId = @MapId;
END
GO

-- Procedure para obter spawns de recursos de um mapa
IF OBJECT_ID('SP_GetMapHarvestSpawns', 'P') IS NOT NULL DROP PROCEDURE SP_GetMapHarvestSpawns;
GO

CREATE PROCEDURE SP_GetMapHarvestSpawns
    @MapId VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT s.*, h.Name AS ResourceName, h.Type, h.HarvestTimeMs
    FROM TB_MapHarvestSpawn s
    LEFT JOIN TB_HarvestDefinition h ON s.ResourceCode = h.Code
    WHERE s.MapId = @MapId;
END
GO

-- Procedure para obter drops de um grupo
IF OBJECT_ID('SP_GetDropGroupItems', 'P') IS NOT NULL DROP PROCEDURE SP_GetDropGroupItems;
GO

CREATE PROCEDURE SP_GetDropGroupItems
    @GroupCode VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ItemCode, DropChance, MinQuantity, MaxQuantity
    FROM TB_DropGroup
    WHERE GroupCode = @GroupCode;
END
GO

-- ==============================================
-- Summary
-- ==============================================
PRINT 'Game Systems Tables created successfully!'
PRINT 'Tables: TB_BuffConfig, TB_RoleActiveBuffs, TB_MonsterDefinition,'
PRINT '        TB_DropGroup, TB_MapMonsterSpawn, TB_MapHarvestSpawn, TB_HarvestDefinition'
PRINT 'Procedures: SP_GetBuffConfig, SP_GetRoleActiveBuffs, SP_ApplyBuffToRole,'
PRINT '            SP_RemoveBuffFromRole, SP_GetMonsterDefinition, SP_GetMapMonsterSpawns,'
PRINT '            SP_GetMapHarvestSpawns, SP_GetDropGroupItems'
GO
