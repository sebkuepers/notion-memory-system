# UI finishing checklist (~10 min, one-time)

The Notion API builds *data and structure*, not *visual layout*. These steps can **only** be done in
the Notion app — they're mechanical, not design work. Everything else (the page-tree, covers, icons,
views, embedded views, narrative) is already built programmatically.

Open **Home** (under 🧠 Memory OS) and work down.

## 1. Make Home the entry
- ⭐ **Favorite** the **Home** page (sidebar → ⋯ → Add to Favorites) so it's one click away.

## 2. Columns (the magazine layout) — the big one
The API can't create columns, so the embedded views currently stack vertically. To fix:
- On **Home**: drag the **Inbox · to distill** view so it sits *beside* **Active decisions**
  (drag the block handle to the right edge of the other until a blue vertical guide appears). Aim for
  a 2-column "Active decisions | Inbox" row, with **Tasks** full-width below.
- Repeat on **Knowledge & Decisions** (Decisions | Knowledge side by side, Strategy below) and
  **Capture & Do** (Inbox | Tasks, Daily-log calendar below).

## 3. Toggles for deep-dives
- Wrap any long/secondary section in a toggle (type `>` then space, or `/toggle`) so the page scans
  fast and expands on demand.

## 4. Default views
For each database (in **⚙️ Engine room**), set the human-friendly view as **default** and drag it to
first: Ventures → **Gallery**, Tasks → **Today** (or Board), Weekly Goals → **This week**, Library →
**Gallery**, Inbox → **Unprocessed**, Daily Log → **Calendar**, Decisions → **Active/List**.
(View tab → ⋯ → *Set as default* / drag tab.)

## 5. Gallery card covers (optional, looks great)
- On the **Ventures** gallery: ⋯ → *Layout* → **Card preview: Page cover** → card size *Medium*.
  The venture covers I set will then show as card images.

## 6. Teamspace ("use workspaces")
- Create a teamspace: sidebar → **+** next to Teamspaces → name it **Memory OS**.
- Then tell Claude — it will **move the whole tree into it** (the API can move pages into an existing
  teamspace, it just can't create one). Result: Memory OS becomes a first-class sidebar section.

## 7. Tidy
- On the **🧠 Memory OS** container page, drag the **Engine room** link to the bottom.
- Swap any cover image (currently Notion gradients) for a personal one if you like.

## 8. Weekly Goals — turn on the Monday repeat (optional)
The API can't create a repeating template, so to auto-create each week's goal scaffold every Monday:
- Open **Weekly Goals** → dropdown next to **New** → **+ New template** → design a goal row (e.g.
  set Status = Open, leave Goal/Week Of blank) → **⋯ → Repeat → Weekly**, start on a **Monday**.
- Each Monday Notion drops a fresh goal entry in; you fill in that week's goals. (Free plan supports
  this.) Same trick works for a daily Tasks template if you want.

## Daily / weekly rhythm (how to use it)
- **Monday:** open **Weekly Goals → This week**, add this week's goals.
- **Each morning:** in **Tasks**, set **Do Date = today** on what you'll tackle and tick **Top 3**
  on your three must-dos. **Home** shows *⭐ Top 3 today* and *🎯 This week's goals* at a glance.

That's it — after this pass it reads like a designed workspace, and nothing about the AI/data layer
changed.
