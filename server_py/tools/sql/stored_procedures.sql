-- ==============================================
-- Asa de Cristal - Stored Procedures
-- Procedures para operações do servidor
-- ==============================================

-- ==============================================
-- ACCOUNT & SESSION PROCEDURES
-- ==============================================
USE mspt1;
GO

IF OBJECT_ID('SP_AuthenticateAccount', 'P') IS NOT NULL DROP PROCEDURE SP_AuthenticateAccount;
GO

CREATE PROCEDURE SP_AuthenticateAccount
    @Username NVARCHAR(50),
    @Password NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Username, Status, BanReason, BanUntil
    FROM TB_Account
    WHERE Username = @Username AND PasswordHash = @Password;
    
    IF @@ROWCOUNT > 0
    BEGIN
        UPDATE TB_Account 
        SET LastLoginAt = GETDATE()
        WHERE Username = @Username;
    END
END;
GO

IF OBJECT_ID('SP_CreateSession', 'P') IS NOT NULL DROP PROCEDURE SP_CreateSession;
GO

CREATE PROCEDURE SP_CreateSession
    @AccountId INT,
    @SessionKey NVARCHAR(64),
    @ServerId INT,
    @IPAddress NVARCHAR(45),
    @ExpiresInMinutes INT = 60
AS
BEGIN
    SET NOCOUNT ON;
    
    DELETE FROM TB_Session WHERE AccountId = @AccountId;
    
    INSERT INTO TB_Session (AccountId, SessionKey, ServerId, IPAddress, ExpiresAt)
    VALUES (@AccountId, @SessionKey, @ServerId, @IPAddress, DATEADD(MINUTE, @ExpiresInMinutes, GETDATE()));
    
    SELECT SCOPE_IDENTITY() AS SessionId;
END;
GO

IF OBJECT_ID('SP_ValidateSession', 'P') IS NOT NULL DROP PROCEDURE SP_ValidateSession;
GO

CREATE PROCEDURE SP_ValidateSession
    @SessionKey NVARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT s.Id, s.AccountId, s.ServerId, a.Username, a.Status
    FROM TB_Session s
    INNER JOIN TB_Account a ON s.AccountId = a.Id
    WHERE s.SessionKey = @SessionKey AND s.ExpiresAt > GETDATE();
END;
GO

-- ==============================================
-- ROLE PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_GetRolesForAccount', 'P') IS NOT NULL DROP PROCEDURE SP_GetRolesForAccount;
GO

CREATE PROCEDURE SP_GetRolesForAccount
    @AccountId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Name, JobCode, Sex, Level, HeadIconIndex, HairStyleIndex,
           AccountId, CreatedAt, LastPlayTime, DeletedFlag, WillDeleteTime,
           EquipmentModelsJson, HasRolePassword
    FROM TB_Role
    WHERE AccountId = @AccountId AND (DeletedFlag = 0 OR WillDeleteTime > GETDATE());
END;
GO

IF OBJECT_ID('SP_CheckRoleName', 'P') IS NOT NULL DROP PROCEDURE SP_CheckRoleName;
GO

CREATE PROCEDURE SP_CheckRoleName
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM TB_Role WHERE Name = @RoleName)
        SELECT 0 AS Available;
    ELSE
        SELECT 1 AS Available;
END;
GO

IF OBJECT_ID('SP_CreateRole', 'P') IS NOT NULL DROP PROCEDURE SP_CreateRole;
GO

CREATE PROCEDURE SP_CreateRole
    @AccountId INT,
    @Name NVARCHAR(50),
    @JobCode TINYINT,
    @Sex TINYINT,
    @HeadIconIndex SMALLINT,
    @HairStyleIndex TINYINT
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (SELECT 1 FROM TB_Role WHERE Name = @Name)
    BEGIN
        SELECT 0 AS Success, 'Nome já está em uso' AS Error;
        RETURN;
    END
    
    INSERT INTO TB_Role (AccountId, Name, JobCode, Sex, Level, HeadIconIndex, HairStyleIndex,
                         MapId, PosX, PosY, Gold, Money, HP, MaxHP, MP, MaxMP)
    VALUES (@AccountId, @Name, @JobCode, @Sex, 1, @HeadIconIndex, @HairStyleIndex,
            'a1', 1088, 640, 1000, 0, 100, 100, 100, 100);
    
    DECLARE @NewRoleId INT = SCOPE_IDENTITY();
    
    SELECT 1 AS Success, @NewRoleId AS RoleId, @Name AS Name;
