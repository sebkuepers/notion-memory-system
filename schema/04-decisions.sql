-- Decisions — the flagship store: the decision log (context type = Decision).
-- Title = the full decision statement, e.g.
--   "Data sovereignty is Ongiini's moat, not language capability".
-- Body holds: Rationale / Alternative considered / Outcome / Review date.
-- Supersede, never delete: contradictions flip Status and link via the self-relation.

CREATE TABLE "Decisions" (
    "Decision"      TITLE,                           -- full statement, not a label
    "Scope"         SELECT('Global':purple, 'Venture':blue, 'Agent':orange),
    "Status"        SELECT('Active':green, 'Superseded':gray, 'Reversed':red),
    "Decision Date" DATE,
    "Venture"       RELATION('{{VENTURES_DS}}', DUAL 'Decisions' 'decisions'),
    "Project"       RELATION('{{PROJECTS_DS}}', DUAL 'Decisions' 'decisions'),
    "People"        RELATION('{{PEOPLE_DS}}',   DUAL 'Decisions' 'decisions')
);

-- Two-step self-relation (the audit chain). Run AFTER the table above exists,
-- substituting the new Decisions data-source id for {{DECISIONS_DS}}:
ALTER TABLE "Decisions"
    ADD COLUMN "Supersedes" RELATION('{{DECISIONS_DS}}', DUAL 'Superseded By' 'superseded_by');
