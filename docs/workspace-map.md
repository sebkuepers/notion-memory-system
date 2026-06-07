# Live workspace map

A snapshot of Sebastian's existing Notion workspace, fetched live during the design phase
(2026-06-07), so the schema reuses what's really there and we know what to leave alone.

## Databases that exist today

| Database | `data_source_id` (collection) | Role in Memory OS |
|---|---|---|
| `Projects` | `bfd7a1a5-a4f3-4a15-b5d8-42261ff89336` | **Reuse + extend** → the Projects store (add `Venture` relation) |
| `CRM - Contacts` | `3a0b4200-0c34-491d-86dc-86de07c4916c` | **Reuse** → the People (Relationship) store |
| `CRM - Organizations` | `0e98f520-be59-4c01-a493-4e0cf731d91f` | Leave as-is (CRM project) |
| `CRM - Interactions` | `d51513cd-0fbf-43c9-8f8e-03d65603a120` | Leave as-is (CRM project) |
| `CRM - Projects` | `14694c52-a236-4b75-b084-ebd4b8b652ba` | Leave as-is (duplicate of `Projects`) |
| `Contacts` | `e41e0626-5c99-4ebf-864a-61b53c1301b5` | Duplicate of `CRM - Contacts` — defer cleanup |
| `Test Database` | `9dcdb14a-100a-4be3-b1bd-e67726b98422` | Junk — defer cleanup |

> Database container IDs (for reference): `Projects` = `da4411a0-f7aa-422c-9544-0cb96e25e7ba`;
> `CRM - Contacts` = `191604fb-680a-4c98-b4fe-1f82c94414cf`; `Contacts` =
> `8781beec-1ce1-401c-af03-f9b1bf168467`; `CRM - Projects` = `69183b9e-a77c-403b-8502-c41858498a66`.
> Remember: address rows by **data-source** ID, not container ID.

### `Projects` schema (the one we extend)
`Name`(title) · `Status`(select: Active/Completed/On Hold/Cancelled/Planned) · `Priority`(select:
High/Medium/Low) · `Description`(text) · `Start Date`/`End Date`(date) · `Budget`(number) ·
`Organization Name`(text) · `Tags`(multi-select: Ongiini/Foundation/Client Work/Internal/Open Source).
→ We **add** a `Venture` relation to the new Ventures DB. Note the existing `Tags` are *project
types*, distinct from the `Venture` dimension.

### `CRM - Contacts` schema (the People store)
Already rich: `Name`(title) · `Email`/`Phone`/`LinkedIn`/`Twitter` · `Organization` +
`All Organizations`(relations → CRM-Organizations) · `Primary Role`(select) · `Relationship Status`
/ `Relationship Type`(selects) · `Tags`/`Auto-Tags`(multi-select) · `AI Summary`(text) ·
`Last Contact`/`Next Follow-up`/`Created`(dates) · `Notes`(text). Dummy data today.

## Key pages

- **`Slow Intelligence OS`** (`378685b3-7645-81e2-a6a0-ddffd3a13727`) — the newer hub; parent of the
  ontology page below. Likely the canonical brand/OS hub.
- **`Context & Sparring: Your AI's Brain`** (`378685b3-7645-8172-a9d5-d42e9bccfe44`) — **the source
  of the five-context-type ontology**, reused verbatim: Strategic / Relationship / Knowledge /
  Process / Decision.
- **`Sebastian Küpers Brand Strategy`** (`376685b3-7645-81e6-bb74-c9682016fdc9`) + its TOC
  (`376685b3-7645-815c-...`) — the **older** brand hub; overlaps with `Slow Intelligence OS`.

## Duplication (noted, deliberately deferred)

The workspace was seeded by more than one AI session (a Claude pilot and a Mistral "Vibe + Studio"
pilot), leaving parallels:
- two project DBs (`Projects` vs `CRM - Projects`),
- two contact DBs (`Contacts` vs `CRM - Contacts`),
- two brand hubs (`Slow Intelligence OS` vs `Sebastian Küpers Brand Strategy`),
- a stray `Test Database`.

**Decision:** the `CRM - *` family is throwaway scaffolding for a separate email-automation project
(dummy data). We do **not** clean any of this up in the design/build of Memory OS. Recorded here so a
future consolidation pass (pick one canonical brand hub; merge/retire duplicate DBs) is easy to start.

## Reuse decisions (summary)

| Need | Action |
|---|---|
| Projects store | extend existing `Projects` (`bfd7a1a5…`) with a `Venture` relation |
| People (Relationship) store | reuse existing `CRM - Contacts` (`3a0b4200…`) |
| Ontology (the five types) | reuse verbatim from `Context & Sparring` |
| Ventures / Decisions / Knowledge / Strategy & Goals / Agents / Daily Log / Inbox / Tasks / Library / Preferences | **create new** (see `schema/`) |
| Everything CRM-* / duplicates / Test DB | leave alone (deferred cleanup) |