END;
GO

IF OBJECT_ID('SP_DeleteRole', 'P') IS NOT NULL DROP PROCEDURE SP_DeleteRole;
GO

CREATE PROCEDURE SP_DeleteRole
    @AccountId INT,
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TB_Role
    SET DeletedFlag = 1, WillDeleteTime = DATEADD(DAY, 7, GETDATE())
    WHERE AccountId = @AccountId AND Name = @RoleName;
    
    IF @@ROWCOUNT > 0
        SELECT 1 AS IsDone, '' AS FailureReason;
    ELSE
        SELECT 0 AS IsDone, 'Personagem não encontrado' AS FailureReason;
END;
GO

IF OBJECT_ID('SP_SelectRole', 'P') IS NOT NULL DROP PROCEDURE SP_SelectRole;
GO

CREATE PROCEDURE SP_SelectRole
    @AccountId INT,
    @RoleName NVARCHAR(50),
    @Password NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @HasPassword BIT, @StoredHash NVARCHAR(128);
    
    SELECT @HasPassword = HasRolePassword, @StoredHash = RolePasswordHash
    FROM TB_Role
    WHERE AccountId = @AccountId AND Name = @RoleName AND DeletedFlag = 0;
    
    IF @@ROWCOUNT = 0
    BEGIN
        SELECT 0 AS IsDone, 'Personagem não encontrado' AS FailureReason;
        RETURN;
    END
    
    IF @HasPassword = 1 AND (@Password IS NULL OR @Password != @StoredHash)
    BEGIN
        SELECT 0 AS IsDone, 'Senha incorreta' AS FailureReason;
        RETURN;
    END
    
    UPDATE TB_Role SET LastPlayTime = GETDATE() WHERE Name = @RoleName;
    
    SELECT 1 AS IsDone, '' AS FailureReason;
END;
GO

-- ==============================================
-- PLAYER DATA PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_LoadPlayerFullData', 'P') IS NOT NULL DROP PROCEDURE SP_LoadPlayerFullData;
GO

CREATE PROCEDURE SP_LoadPlayerFullData
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT * FROM TB_Role WHERE Name = @RoleName AND DeletedFlag = 0;
END;
GO

IF OBJECT_ID('SP_SavePlayerData', 'P') IS NOT NULL DROP PROCEDURE SP_SavePlayerData;
GO

CREATE PROCEDURE SP_SavePlayerData
    @RoleName NVARCHAR(50),
    @Level SMALLINT = NULL,
    @Exp BIGINT = NULL,
    @MapId NVARCHAR(20) = NULL,
    @PosX INT = NULL,
    @PosY INT = NULL,
    @HP INT = NULL,
    @MaxHP INT = NULL,
    @MP INT = NULL,
    @MaxMP INT = NULL,
    @Gold BIGINT = NULL,
    @Money INT = NULL,
    @AttrForce INT = NULL,
    @AttrAgility INT = NULL,
    @AttrVitality INT = NULL,
    @AttrSpirit INT = NULL,
    @AttrRemainPoints INT = NULL,
    @ClientConfig NVARCHAR(MAX) = NULL,
    @EquipmentModelsJson NVARCHAR(MAX) = NULL,
    @IsUseFashion BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TB_Role SET
        Level = COALESCE(@Level, Level),
        Exp = COALESCE(@Exp, Exp),
        MapId = COALESCE(@MapId, MapId),
        PosX = COALESCE(@PosX, PosX),
        PosY = COALESCE(@PosY, PosY),
        HP = COALESCE(@HP, HP),
        MaxHP = COALESCE(@MaxHP, MaxHP),
        MP = COALESCE(@MP, MP),
        MaxMP = COALESCE(@MaxMP, MaxMP),
        Gold = COALESCE(@Gold, Gold),
        Money = COALESCE(@Money, Money),
        AttrForce = COALESCE(@AttrForce, AttrForce),
        AttrAgility = COALESCE(@AttrAgility, AttrAgility),
        AttrVitality = COALESCE(@AttrVitality, AttrVitality),
        AttrSpirit = COALESCE(@AttrSpirit, AttrSpirit),
        AttrRemainPoints = COALESCE(@AttrRemainPoints, AttrRemainPoints),
        ClientConfig = COALESCE(@ClientConfig, ClientConfig),
        EquipmentModelsJson = COALESCE(@EquipmentModelsJson, EquipmentModelsJson),
        IsUseFashion = COALESCE(@IsUseFashion, IsUseFashion),
        LastPlayTime = GETDATE()
    WHERE Name = @RoleName;
    
    SELECT @@ROWCOUNT AS AffectedRows;
