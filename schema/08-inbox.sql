-- Inbox — frictionless raw capture AND the landing zone for the one-time Claude memory dump.
-- Deliberately minimal: no required schema beyond a type guess and a processed flag.
-- Title = whatever the capture is; raw content goes in the page BODY.
-- Guess Type lets the distill pass triage by the five context types.

CREATE TABLE "Inbox" (
    "Note"       TITLE,
    "Captured"   DATE,
    "Processed"  CHECKBOX,                           -- ✓ once distilled into a clean store
    "Guess Type" SELECT('Strategic':purple, 'Relationship':pink, 'Knowledge':blue,
                        'Process':green, 'Decision':orange)
);
