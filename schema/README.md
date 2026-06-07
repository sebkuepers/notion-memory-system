# Schema (canonical, as SQL DDL)

This directory is the **source of truth for the Memory OS structure.** Each `.sql` file defines one
database in the Notion hosted-MCP **`CREATE TABLE` dialect**, so the same files build the workspace
in the next phase (via `notion-create-database` / `notion-update-data-source`).

**Nothing here has been executed yet.** This is the design artifact; the build phase runs it.

## How the DDL maps to Notion

- `CREATE TABLE "Name" (...)` → a Notion **database** with one **data source**. The `TITLE` column is
  the page title (and per our convention is always a **full statement**).
- Type syntax: `TITLE`, `RICH_TEXT`, `DATE`, `CHECKBOX`, `URL`, `EMAIL`, `PHONE_NUMBER`, `NUMBER`,
  `SELECT('opt':color, …)`, `MULTI_SELECT(...)`, `RELATION('ds_id'[, DUAL ['Synced Name' 'synced_id']])`.
- A row's **page body** (rationale, prose, raw capture) is *not* a column — it's the page content,
  written at create time. Body usage is noted in each file's header comment.

## Conventions enforced here

- **`SELECT` for every status-like field** (not Notion's `STATUS` type): `STATUS` may not be
  API-creatable, and `SELECT` supports `equals` filtering. See `../docs/notion-capabilities.md`.
- **No read-only columns** (`formula`/`rollup`/`unique_id`/timestamps) are defined — they can't be
  written and aren't needed for retrieval here.
- **The deterministic filter set is `Scope` + `Venture` + `Status`**, present on every memory store.
- **Titles are statements.** Column comments restate this where the title column is defined.

## Relation placeholders

Relations need the **target data-source ID**. These were placeholder tokens at design time; the
structure has since been **built**, so the real IDs are below (full registry in
`../docs/workspace-map.md`):

| Token | Resolved data_source_id |
|---|---|
| `{{VENTURES_DS}}` | `011042db-7bea-43bb-bf24-cf2b1a30e4eb` |
| `{{PROJECTS_DS}}` | `bfd7a1a5-a4f3-4a15-b5d8-42261ff89336` (existing `Projects`) |
| `{{PEOPLE_DS}}` | `3a0b4200-0c34-491d-86dc-86de07c4916c` (existing `CRM - Contacts`) |
| `{{AGENTS_DS}}` | `bb4dd864-6c29-4736-97d4-6c87531c3311` |
| `{{DECISIONS_DS}}` | `7e287ca4-e86b-4e04-92b8-1b9fa11f6739` (for its self-relation) |

## Build order (relations require their targets to exist first)

1. `01-ventures.sql` — entity anchor, no outgoing relations
2. `02-projects-extend.sql` — `ALTER` the existing Projects DB (needs `{{VENTURES_DS}}`)
3. `03-agents.sql` — needs `{{VENTURES_DS}}`, `{{PROJECTS_DS}}`
4. `04-decisions.sql` — needs Ventures/Projects/People; then **two-step** self-relation `ALTER`
5. `05-knowledge.sql`, `06-strategy-goals.sql` — need Ventures/Projects
6. `07-daily-log.sql` — needs People/Projects
7. `08-inbox.sql`, `09-tasks.sql`, `10-preferences.sql`, `11-library.sql`

`People` is **reused** (existing `CRM - Contacts`) — no `CREATE`; it's only a relation target.
Pages (`🧠 Memory OS`, `📌 Top of Mind`, `👤 Profile`) are created separately (no schema).

## Build-phase smoke test (documented, not run now)

After creating a store, verify the full loop: create one seeded **Decision** → confirm a REST
`data_sources/query` filtered by `Venture` + `Status = Active` returns it → confirm MCP semantic
`search` surfaces it by its statement-title → confirm `fetch` returns its body.
