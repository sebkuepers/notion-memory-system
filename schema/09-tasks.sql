-- Tasks — next actions / todos. Blended into the system (per design decision), linked to
-- the Project and Venture they serve. Transient by nature; that is fine here. Never a secret.
-- Title = the action, e.g. "Draft the Fractional CAIO one-pager for Plan.Net".

CREATE TABLE "Tasks" (
    "Task"     TITLE,
    "Status"   SELECT('Todo':gray, 'Doing':blue, 'Done':green, 'Dropped':red),
    "Do Date"  DATE,                                 -- the day you plan to do it (drives "Today")
    "Top 3"    CHECKBOX,                             -- the daily top-3 mark (max 3 per day, by convention)
    "Due"      DATE,                                 -- the deadline (distinct from Do Date)
    "Priority" SELECT('High':red, 'Medium':yellow, 'Low':gray),
    "Project"  RELATION('{{PROJECTS_DS}}', DUAL 'Tasks' 'tasks'),
    "Venture"  RELATION('{{VENTURES_DS}}', DUAL 'Tasks' 'tasks')
);
-- Key views: "Today" (Do Date is today), "⭐ Top 3 today" (Do Date today AND Top 3 checked).
