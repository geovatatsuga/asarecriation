-- Task and Wing systems for the Python/PostgreSQL runtime.
-- Safe to run multiple times against the main mspt1 database.

-- TB_Task: Main task definitions (tasks 4999-5020 from _main_tasks_4990_5020.json + itl.json)
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
);

-- TB_RoleWing: Per-role wing data
CREATE TABLE IF NOT EXISTS TB_RoleWing (
    RoleName TEXT PRIMARY KEY REFERENCES TB_Role(Name) ON DELETE CASCADE,
    WingModelCode TEXT DEFAULT '',
    WingLevel INTEGER DEFAULT 0,
    WingExp BIGINT DEFAULT 0,
    WingSkillIds JSONB DEFAULT '[]'::jsonb,
    WingActivated BOOLEAN DEFAULT FALSE,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add Wing columns to TB_Role
ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS WingModelCode TEXT DEFAULT '';
ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS WingLevel INTEGER DEFAULT 0;
ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS WingExp BIGINT DEFAULT 0;
ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS WingSkillIds JSONB DEFAULT '[]'::jsonb;
ALTER TABLE TB_Role ADD COLUMN IF NOT EXISTS WingActivated BOOLEAN DEFAULT FALSE;

-- Indexes for TB_Task
CREATE INDEX IF NOT EXISTS idx_tb_task_pre_task ON TB_Task(PreTaskId);
CREATE INDEX IF NOT EXISTS idx_tb_task_next_task ON TB_Task(NextTaskId);
CREATE INDEX IF NOT EXISTS idx_tb_task_npc ON TB_Task(NpcId);

-- Index for TB_RoleWing
CREATE INDEX IF NOT EXISTS idx_tb_role_wing_model ON TB_RoleWing(WingModelCode);
