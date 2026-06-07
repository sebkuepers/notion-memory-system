# Memory OS — Information Architecture

The complete design of the Notion Memory OS: what it stores, how the pieces relate, how each reader
retrieves from it, and how raw capture becomes durable memory.

Read [`notion-capabilities.md`](./notion-capabilities.md) first — it defines the constraints every
decision here is made against.

## Design stances (decided with Sebastian)

- **Full coverage.** The system spans the whole surface of a life/work memory, not a narrow note
  store: persona, the five context types, the entities they attach to, capture surfaces, and doing.
- **Blended, not quarantined.** Durable memory and operational/transient things (todos, daily notes)
  live in **one system**, no hard wall. The only inviolable write rule is **never store secrets,
  credentials, or tokens.**
- **Schema-as-code.** The canonical schema is SQL DDL in [`../schema/`](../schema); Notion is built
  *from* it, not the other way around.
- **Ontology reused verbatim.** The five context types come straight from the existing
  *Context & Sparring* page: **Strategic / Relationship / Knowledge / Process / Decision.**

## The tiers (a retrieval policy, not just a layout)

```
🧠 MEMORY OS (hub page)
│
├─ TIER 0 · always loaded ── policy-loaded; fetched every session, no search required
│    📌 Top of Mind        synthesized now-state (≈ one screen)
│    👤 Profile            stable identity, roles, venture roster, agent fleet, values
│
├─ TIER 1 · stores ──────── retrieved on demand (semantic search / REST filter / relation hops)
│    Persona:   Preferences
│    5 types:   Decisions · Knowledge · Strategy & Goals · People (CRM)
│    Entities:  Ventures · Projects · Agents
│    Capture:   Daily Log · 📥 Inbox
│    Doing:     Tasks
│
└─ TIER 2 · Library ─────── long-form reference; linked from memory, opened only when asked
```

- **Tier 0 is the reliable layer.** It needs no search to work — the protocol just fetches it. Put
  anything you cannot afford the AI to miss here.
- **Tier 1 is best-effort + deterministic.** LLM clients reach it by fuzzy semantic search; the
  agent fleet reaches it by exact REST property filters. Both work because titles are statements and
  filters are real properties.
- **Tier 2 stays out of context** until explicitly pulled, so long essays never bloat a session.

## The relation spine

What turns a pile of tables into a system:

```
Ventures ──< Projects ──< Tasks
   │            │
   │            └──< Decisions >── People
   │            └──< Knowledge          ^
   │            └──< Strategy & Goals    │ (self) Supersedes / Superseded By
   │                                     on Decisions
Agents ──> Ventures / Projects
Daily Log ──> People / Projects
(everything) ──> Library  (links, not relations, where lightweight)
```

- **Ventures** are the long-running anchors; **Projects** are time-bound and belong to a Venture;
  **Tasks** belong to a Project.
- **Decisions / Knowledge / Strategy & Goals** attach to a Venture and (optionally) a Project, so a
  Project's page can surface every decision, lesson, and goal beneath it via 1–2 relation hops.
- **Decisions** also relate to **People** (who a decision concerns) and to themselves
  (**Supersedes / Superseded By**) for the audit chain.
- **Agents** (the fleet) relate to the Ventures/Projects they operate on; `Scope = Agent` memory
  links to them.

## The stores

### Tier 0 — always loaded
- **📌 Top of Mind** *(page)* — current top priorities, one line of status per venture, current
  focus, and hard constraints. Kept to ~one screen. This is *Sebastian's morning glance == the AI's
  core context*. It is policy-loaded: the protocol fetches it first, every time.
- **👤 Profile** *(page)* — slow-changing identity: short bio, the roles he plays, the venture
  roster, the agent fleet, core values and non-negotiables.

### Persona
- **Preferences** *(db)* — atomic, queryable statements about how Sebastian wants AI (and
  collaborators) to operate. `Area` ∈ Communication / Formatting / Tooling / Working Style /
  Boundaries / Values. Lets a client filter "how does he want X" deterministically.

### The five context types
- **Decisions** *(db — flagship)* — the decision log. Each row is a full-statement decision with
  rationale / alternative considered / outcome / review date in the body. `Status` ∈ Active /
  Superseded / Reversed; **never deleted** — contradictions are *superseded*, with the chain linked.
  This is the highest-leverage artifact: it captures *why*, which models otherwise lack.
- **Knowledge** *(db)* — lessons, findings, playbooks, and how-I-work standards. `Type` ∈ Knowledge /
  Process (the two "durable know-how" context types). `Status` ∈ Current / Outdated.
- **Strategy & Goals** *(db)* — objectives, bets, positioning, priorities over time (the Strategic
  context type). `Horizon` ∈ Now / Quarter / Year / Long-term.
- **People** *(db — reuse existing CRM)* — the Relationship context type. Uses the existing
  `CRM - Contacts` (dummy data today; owned by a separate email-automation project). Wired into the
  spine by relation only; not rebuilt here.

### Entities
- **Ventures** *(db)* — Ongiini, Sokosumi, Masumi, CIF, Plan.Net, Personal Brand, Personal. Each row
  is a venture "brain" — its body links down to the Decisions/Knowledge/Goals/Projects beneath it.
