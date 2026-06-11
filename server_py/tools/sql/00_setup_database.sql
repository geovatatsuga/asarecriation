-- ==============================================
-- Asa de Cristal - Complete Database Setup
-- Execute este arquivo para criar todo o banco de dados
-- ==============================================

-- Ordem de execução:
-- 1. core_tables.sql        - Contas, Sessões, Servidores, Personagens
-- 2. inventory_tables.sql   - Itens, Inventário, Equipamentos
-- 3. game_systems_tables.sql - Buffs, Monstros, Spawns
-- 4. stored_procedures.sql  - Todas as Stored Procedures

USE master;
GO

-- Criar banco de dados (altere o nome conforme necessário)
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'mspt1')
BEGIN
    CREATE DATABASE mspt1;
    PRINT 'Database mspt1 created.';
END
GO

USE mspt1;
GO

PRINT '==============================================';
PRINT 'Starting database setup...';
PRINT '==============================================';

-- Execute os scripts individuais na ordem:
-- :r core_tables.sql
-- :r inventory_tables.sql
-- :r game_systems_tables.sql
-- :r stored_procedures.sql

-- OU execute manualmente cada arquivo no SQL Server Management Studio

PRINT '';
PRINT 'IMPORTANT: Execute the following scripts in order:';
PRINT '1. core_tables.sql';
PRINT '2. inventory_tables.sql';
PRINT '3. game_systems_tables.sql';
PRINT '4. stored_procedures.sql';
PRINT '';
PRINT '==============================================';
PRINT 'Database setup instructions complete.';
PRINT '==============================================';
GO