END;
GO

IF OBJECT_ID('SP_SavePlayerVar', 'P') IS NOT NULL DROP PROCEDURE SP_SavePlayerVar;
GO

CREATE PROCEDURE SP_SavePlayerVar
    @RoleName NVARCHAR(50),
    @VarType TINYINT,
    @VarName NVARCHAR(100),
    @VarValueBool BIT = NULL,
    @VarValueInt BIGINT = NULL,
    @VarValueStr NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    IF @RoleId IS NULL RETURN;
    
    MERGE TB_RoleVars AS target
    USING (SELECT @RoleId AS RoleId, @VarName AS VarName) AS source
    ON target.RoleId = source.RoleId AND target.VarName = source.VarName
    WHEN MATCHED THEN
        UPDATE SET VarType = @VarType, VarValueBool = @VarValueBool, 
                   VarValueInt = @VarValueInt, VarValueStr = @VarValueStr
    WHEN NOT MATCHED THEN
        INSERT (RoleId, VarType, VarName, VarValueBool, VarValueInt, VarValueStr)
        VALUES (@RoleId, @VarType, @VarName, @VarValueBool, @VarValueInt, @VarValueStr);
END;
GO

-- ==============================================
-- GOLD & MONEY PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_UpdateGold', 'P') IS NOT NULL DROP PROCEDURE SP_UpdateGold;
GO

CREATE PROCEDURE SP_UpdateGold
    @RoleName NVARCHAR(50),
    @Amount BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TB_Role SET Gold = Gold + @Amount WHERE Name = @RoleName AND Gold + @Amount >= 0;
    
    SELECT Gold AS NewGold FROM TB_Role WHERE Name = @RoleName;
END;
GO

IF OBJECT_ID('SP_AddGold', 'P') IS NOT NULL DROP PROCEDURE SP_AddGold;
GO

CREATE PROCEDURE SP_AddGold
    @RoleName NVARCHAR(50),
    @Amount BIGINT
AS
BEGIN
    EXEC SP_UpdateGold @RoleName, @Amount;
END;
GO

IF OBJECT_ID('SP_UpdateMoney', 'P') IS NOT NULL DROP PROCEDURE SP_UpdateMoney;
GO

CREATE PROCEDURE SP_UpdateMoney
    @RoleName NVARCHAR(50),
    @Amount INT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TB_Role SET Money = Money + @Amount WHERE Name = @RoleName AND Money + @Amount >= 0;
    
    SELECT Money AS NewMoney FROM TB_Role WHERE Name = @RoleName;
END;
GO

-- ==============================================
-- INVENTORY PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_LoadInventory', 'P') IS NOT NULL DROP PROCEDURE SP_LoadInventory;
GO

CREATE PROCEDURE SP_LoadInventory
    @RoleName NVARCHAR(50),
    @BagIndex TINYINT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @BagIndex IS NULL
        SELECT * FROM TB_RoleInventory WHERE RoleName = @RoleName ORDER BY BagIndex, SlotIndex;
    ELSE
        SELECT * FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @BagIndex ORDER BY SlotIndex;
END;
GO

IF OBJECT_ID('SP_AddItemToInventory', 'P') IS NOT NULL DROP PROCEDURE SP_AddItemToInventory;
GO

CREATE PROCEDURE SP_AddItemToInventory
    @RoleName NVARCHAR(50),
    @ItemId NVARCHAR(50),
    @ItemCode NVARCHAR(50),
    @BagIndex TINYINT,
    @SlotIndex INT,
    @ItemCount INT = 1,
    @Durability INT = 100,
    @EnhanceLevel INT = 0,
    @RandomAttrsJson NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    IF @RoleId IS NULL
    BEGIN
        SELECT 0 AS Success, 'Role not found' AS Error;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex)
    BEGIN
        UPDATE TB_RoleInventory 
        SET ItemCount = ItemCount + @ItemCount
        WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex AND ItemCode = @ItemCode;
        
        IF @@ROWCOUNT = 0
        BEGIN
            SELECT 0 AS Success, 'Slot occupied by different item' AS Error;
            RETURN;
        END
    END
    ELSE
    BEGIN
        INSERT INTO TB_RoleInventory (RoleId, RoleName, ItemId, ItemCode, BagIndex, SlotIndex, ItemCount, 
                                       Durability, MaxDurability, EnhanceLevel, RandomAttrsJson)
        VALUES (@RoleId, @RoleName, @ItemId, @ItemCode, @BagIndex, @SlotIndex, @ItemCount,
                @Durability, @Durability, @EnhanceLevel, @RandomAttrsJson);
    END
    
    SELECT 1 AS Success, @ItemId AS ItemId;
