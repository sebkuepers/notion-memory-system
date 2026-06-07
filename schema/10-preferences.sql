-- Preferences — atomic, queryable statements of how Sebastian wants AI (and collaborators)
-- to operate. Lets any client filter "how does he want X" deterministically.
-- Title = the preference as a statement, e.g.
--   "Prefers direct, concise answers with no preamble or flattery".

CREATE TABLE "Preferences" (
    "Preference" TITLE,                              -- full statement
    "Area"       SELECT('Communication':blue, 'Formatting':purple, 'Tooling':orange,
                        'Working Style':green, 'Boundaries':red, 'Values':yellow),
    "Scope"      SELECT('Global':purple, 'Venture':blue, 'Agent':orange),
    "Status"     SELECT('Active':green, 'Retired':gray)
);
