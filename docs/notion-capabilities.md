# Notion capabilities & constraints (the rules every table obeys)

This is the grounded reference the schema is designed against. It records what Notion's **REST API**
and **hosted MCP server** (`mcp.notion.com`) can and cannot actually do, as of **2025–2026**.
Claims are tagged **[VERIFIED]** (primary docs + corroboration), **[LIKELY]** (single credible
source), or **[INFERENCE]** (reasoning). Anything dated 2026 is fast-moving — re-check before relying.

## 1. Data model (post-`2025-09-03`)

- The hierarchy is now **Workspace → Database (container) → one-or-more Data Sources → Pages (rows)
  → Blocks.** A database is a *container*; the queryable thing is a **data source**. **[VERIFIED]**
- **Query and identify by `data_source_id`, not `database_id`.** If a database gains a second data
  source, integrations addressing it by `database_id` break. Always store the data-source ID.
  Pin the `Notion-Version: 2025-09-03` header. **[VERIFIED]**
- A **row is a full Page**: it has both **properties** (structured columns) and a **body of blocks**
  (free-form content). This dual nature is the core asset — structured metadata + prose on one
  object. **[VERIFIED]**
- The hosted MCP models Notion as **SQLite** and takes schema as **SQL DDL** (`CREATE TABLE`,
  `ADD COLUMN`, `RENAME COLUMN`, `ALTER COLUMN`). This is why our canonical schema is SQL DDL —
  it is both human-readable and directly executable. **[VERIFIED, from the live MCP tool surface]**

### Property types
`title`, `rich_text`, `number`, `select`, `multi_select`, `status`, `date`, `people`, `files`,
`checkbox`, `url`, `email`, `phone_number`, `formula`, `relation`, `rollup`, `created_time`,
`created_by`, `last_edited_time`, `last_edited_by`, `unique_id`, `verification`, `button`, plus a
UI `place`/location type. **[VERIFIED for the core set]**

### Write constraints (design-load-bearing)
- **Read-only — cannot be created/set via API:** `formula`, `rollup`, `created_time`, `created_by`,
  `last_edited_time`, `last_edited_by`, `unique_id`, `button`. Never design a write that sets these.
  **[VERIFIED]**
- `status` and `unique_id` **may not be creatable in a schema via API** (must be added in the UI).
  **→ We use `SELECT` for all status-like fields** (also supports `equals` filtering). **[LIKELY]**
- `verification` status *can* be set via create/update page (its `verified_by` is auto-set). Useful
  as a human "this row is trusted, re-review by <date>" gate. **[LIKELY]**

### Relations & rollups
- **Relation** = link from a page to pages in a target **data source** (referenced by its
  `data_source_id`). Can be one-way or two-way (`DUAL`, optionally with a synced property name).
  **[VERIFIED]**
- **Self-relations are two-step:** create the table first, then `ADD COLUMN ... RELATION(self_ds_id,
  DUAL 'Other Side' 'other_side')`. **[VERIFIED, from MCP tool docs]**
- **Rollup** = server-computed aggregation over a relation. **Read-only via API.** Don't make
  rollups load-bearing for retrieval at scale (can be slow). **[VERIFIED]**

## 2. The three access paths (no single shared retrieval object)

| Reader | Path | Character |
|---|---|---|
| Human | Notion app + **Views** | filtered, browsable — **human-only** |
| LLM clients (Claude/ChatGPT/Mistral) | hosted MCP: **semantic `search` + `fetch` by id** | fuzzy, non-deterministic |
| Fleet / programmatic | **REST `POST /v1/data_sources/{id}/query`** | deterministic property filtering |

