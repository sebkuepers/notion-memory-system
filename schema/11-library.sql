-- Library — long-form reference (Tier 2). Linked from memory, never auto-loaded into context.
-- Title = the piece's name. Link points to the long-form (a Notion page, doc, or URL).
-- Body may hold a short abstract so semantic search can route to it without loading the whole thing.

CREATE TABLE "Library" (
    "Title"   TITLE,
    "Kind"    SELECT('Essay':blue, 'Whitepaper':purple, 'Reference':gray, 'Framework':green),
    "Venture" RELATION('{{VENTURES_DS}}', DUAL 'Library' 'library'),
    "Link"    URL
);
