-- Ventures — the long-running anchors of the relation spine.
-- One row per venture; the page BODY is the venture "brain" (links down to its
-- Decisions / Knowledge / Strategy & Goals / Projects).
-- Title is the venture name (the one store where the title is a name, not a statement).
-- Seed rows: Ongiini, Sokosumi, Masumi, CIF, Plan.Net, Personal Brand, Personal.

CREATE TABLE "Ventures" (
    "Venture"   TITLE,
    "Status"    SELECT('Active':green, 'Paused':yellow, 'Archived':gray),
    "One-liner" RICH_TEXT,                          -- one sentence: what this venture is
    "Role"      RICH_TEXT                            -- Sebastian's role in it
);
