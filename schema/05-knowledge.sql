-- Knowledge — durable know-how: lessons, findings, playbooks, working standards.
-- Covers the Knowledge and Process context types (Type discriminates).
-- Title = a full-statement insight, e.g.
--   "Weekly distill only sticks when the AI does the first pass and I approve a diff".
-- Body holds the detail / evidence / how-to. Source notes where it came from.

CREATE TABLE "Knowledge" (
    "Insight"  TITLE,                                -- full statement
    "Type"     SELECT('Knowledge':blue, 'Process':green),
    "Scope"    SELECT('Global':purple, 'Venture':blue, 'Agent':orange),
    "Status"   SELECT('Current':green, 'Outdated':gray),
    "Venture"  RELATION('{{VENTURES_DS}}', DUAL 'Knowledge' 'knowledge'),
    "Project"  RELATION('{{PROJECTS_DS}}', DUAL 'Knowledge' 'knowledge'),
    "Source"   RICH_TEXT,                            -- where this came from (no secrets)
    "Captured" DATE
);