END;
GO

IF OBJECT_ID('SP_RemoveItem', 'P') IS NOT NULL DROP PROCEDURE SP_RemoveItem;
GO

CREATE PROCEDURE SP_RemoveItem
    @RoleName NVARCHAR(50),
    @BagIndex TINYINT,
    @SlotIndex INT,
    @Count INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Count IS NULL
    BEGIN
        DELETE FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex;
    END
    ELSE
    BEGIN
        UPDATE TB_RoleInventory 
        SET ItemCount = ItemCount - @Count
        WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex;
        
        DELETE FROM TB_RoleInventory 
        WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex AND ItemCount <= 0;
    END
    
    SELECT @@ROWCOUNT AS AffectedRows;
END;
GO

IF OBJECT_ID('SP_MoveInventoryItem', 'P') IS NOT NULL DROP PROCEDURE SP_MoveInventoryItem;
GO

CREATE PROCEDURE SP_MoveInventoryItem
    @RoleName NVARCHAR(50),
    @FromBag TINYINT,
    @FromSlot INT,
    @ToBag TINYINT,
    @ToSlot INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @FromItemId NVARCHAR(50), @ToItemId NVARCHAR(50);
    DECLARE @FromCode NVARCHAR(50), @ToCode NVARCHAR(50);
    DECLARE @FromCount INT, @ToCount INT;
    
    SELECT @FromItemId = ItemId, @FromCode = ItemCode, @FromCount = ItemCount
    FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @FromBag AND SlotIndex = @FromSlot;
    
    SELECT @ToItemId = ItemId, @ToCode = ItemCode, @ToCount = ItemCount
    FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @ToBag AND SlotIndex = @ToSlot;
    
    IF @FromItemId IS NULL
    BEGIN
        SELECT 0 AS Success, 'Source slot empty' AS Error;
        RETURN;
    END
    
    IF @ToItemId IS NULL
    BEGIN
        UPDATE TB_RoleInventory 
        SET BagIndex = @ToBag, SlotIndex = @ToSlot
        WHERE RoleName = @RoleName AND BagIndex = @FromBag AND SlotIndex = @FromSlot;
    END
    ELSE
    BEGIN
        UPDATE TB_RoleInventory 
        SET BagIndex = @FromBag, SlotIndex = @FromSlot
        WHERE RoleName = @RoleName AND ItemId = @ToItemId;
        
        UPDATE TB_RoleInventory 
        SET BagIndex = @ToBag, SlotIndex = @ToSlot
        WHERE RoleName = @RoleName AND ItemId = @FromItemId;
    END
    
    SELECT 1 AS Success;
END;
GO

IF OBJECT_ID('SP_UseItem', 'P') IS NOT NULL DROP PROCEDURE SP_UseItem;
GO

CREATE PROCEDURE SP_UseItem
    @RoleName NVARCHAR(50),
    @BagIndex TINYINT,
    @SlotIndex INT,
    @Count INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ItemCode NVARCHAR(50), @CurrentCount INT;
    
    SELECT @ItemCode = ItemCode, @CurrentCount = ItemCount
    FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex;
    
    IF @ItemCode IS NULL
    BEGIN
        SELECT 0 AS Success, 'Item not found' AS Error, NULL AS ItemCode;
        RETURN;
    END
    
    IF @CurrentCount < @Count
    BEGIN
        SELECT 0 AS Success, 'Not enough items' AS Error, @ItemCode AS ItemCode;
        RETURN;
    END
    
    IF @CurrentCount = @Count
        DELETE FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex;
    ELSE
        UPDATE TB_RoleInventory SET ItemCount = ItemCount - @Count 
        WHERE RoleName = @RoleName AND BagIndex = @BagIndex AND SlotIndex = @SlotIndex;
    
    SELECT 1 AS Success, '' AS Error, @ItemCode AS ItemCode;
