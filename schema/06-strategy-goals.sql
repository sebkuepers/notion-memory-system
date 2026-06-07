-- Strategy & Goals — objectives, bets, positioning, priorities over time.
-- Covers the Strategic context type.
-- Title = the objective as a statement, e.g.
--   "Win on data sovereignty before competing on model quality".
-- Body holds the thinking / context. Relates to the Decisions and Projects that serve it
-- (via those stores' Venture/Project relations and link mentions in the body).

CREATE TABLE "Strategy & Goals" (
    "Objective"   TITLE,                             -- full statement
    "Horizon"     SELECT('Now':red, 'Quarter':orange, 'Year':blue, 'Long-term':purple),
    "Status"      SELECT('Active':green, 'Achieved':blue, 'Dropped':gray),
    "Venture"     RELATION('{{VENTURES_DS}}', DUAL 'Strategy & Goals' 'strategy_goals'),
    "Metric"      RICH_TEXT,                          -- how success is measured, if any
    "Review Date" DATE
);