- **Views are NOT queryable through the API or MCP.** Fetching a database/view returns its
  *configuration*, not its filtered rows ([makenotion/notion-mcp-server#149]). Views are a
  human convenience only. **[VERIFIED]**
- **The hosted MCP has no working property-filter query.** `notion-search` is **semantic** and only
  supports `created_date_range`, `created_by_user_ids`, `teamspace_id`, and scoping to a
  `data_source_url`. There is no `query_database`-style tool ([#166]). Deterministic filtering must
  use the **REST** query endpoint. **[VERIFIED]**
- **REST `/v1/search` is title-only** (literally "Search by title") — it does **not** search page
  body/block content. **[VERIFIED]**

> **The single most important consequence:** reliable AI recall depends on **titles + properties**.
> So titles are written as **full statements**, and every high-value filter (`Type`, `Venture`,
> `Scope`, `Status`) is a real **property**. Do not rely on body-text search or on views for recall.

### REST query: filters & limits
- No SQL. Retrieval is a JSON `filter` + `sorts` object. **[VERIFIED]**
- Operators exist per type (text: `equals`/`contains`/`starts_with`/…; `select`: `equals`;
  `multi_select`/`status`/`relation`: `contains`; `date`: `before`/`after`/`on_or_before`/relative
  `past_week`…; `number`: comparisons; `checkbox`: `equals`). **`contains` is substring, not
  semantic.** **[VERIFIED]**
- **Compound filters nest only TWO levels deep** (`and`/`or`). **[VERIFIED]**
- **`page_size` max = 100.** Cursor pagination via `start_cursor` → `has_more`/`next_cursor`. A
  single query paginates through at most **~10,000 results**. **[VERIFIED]**
- **Rate limit ≈ 3 requests/second** per integration (bursts allowed); 429 + `Retry-After` on
  breach. Payloads ≤ ~1,000 blocks / 500 KB per request. **[VERIFIED]**

**Design math:** 100 rows/page × 3 req/s means a full scan of 100k rows ≈ 1,000 requests ≈ ~5.5 min.
Keep any single recall query **filter-narrowed** well under the caps; never design "scan everything."

## 3. Hosted MCP (`mcp.notion.com/mcp`)

- Tools (this environment's live surface): `notion-search`, `notion-fetch`, `notion-create-pages`,
  `notion-update-page`, `notion-move-pages`, `notion-duplicate-page`, `notion-create-database`,
  `notion-update-data-source`, `notion-create-view`, `notion-update-view`, `notion-create-comment`,
  `notion-get-comments`, `notion-get-users`, `notion-get-teams`. **[VERIFIED]**
- `notion-search` is **semantic / natural-language**; with a Notion AI plan it also spans connected
  apps (Slack, Drive, GitHub, Jira, …). Without a paid plan it is **workspace-only**. **[VERIFIED]**
- Returns **Notion-flavored Markdown** at **page granularity** (no block-level get/append). **[VERIFIED]**
- `notion-create-database` / `notion-update-data-source` take **SQL DDL**; `notion-create-view`
  takes a `FILTER/SORT/GROUP` DSL (for building human views). **[VERIFIED]**
- Same ~3 req/s ceiling as REST. **[VERIFIED]**
- **Client differences are mostly client-side, not server-side:** all clients get the same tools,
  but differ in how many tools they register and orchestration quality. Mistral's first-party Notion
  connector status is **unconfirmed** — verify in Le Chat. **[INFERENCE / UNCERTAIN]**

## 4. Native Notion AI — usefulness vs portability

Treat **all** Notion-native AI as **"compute that writes into portable storage."** The only
portable artifacts are **property values and page/block content**.

| Feature | Use for memory | Portable across LLM clients? |
|---|---|---|
| Notion AI (chat/writing) | in-place summarize/distill | **No** — Notion UI only |
| Notion Q&A (RAG) | human recall; same engine as MCP search | partly — via MCP search only; plan-gated |
| **AI Autofill (DB property)** | **auto-classify/tag/summarize captured notes → the distill first-pass** | mechanism locked, but **output lands in a normal readable property** → portable |
| Notion 3.0 / 3.3 Agents | unattended distill pipelines that write back to DBs | runtime locked; outputs portable |

**Rule:** never make *recall* depend on invoking a Notion-only AI feature — ChatGPT/Mistral can't
trigger it. Autofill (the distill engine) requires a **paid Notion AI plan**; that is the one
upgrade that directly buys capability here. Everything else works on the free tier.

## Sources
- Notion docs: [Upgrade guide 2025-09-03](https://developers.notion.com/docs/upgrade-guide-2025-09-03) ·
  [Query a data source](https://developers.notion.com/reference/query-a-data-source) ·
  [Filter data source entries](https://developers.notion.com/reference/filter-data-source-entries) ·
  [Search by title](https://developers.notion.com/reference/post-search) ·
  [Request limits](https://developers.notion.com/reference/request-limits) ·
  [Page property values](https://developers.notion.com/reference/page-property-values) ·
  [MCP](https://developers.notion.com/docs/mcp)
- GitHub: [notion-mcp-server#166 (no query_database)](https://github.com/makenotion/notion-mcp-server/issues/166) ·
  [#149 (views not query-able)](https://github.com/makenotion/notion-mcp-server/issues/149)
- Notion: [Hosted MCP inside look](https://www.notion.com/blog/notions-hosted-mcp-server-an-inside-look) ·
  [Notion 3.0](https://www.notion.com/blog/introducing-notion-3-0) · [AI Autofill](https://www.notion.com/help/autofill)
- Analysis: [StackOne MCP deep dive](https://www.stackone.com/blog/notion-mcp-deep-dive/) ·
  [Thomas Frank: databases & data sources](https://thomasjfrank.com/notion-databases-can-now-have-multiple-data-sources/)
