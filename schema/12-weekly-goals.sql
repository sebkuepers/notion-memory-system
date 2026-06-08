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
    "Added by" SELECT('Sebastian':blue, 'Claude':orange, 'ChatGPT':green, 'Mistral':purple, 'Agent':gray)
);
-- Key view: "This week" (Week Of is this week). LLMs read goals by querying Week Of = this week.
