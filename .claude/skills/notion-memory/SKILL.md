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

## Quick reference — live IDs, schema, worked example

Open these by URL; don't rely on search alone. On every write to a clean store, set **`Added by`**
to your platform (`Claude` / `Mistral` / `ChatGPT` / `Agent`). **If you can only read (no write
access), append the item to Inbox or tell Sebastian — never silently drop it.**

**Always-load pages:** Top of Mind `…81eda8ffece71d4cb781` · Profile `…815e9d6affa1ce7035ca` ·
Operating Protocol `…810f85d3e9150df56372` (prefix all with `https://app.notion.com/p/378685b376458`).

**Stores (full URLs):**
Decisions `https://app.notion.com/p/b568bd8c70534bfebc59f2b68352f0aa` · Knowledge
`https://app.notion.com/p/9a014ff12e9c4a93ad1d5c9792c0baf7` · Strategy & Goals
`https://app.notion.com/p/6f68dd722c074894bee05a92bbc18326` · Preferences
`https://app.notion.com/p/d835dbdabaed4b5181669747462d6b43` · Inbox
`https://app.notion.com/p/f8a50198abe04bb1bd93bb577bbd3602` · Tasks
`https://app.notion.com/p/0dc2c16eb87b40f88f5a4d4536a6aa0c` · Ventures
`https://app.notion.com/p/8feb6e4ef033431290d00d1751302816` · Agents
`https://app.notion.com/p/828042582f574567b08dd107f4085b75` · Projects
`https://app.notion.com/p/da4411a0f7aa422c95440cb96e25e7ba` · People
`https://app.notion.com/p/191604fb680a4c98b4fe1f82c94414cf` · Library
`https://app.notion.com/p/d56a780f0a5b47a39be49f70a39125a9` · Daily Log
`https://app.notion.com/p/0b5c8a5e01474995866ae483e2a21d20`.

**Property cheat-sheet (exact names — `(rel)` = relation, body = page content):**
- **Decisions:** `Decision`(title) · `Scope`[Global|Venture|Agent] · `Status`[Active|Superseded|Reversed] · `Decision Date` · `Venture`(rel) · `Project`(rel) · `People`(rel) · `Supersedes`(rel) · `Added by`. Body: Decision / Rationale / Alternative / Outcome.
- **Knowledge:** `Insight`(title) · `Type`[Knowledge|Process] · `Scope` · `Status`[Current|Outdated] · `Venture`(rel) · `Project`(rel) · `Source` · `Captured` · `Added by`.
- **Strategy & Goals:** `Objective`(title) · `Horizon`[Now|Quarter|Year|Long-term] · `Status`[Active|Achieved|Dropped] · `Venture`(rel) · `Metric` · `Review Date` · `Added by`.
- **Preferences:** `Preference`(title) · `Area`[Communication|Formatting|Tooling|Working Style|Boundaries|Values] · `Scope` · `Status`[Active|Retired] · `Added by`.
- **Inbox:** `Note`(title) · `Captured` · `Processed`(checkbox) · `Guess Type`[Strategic|Relationship|Knowledge|Process|Decision].
- **Tasks:** `Task`(title) · `Status`[Todo|Doing|Done|Dropped] · `Due` · `Priority`[High|Medium|Low] · `Project`(rel) · `Venture`(rel).

**Setting a `Venture` (relation):** pass the venture's page URL. Ongiini
`…04ba07e548f9843b1c` · Sokosumi `…91a11ec8e35c2aad6f` · Masumi `…abba3beef4e27801db` · CIF
`…b8bc58f9f08e090f8a` · Plan.Net `…2d92c2cbdc183e6ea8` · Personal Brand `…90a97bd50988080cb3` ·
Personal `…53b4f5d4497ab74dc8` (prefix all with `https://app.notion.com/p/378685b376458`).

**Worked example — capture a decision.** Create a row in Decisions with `Decision` = the full
statement, `Scope` = Venture, `Venture` = the Ongiini URL, `Status` = Active, `Decision Date` =
today, `Added by` = your platform; put Decision / Rationale / Alternative / Outcome in the body.
*Before creating, search Decisions for a near-duplicate; if found, update or supersede instead.*
