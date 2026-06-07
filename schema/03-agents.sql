-- Agents — the agent fleet (Elena, Hannah, Alex, Sentinel, Circuit).
-- Title is the agent name. Body holds the longer role description / operating notes.
-- Scope = Agent memory in other stores relates back here.

CREATE TABLE "Agents" (
    "Agent"          TITLE,
    "Role"           RICH_TEXT,                      -- what this agent does, in one line
    "Scope"          SELECT('Venture':blue, 'Global':purple),
    "Status"         SELECT('Active':green, 'Planned':yellow, 'Retired':gray),
    "Ventures"       RELATION('{{VENTURES_DS}}', DUAL 'Agents' 'agents'),
    "Config / Source" URL                            -- pointer to config/repo (never a secret)
);