- **Projects** *(db — reuse/extend existing `Projects`)* — time-bound initiatives. The existing DB
  already has Status/Priority/Dates/Budget/Tags; we add a `Venture` relation and let
  Decisions/Knowledge/Tasks back-relate to it.
- **Agents** *(db)* — the fleet (Elena, Hannah, Alex, Sentinel, Circuit): role, scope, the
  Ventures/Projects each runs, and a pointer to its config.

### Capture
- **Daily Log** *(db)* — dated journal/log entries; the running narrative the distill pass mines.
  Relates to the People/Projects a day touched; `Processed` marks distilled.
- **📥 Inbox** *(db)* — frictionless raw capture and **the landing zone for the one-time Claude
  memory dump.** Minimal schema: a `Guess Type` select and a `Processed` checkbox; raw text in body.

### Doing
- **Tasks** *(db)* — next actions / todos linked to a Project and Venture. Blended in per Sebastian's
  choice; `Status` ∈ Todo / Doing / Done / Dropped.

### Tier 2 — reference
- **Library** *(db)* — long-form content: the Slow Intelligence whitepaper, essays, frameworks.
  `Kind` ∈ Essay / Whitepaper / Reference / Framework. Linked from memory; never auto-loaded.

## Cross-cutting conventions (apply to every store)

- **Title = full statement, not a label.** This is load-bearing for both phone-scanning and AI
  recall (see capabilities doc). *"Human review is Ongiini's trust layer, not a bottleneck"* — not
  *"Review"*.
- **The deterministic filter set is `Scope` + `Venture` + `Status`** on every memory row. `Scope` ∈
  Global / Venture / Agent. These are real `SELECT`/relation properties so the fleet can query them
  exactly.
- **Supersede, don't delete.** Contradiction → mark the old row Superseded/Outdated/Reversed and link
  the replacement. The audit trail is preserved for the human; the `Status` filter keeps stale rows
  out of AI reads.
- **Durable-only, except never secrets.** Blended system, so todos/notes are fine; secrets,
  credentials, and tokens are never written.

## Retrieval protocol (the portable operating procedure → `SKILL.md`)

1. **Always** fetch `Top of Mind` and `Profile` first (Tier 0, policy-loaded).
2. For the task at hand:
   - LLM clients: **semantic search** scoped to the relevant store (`data_source_url`), then `fetch`
     the promising rows.
   - Programmatic agents: **REST `data_sources/query`** filtered by `Venture` / `Type` / `Status`.
   - Either: traverse relations 1–2 hops (Project → its Decisions / Knowledge / Tasks).
3. Open `Library` long-form only when explicitly needed.
4. **Write:** propose the write for human confirmation → write to the *correct* store with a
   statement-title and the required properties → **dedup first** (search for a near-duplicate; update
   or supersede rather than create) → never write secrets.

## Capture → distill (the curation discipline)

```
   raw capture                    weekly (human-gated) distill                clean stores
┌───────────────┐   frictionless  ┌───────────────────────────┐   atomic    ┌──────────────┐
│ 📥 Inbox       │ ───────────────▶│ review each unprocessed   │ ──────────▶ │ Decisions    │
│ 🗓 Daily Log    │                 │ row: classify, dedup,     │   rows      │ Knowledge    │
│ (Claude dump)  │                 │ supersede, set properties │             │ Strategy…    │
└───────────────┘                 │ → flip `Processed` ✓       │             │ Preferences… │
                                   └───────────────────────────┘             └──────────────┘
```

- Everything raw enters **Inbox** or **Daily Log** with near-zero friction.
- The big **"dump everything from Claude"** lands in Inbox, each item tagged with a `Guess Type`.
- The **distill pass** is human-in-the-loop (the curation discipline). On a **paid Notion AI plan**,
  Autofill can do the first-pass classification/summary into properties; the human approves. Never
  auto-write straight into the clean stores without that review gate.
- `Processed` closes the loop so nothing is distilled twice.

## Views (the human-facing retrieval layer)

Because the API can't query *through* a view, views are for the **human** reader; the AI uses
search/relations. Built per store: Decisions *Active* / *By Scope*; Knowledge *Current by Type*;
Strategy & Goals *Active by Horizon*; Tasks *Board*; Inbox *Unprocessed* / *By Type*; Daily Log
*Recent*; Preferences *By Area*; Projects *Active*; Ventures *By Status*; Library *By Kind*. The
hub also carries two linked cockpit views: *Active decisions* and *Inbox · to distill*.

## Curation / trust signal

Each clean store (Decisions, Knowledge, Strategy & Goals, Preferences) has an **`Added by`**
select (Sebastian / Claude / ChatGPT / Mistral / Agent) so AI-written rows are reviewable — the
seeded rows are marked `Claude`. During distill, mark a reviewed row **verified** (Notion's page
verification, with an expiry) as the human trust gate.

## What's intentionally deferred

Merging the legacy Brand Strategy hub into Slow Intelligence OS; real Top of Mind / Profile content
and venture/agent detail (need Sebastian); the big Claude-memory dump; database **templates** to
enforce the Decision/Knowledge body structure (the hosted MCP can't create templates — a one-time
Notion-UI step).
