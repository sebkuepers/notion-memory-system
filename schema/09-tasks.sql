-- Tasks — next actions / todos. Blended into the system (per design decision), linked to
-- the Project and Venture they serve. Transient by nature; that is fine here. Never a secret.
-- Title = the action, e.g. "Draft the Fractional CAIO one-pager for Plan.Net".

CREATE TABLE "Tasks" (
    "Task"     TITLE,
    "Status"   SELECT('Todo':gray, 'Doing':blue, 'Done':green, 'Dropped':red),
    "Due"      DATE,
    "Priority" SELECT('High':red, 'Medium':yellow, 'Low':gray),
    "Project"  RELATION('{{PROJECTS_DS}}', DUAL 'Tasks' 'tasks'),
    "Venture"  RELATION('{{VENTURES_DS}}', DUAL 'Tasks' 'tasks')
);
