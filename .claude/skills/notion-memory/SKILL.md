---
name: notion-memory
description: >-
  Operating protocol for Sebastian's Notion "Memory OS" — the canonical long-term memory.
  Use at the start of any work session, and whenever recalling context about Sebastian, his
  ventures (Ongiini, Sokosumi, Masumi, CIF, Plan.Net, Personal Brand), decisions, people,
  preferences, or knowledge — and whenever durable information worth remembering is produced.
---

# Notion Memory OS — operating protocol

> **DRAFT.** The protocol page URL and data-source IDs are filled in after the Notion build phase.
> This is written in **capability terms** ("fetch the page titled X", "create a row in Decisions")
> rather than tool names, so it maps cleanly across connectors (Claude, ChatGPT, Mistral, REST).

Notion is Sebastian's **canonical** memory. This platform's native memory is a scratchpad — when
they disagree, **Notion wins.** Own the memory, rent the intelligence.

## At the start of work — ALWAYS

1. **Fetch `📌 Top of Mind`** (a page) and **`👤 Profile`** (a page). These are policy-loaded: load
   them every session without being asked. They carry current priorities, per-venture status,
   working preferences, and hard constraints.

That is the only mandatory load. Everything else is fetched on demand for the task at hand.

## Reading for a task

Pick the path that fits the client:

- **Conversational clients (Claude / ChatGPT / Mistral):** run a **semantic search** scoped to the
  relevant store, then fetch the promising rows by id. Search is fuzzy — phrase queries the way the
  stored *statement-titles* read.
- **Programmatic / agent fleet:** run a **structured query** (REST `data_sources/query`) filtered by
  the real properties — `Venture`, `Type`, `Status`. This is the deterministic path.
- **Either:** follow **relations 1–2 hops** — e.g. open a Venture or Project and read the Decisions,
  Knowledge, Goals and Tasks linked beneath it.

Which store for what:

| You need… | Store |
|---|---|
| how Sebastian wants you to behave | **Preferences** (+ Top of Mind / Profile) |
| why something was decided | **Decisions** (filter `Status = Active`) |
| a lesson / playbook / how-he-works | **Knowledge** |
| goals / strategy / priorities | **Strategy & Goals** |
| a person and how to engage them | **People** (CRM) |
| the brief on a venture / project | **Ventures** / **Projects** |
| an agent's role/scope | **Agents** |
| what happened recently | **Daily Log** |
| open todos | **Tasks** |
| long-form essays / whitepaper | **Library** (only when explicitly needed) |

Always prefer **`Status = Active` / `Current`** rows. Superseded/Outdated/Reversed rows exist for the
audit trail — don't treat them as current truth.

## Writing to memory

Write only **durable, reusable** information. **Never** write secrets, credentials, or tokens.

Before creating anything:
1. **Propose the write** and get Sebastian's confirmation. Do not silently auto-write to the clean
   stores (Decisions / Knowledge / Strategy & Goals / Preferences).
2. **Dedup first.** Search the target store for a near-duplicate. If one exists, **update or
   supersede** it rather than create a second row.
3. Write to the **correct store** with the **exact title and property rules** below.
4. On contradiction, **supersede — don't delete:** flip the old row's `Status`
   (Superseded / Outdated / Reversed) and link the replacement.

Frictionless capture is the exception: raw notes and the Claude memory dump go straight into
**`📥 Inbox`** (or **`Daily Log`**) with no ceremony, to be distilled later.

### The one rule that makes recall work
**Every title is a full statement, not a label.**
✅ *"Human review is Ongiini's trust layer, not a bottleneck"* ❌ *"Trust"*
This serves both phone-scanning and AI retrieval more than anything else.

### Write template — a Decision
```
Title:  <full statement of the decision>
Scope:  Global | Venture | Agent
Status: Active
Decision Date: <today>
Venture/Project/People: <relations, as relevant>
Body:
  - Decision: …
  - Rationale: …
  - Alternative considered: …
  - Outcome / review date: …
```
Other stores follow the same spirit: statement-title, set `Scope`/`Venture`/`Status`, put the prose
in the body. See `schema/` for each store's exact properties.

## Distill (the weekly discipline)

Turn raw capture into clean memory: review each unprocessed `Inbox` / `Daily Log` item → classify it
by the five context types → dedup → supersede where it contradicts → write an atomic row to the right
store with a statement-title and properties → check `Processed`. Never auto-write into the clean
stores without Sebastian's review.

## The five context types (Sebastian's ontology — reuse, don't reinvent)

**Strategic** (vision/goals/principles) · **Relationship** (people) · **Knowledge** (lessons,
findings) · **Process** (how he works) · **Decision** (choices + rationale + outcome).
