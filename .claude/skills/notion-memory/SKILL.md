---
name: notion-memory
description: >-
  Operating protocol for Sebastian's Notion "Memory OS" — the canonical long-term memory.
  Use at the start of any work session; whenever recalling context about Sebastian, his ventures
  (Ongiini, Sokosumi, Masumi, CIF, Plan.Net, Personal Brand), decisions, people, preferences, or
  knowledge; whenever durable information worth remembering is produced; and to INGEST a
  conversation history or document dump into the memory system.
---

# Notion Memory OS — operating protocol

Notion is Sebastian's **canonical** long-term memory. This platform's native memory is a
scratchpad — when they disagree, **Notion wins.** Own the memory, rent the intelligence.

Written in **capability terms** ("fetch the page titled X", "create a row in Decisions") so it maps
across connectors (Claude Code, Claude.ai, ChatGPT, Mistral, REST). The same protocol is published
in Notion at **🧠 Memory OS → 📖 Operating Protocol**
(https://app.notion.com/p/378685b37645810f85d3e9150df56372) — that page is the single source of truth.

## The structure (what lives where)

Hub: **🧠 Memory OS**. Always-loaded pages: **Top of Mind**, **Profile**. Stores:
**Preferences** · **Decisions** · **Knowledge** · **Strategy & Goals** · **People** (CRM) ·
**Ventures** · **Projects** · **Agents** · **Daily Log** · **Inbox** · **Tasks** · **Library**.
Backbone ontology (the five context types): **Strategic / Relationship / Knowledge / Process /
Decision**.

## At the start of work — ALWAYS

**Fetch `📌 Top of Mind` and `👤 Profile` first**, every session, without being asked. They carry
current priorities, per-venture status, working preferences, and hard constraints.

## Reading for a task

- **Conversational clients (Claude.ai / ChatGPT / Mistral):** semantic-search the relevant store,
  then fetch promising rows. Phrase queries the way the *statement-titles* read.
- **Programmatic / fleet:** structured query (REST `data_sources/query`) filtered by `Venture` /
  `Type` / `Status` — the deterministic path.
- **Either:** follow relations 1–2 hops (a Venture or Project → its Decisions / Knowledge / Goals /
  Tasks). Prefer **`Status = Active` / `Current`** rows; superseded ones are audit trail, not truth.

| You need… | Store |
|---|---|
| how Sebastian wants you to behave | Preferences (+ Top of Mind / Profile) |
| why something was decided | Decisions (`Status = Active`) |
| a lesson / playbook / how-he-works | Knowledge |
| goals / strategy / priorities | Strategy & Goals |
| a person | People (CRM) |
| a venture / project brief | Ventures / Projects |
| an agent's role | Agents |
| what happened recently | Daily Log |
| open todos | Tasks |
| long-form essays / whitepaper | Library (only when asked) |

## Writing to memory

Write only **durable, reusable** information. **Never** write secrets, credentials, or tokens.

1. **Propose, then confirm** before writing to the clean stores (Decisions / Knowledge / Strategy &
   Goals / Preferences). Don't silently auto-write.
2. **Dedup first** — search the target store; if a near-duplicate exists, update or supersede it
   instead of creating a second row.
3. Write to the **correct store** with a **statement-title** and required properties
   (`Scope` / `Venture` / `Status`).
4. **Supersede, don't delete** — on contradiction, flip the old row's `Status`
   (Superseded / Outdated / Reversed) and link the replacement.

Raw, frictionless capture is the exception: notes and dumps go straight to **📥 Inbox** (or
**Daily Log**), to be distilled later.

### The one rule that makes recall work
**Every title is a full statement, not a label.**
✅ *"Human review is Ongiini's trust layer, not a bottleneck"* ❌ *"Trust"*

### Write template — a Decision
```
Title:  <full statement>      Scope: Global|Venture|Agent      Status: Active
Decision Date: <today>        Venture/Project/People: <relations as relevant>
Body: Decision / Rationale / Alternative considered / Outcome or review date
```

## Ingesting a conversation history or bulk dump

When Sebastian says "mine this / dump everything from here into the memory":

1. **Don't paste everything into one window.** Work in **batches** (a topic, a date range, or a
   chat at a time) so nothing is truncated.
2. **Capture raw first.** For each batch, write atomic raw items into **📥 Inbox**, one row per
   idea, titled as a full statement, with a `Guess Type` (the five context types) and the detail in
   the page body. Speed over polish here.
3. **Distill in a reviewed pass.** Turn each unprocessed Inbox item into a clean row in the right
   store: classify, **dedup** against what's already there, **supersede** contradictions, set
   `Scope`/`Venture`/`Status`. Present the proposed rows to Sebastian for approval before they land
   in the clean stores; then tick `Processed`.
4. **Separate fact from inference.** Only write what's supported. Mark anything inferred
   "_(inferred — confirm)_" in the body rather than asserting it.
5. **Update the always-loaded pages.** If the dump changes current priorities, per-venture status,
   or a stable fact, reflect it in **Top of Mind** / **Profile**.
6. **Never** carry secrets, credentials, or tokens across.

## The five context types (reuse, don't reinvent)
**Strategic** (vision/goals/principles) · **Relationship** (people) · **Knowledge** (lessons,
findings) · **Process** (how he works) · **Decision** (choices + rationale + outcome).
