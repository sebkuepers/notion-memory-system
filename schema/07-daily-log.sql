-- Daily Log — dated journal / running narrative; raw material the distill pass mines.
-- Title = a short headline for the day or entry; Date carries the day.
-- Body = freeform capture. Processed marks an entry as distilled into the clean stores.

CREATE TABLE "Daily Log" (
    "Entry"     TITLE,                               -- short headline, e.g. "2026-06-07 — Ongiini moat call"
    "Date"      DATE,
    "People"    RELATION('{{PEOPLE_DS}}',   DUAL 'Daily Log' 'daily_log'),
    "Projects"  RELATION('{{PROJECTS_DS}}', DUAL 'Daily Log' 'daily_log'),
    "Processed" CHECKBOX                             -- ✓ once distilled
);
