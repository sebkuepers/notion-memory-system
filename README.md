# 🧠 Notion Memory OS

A **platform-agnostic long-term memory / context layer built in Notion**, designed to be read
and written by a human (the Notion app on phone/desktop) *and* by multiple LLM clients
(Claude, ChatGPT, Mistral) plus a programmatic agent fleet.

> **Guiding principle: own the memory, rent the intelligence.**
> Notion is the canonical, sovereign substrate. Every model — Claude, ChatGPT, Mistral, on-prem,
> the agent fleet — is an interchangeable client. Each vendor's native memory is treated as a
> scratchpad; **Notion is the source of truth.**

## Status

**Design phase — this repo currently contains the design + schema only. Nothing has been created
in Notion yet.** The SQL DDL in [`schema/`](./schema) is execution-ready: the same files build the
workspace in the next phase.

| Phase | What | State |
|---|---|---|
| 1. Ground & design | map the live workspace, verify Notion's real capabilities, design the full IA, write it as schema-as-code | ✅ this repo |
| 2. Build | execute the DDL in Notion, wire relations, seed Top of Mind / Profile / Ventures / Agents | ⬜ next |
| 3. Ingest | dump existing Claude memory into `Inbox`, run the first distill pass | ⬜ |
| 4. Wire clients | `bootstrap/` adapters for Claude / ChatGPT / Mistral; publish the protocol page | ⬜ |

## Three hard design constraints (do not violate)

1. **Dual-reader.** Every artifact must serve a human browsing on a phone *and* an AI fetching
   context. Resolution: the unit of storage is a **database row** — its *properties* are the
   machine-queryable layer, its *page body* is the human-readable layer. One object, two readers.
2. **Sovereign + inspectable.** Human-auditable and hand-editable. No black boxes. The schema
   lives here in version control, not only inside Notion.
3. **Platform-agnostic.** The same substrate is usable from Claude, ChatGPT, Mistral, and
   programmatic agents — because they all reach the same Notion data.

## The architecture at a glance

```
🧠 MEMORY OS (hub page)
├─ TIER 0 · always loaded   📌 Top of Mind · 👤 Profile
├─ TIER 1 · stores (databases)
│    Persona:    Preferences
│    5 types:    Decisions · Knowledge · Strategy & Goals · People (CRM)
│    Entities:   Ventures · Projects · Agents
│    Capture:    Daily Log · 📥 Inbox
│    Doing:      Tasks
└─ TIER 2 · Library (reference, opened on demand)
```

The backbone is Sebastian's own ontology — **Strategic / Relationship / Knowledge / Process /
Decision** — reused verbatim from the existing *Context & Sparring* page. See
[`docs/architecture.md`](./docs/architecture.md) for the full design.

## Repo map

- [`docs/architecture.md`](./docs/architecture.md) — the complete information architecture:
  every store, the relation graph, the retrieval protocol, the capture→distill flow.
- [`docs/notion-capabilities.md`](./docs/notion-capabilities.md) — what Notion's API + hosted MCP
  can and cannot actually do (the rules every table obeys), with sources.
- [`docs/workspace-map.md`](./docs/workspace-map.md) — inventory of the live Notion workspace,
  the IDs we reuse, and what we deliberately leave alone.
- [`schema/`](./schema) — one `.sql` file per database, in the Notion MCP `CREATE TABLE` dialect,
  ready to execute. Start with [`schema/README.md`](./schema/README.md).
- [`.claude/skills/notion-memory/SKILL.md`](./.claude/skills/notion-memory/SKILL.md) — the
  portable operating protocol (read + write rules) that every client follows.

## The one rule that makes recall work

Notion's only reliable AI-facing search is **semantic + title-based** (REST search is title-only;
the MCP search is fuzzy; views are not API-queryable). Therefore **every title is written as a
full statement, not a label** — e.g. *"Data sovereignty is Ongiini's moat, not language
capability"*, not *"Moat"*. This single habit does more for both phone-scanning and AI retrieval
than anything else. The high-value filters (`Type`, `Venture`, `Scope`, `Status`) are real
properties so agents can query them deterministically.
