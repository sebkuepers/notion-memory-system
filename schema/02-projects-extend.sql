-- Projects — REUSE + EXTEND the existing database (do NOT create a new one).
-- Existing data source: bfd7a1a5-a4f3-4a15-b5d8-42261ff89336
-- Existing columns: Name(title), Status, Priority, Description, Start Date, End Date,
--                   Budget, Organization Name, Tags(multi-select: project types).
-- We add a Venture relation so every Project belongs to a Venture. Decisions / Knowledge /
-- Tasks back-relate to Projects (defined in their own files).
-- NOTE: existing "Tags" are project TYPES (Ongiini/Foundation/Client Work/Internal/Open Source),
-- which is a different dimension from "Venture" — keep both.

ALTER TABLE "Projects"
    ADD COLUMN "Venture" RELATION('{{VENTURES_DS}}', DUAL 'Projects' 'projects');