END;
GO

IF OBJECT_ID('SP_EquipItem', 'P') IS NOT NULL DROP PROCEDURE SP_EquipItem;
GO

CREATE PROCEDURE SP_EquipItem
    @RoleName NVARCHAR(50),
    @FromBag TINYINT,
    @FromSlot INT,
    @EquipSlot INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ItemId NVARCHAR(50), @ItemCode NVARCHAR(50);
    DECLARE @OldEquipId NVARCHAR(50);
    
    SELECT @ItemId = ItemId, @ItemCode = ItemCode
    FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @FromBag AND SlotIndex = @FromSlot;
    
    IF @ItemId IS NULL
    BEGIN
        SELECT 0 AS Success, 'Item not found' AS Error;
        RETURN;
    END
    
    SELECT @OldEquipId = ItemId
    FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = 10 AND SlotIndex = @EquipSlot;
    
    IF @OldEquipId IS NOT NULL
    BEGIN
        UPDATE TB_RoleInventory 
        SET BagIndex = @FromBag, SlotIndex = @FromSlot
        WHERE RoleName = @RoleName AND ItemId = @OldEquipId;
    END
    ELSE
    BEGIN
        DELETE FROM TB_RoleInventory WHERE RoleName = @RoleName AND BagIndex = @FromBag AND SlotIndex = @FromSlot;
    END
    
    IF @OldEquipId IS NOT NULL
    BEGIN
        UPDATE TB_RoleInventory 
        SET BagIndex = 10, SlotIndex = @EquipSlot
        WHERE RoleName = @RoleName AND ItemId = @ItemId;
    END
    ELSE
    BEGIN
        UPDATE TB_RoleInventory 
        SET BagIndex = 10, SlotIndex = @EquipSlot
        WHERE RoleName = @RoleName AND ItemId = @ItemId;
        
        IF @@ROWCOUNT = 0
        BEGIN
            DECLARE @RoleId INT;
            SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
            
            INSERT INTO TB_RoleInventory (RoleId, RoleName, ItemId, ItemCode, BagIndex, SlotIndex, ItemCount)
            SELECT @RoleId, @RoleName, @ItemId, @ItemCode, 10, @EquipSlot, 1;
        END
    END
    
    SELECT 1 AS Success, @OldEquipId AS UnequippedItemId;
END;
GO

IF OBJECT_ID('SP_UpdateEquipmentModel', 'P') IS NOT NULL DROP PROCEDURE SP_UpdateEquipmentModel;
GO

CREATE PROCEDURE SP_UpdateEquipmentModel
    @RoleName NVARCHAR(50),
    @EquipmentModelsJson NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE TB_Role SET EquipmentModelsJson = @EquipmentModelsJson WHERE Name = @RoleName;
    
    SELECT @@ROWCOUNT AS AffectedRows;
END;
GO

-- ==============================================
-- TASK PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_UpdateTaskStatus', 'P') IS NOT NULL DROP PROCEDURE SP_UpdateTaskStatus;
GO

CREATE PROCEDURE SP_UpdateTaskStatus
    @RoleName NVARCHAR(50),
    @TaskId INT,
    @Status TINYINT,
    @ProgressJson NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    IF @RoleId IS NULL RETURN;
    
    MERGE TB_RoleTasks AS target
    USING (SELECT @RoleId AS RoleId, @TaskId AS TaskId) AS source
    ON target.RoleId = source.RoleId AND target.TaskId = source.TaskId
    WHEN MATCHED THEN
        UPDATE SET Status = @Status, ProgressJson = @ProgressJson,
                   CompletedAt = CASE WHEN @Status = 1 THEN GETDATE() ELSE CompletedAt END
    WHEN NOT MATCHED THEN
        INSERT (RoleId, TaskId, Status, ProgressJson)
        VALUES (@RoleId, @TaskId, @Status, @ProgressJson);
END;
GO

IF OBJECT_ID('SP_RemoveTask', 'P') IS NOT NULL DROP PROCEDURE SP_RemoveTask;
GO

CREATE PROCEDURE SP_RemoveTask
    @RoleName NVARCHAR(50),
    @TaskId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    DELETE FROM TB_RoleTasks WHERE RoleId = @RoleId AND TaskId = @TaskId;
    
    SELECT @@ROWCOUNT AS AffectedRows;
END;
GO

