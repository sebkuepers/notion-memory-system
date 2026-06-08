-- Weekly Goals — one row per goal, stamped with the week's Monday. STANDALONE (deliberately not
-- linked to Tasks — that was judged overengineering). The Monday ritual: add the week's goals.
-- Title = the goal as a statement, e.g. "Ship the Le Chat connector to Pro users".
-- Set up a repeating database TEMPLATE in the UI (Repeat → Weekly → Monday) to auto-create the
-- week's scaffold every Monday — the API can't create repeating templates.

CREATE TABLE "Weekly Goals" (
    "Goal"     TITLE,                                -- full statement
    "Week Of"  DATE,                                 -- the Monday of the week
    "Status"   SELECT('Open':blue, 'Achieved':green, 'Missed':red),
    "Progress" NUMBER,                               -- optional; format as percent in the UI
    "Venture"  RELATION('{{VENTURES_DS}}', DUAL 'Weekly Goals'),
    "Added by" SELECT('Sebastian':blue, 'Claude':orange, 'ChatGPT':green, 'Mistral':purple, 'Agent':gray),
    -- The view DSL can't express Notion's relative date-range filter ("this week"), so we compute
    -- it in a formula and filter on its STRING output (the DSL filters formulas as text, so it must
    -- return "yes"/"no", not a boolean). Auto-rolls each week.
    "This Week?" FORMULA('if(empty(prop("Week Of")), "no", if(and(dateBetween(now(), prop("Week Of"), "days") >= 0, dateBetween(now(), prop("Week Of"), "days") <= 6), "yes", "no"))')
);
-- Key view: "This week" = FILTER "This Week?" = "yes". LLMs query Week Of within the current week.
