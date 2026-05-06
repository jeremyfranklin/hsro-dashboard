-- ═══════════════════════════════════════════════════════════════════
--  HSRO FY27 Goals Dashboard — Supabase Database Schema
--  Run this SQL in your Supabase project's SQL Editor
--  (supabase.com → your project → SQL Editor → New query)
-- ═══════════════════════════════════════════════════════════════════

-- 1. Create the goal_updates table
CREATE TABLE IF NOT EXISTS goal_updates (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  goal_id     TEXT        NOT NULL,       -- e.g. "SA-1", "IRE-2"
  goal_label  TEXT,                       -- e.g. "SA-1 · HSC Cores"
  category    TEXT,                       -- e.g. "Strategic Alignment"
  status      TEXT        NOT NULL
              CHECK (status IN (
                'not_started',
                'in_progress',
                'on_track',
                'completed',
                'at_risk'
              )),
  comment     TEXT,                       -- optional free-text comment
  author      TEXT        NOT NULL,       -- person logging the update
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Index for fast queries by goal and date
CREATE INDEX IF NOT EXISTS idx_goal_updates_goal_id
  ON goal_updates (goal_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_goal_updates_created_at
  ON goal_updates (created_at DESC);

-- 3. Enable Row Level Security
ALTER TABLE goal_updates ENABLE ROW LEVEL SECURITY;

-- 4. Allow anyone to READ (the dashboard is public)
CREATE POLICY "Public read access"
  ON goal_updates
  FOR SELECT
  USING (true);

-- 5. Allow anonymous INSERT (the password gate is in the frontend)
CREATE POLICY "Anonymous insert"
  ON goal_updates
  FOR INSERT
  WITH CHECK (true);

-- ── Optional: seed with a test record to verify setup ────────────────
-- INSERT INTO goal_updates (goal_id, goal_label, category, status, author, comment)
-- VALUES ('SA-1', 'SA-1 · HSC Cores', 'Strategic Alignment', 'in_progress',
--         'Setup Test', 'Initial test record — delete after confirming dashboard loads correctly.');