-- ==============================================
-- BUFF PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_GetBuffConfig', 'P') IS NOT NULL DROP PROCEDURE SP_GetBuffConfig;
GO

CREATE PROCEDURE SP_GetBuffConfig
    @BuffId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @BuffId IS NULL
        SELECT * FROM TB_BuffConfig;
    ELSE
        SELECT * FROM TB_BuffConfig WHERE BuffId = @BuffId;
END;
GO

IF OBJECT_ID('SP_SaveRoleBuff', 'P') IS NOT NULL DROP PROCEDURE SP_SaveRoleBuff;
GO

CREATE PROCEDURE SP_SaveRoleBuff
    @RoleName NVARCHAR(50),
    @BuffId INT,
    @RemainingTimeMs INT,
    @StackCount INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    IF @RoleId IS NULL RETURN;
    
    MERGE TB_RoleActiveBuffs AS target
    USING (SELECT @RoleId AS RoleId, @BuffId AS BuffId) AS source
    ON target.RoleId = source.RoleId AND target.BuffId = source.BuffId
    WHEN MATCHED THEN
        UPDATE SET RemainingTimeMs = @RemainingTimeMs, StackCount = @StackCount, AppliedAt = GETDATE()
    WHEN NOT MATCHED THEN
        INSERT (RoleId, BuffId, RemainingTimeMs, StackCount)
        VALUES (@RoleId, @BuffId, @RemainingTimeMs, @StackCount);
END;
GO

IF OBJECT_ID('SP_LoadRoleBuffs', 'P') IS NOT NULL DROP PROCEDURE SP_LoadRoleBuffs;
GO

CREATE PROCEDURE SP_LoadRoleBuffs
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    SELECT b.*, c.BuffName, c.IconRes, c.IsDebuff
    FROM TB_RoleActiveBuffs b
    LEFT JOIN TB_BuffConfig c ON b.BuffId = c.BuffId
    WHERE b.RoleId = @RoleId;
END;
GO

-- ==============================================
-- FRIEND PROCEDURES
-- ==============================================

IF OBJECT_ID('SP_LoadFriends', 'P') IS NOT NULL DROP PROCEDURE SP_LoadFriends;
GO

CREATE PROCEDURE SP_LoadFriends
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    SELECT f.*, r.Level, r.JobCode, 
           CASE WHEN s.Id IS NOT NULL THEN 1 ELSE 0 END AS IsOnline
    FROM TB_RoleFriends f
    LEFT JOIN TB_Role r ON f.FriendRoleId = r.Id
    LEFT JOIN TB_Session s ON r.AccountId = s.AccountId AND s.ExpiresAt > GETDATE()
    WHERE f.RoleId = @RoleId;
END;
GO

IF OBJECT_ID('SP_AddFriend', 'P') IS NOT NULL DROP PROCEDURE SP_AddFriend;
GO

CREATE PROCEDURE SP_AddFriend
    @RoleName NVARCHAR(50),
    @FriendName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT, @FriendRoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    SELECT @FriendRoleId = Id FROM TB_Role WHERE Name = @FriendName;
    
    IF @RoleId IS NULL OR @FriendRoleId IS NULL
    BEGIN
        SELECT 0 AS Success, 'Player not found' AS Error;
        RETURN;
    END
    
    IF EXISTS (SELECT 1 FROM TB_RoleFriends WHERE RoleId = @RoleId AND FriendRoleId = @FriendRoleId)
    BEGIN
        SELECT 0 AS Success, 'Already friends' AS Error;
        RETURN;
    END
    
    INSERT INTO TB_RoleFriends (RoleId, FriendRoleId, FriendName)
    VALUES (@RoleId, @FriendRoleId, @FriendName);
    
    SELECT 1 AS Success;
END;
GO

IF OBJECT_ID('SP_RemoveFriend', 'P') IS NOT NULL DROP PROCEDURE SP_RemoveFriend;
GO

CREATE PROCEDURE SP_RemoveFriend
    @RoleName NVARCHAR(50),
    @FriendName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @RoleId INT;
    SELECT @RoleId = Id FROM TB_Role WHERE Name = @RoleName;
    
    DELETE FROM TB_RoleFriends WHERE RoleId = @RoleId AND FriendName = @FriendName;
    
    SELECT @@ROWCOUNT AS AffectedRows;
END;
GO

PRINT 'Stored procedures created successfully!';
GO
