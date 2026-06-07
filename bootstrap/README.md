# Bootstrap pointers

Tiny per-platform adapters. The **full protocol lives in Notion** (single source of truth):
**🧠 Memory OS → 📖 Operating Protocol** — https://app.notion.com/p/378685b37645810f85d3e9150df56372

Each file below is the small thing you paste into a given client so it knows to follow that protocol
page. Keep the protocol itself in Notion, not in these files, so all clients stay in sync.

| Client | How it loads | File |
|---|---|---|
| Claude Code / Cowork | the `notion-memory` skill auto-loads | `.claude/skills/notion-memory/SKILL.md` |
| Claude.ai | Project custom instructions | [`claude.md`](./claude.md) |
| ChatGPT | Project / custom GPT instructions | [`chatgpt.md`](./chatgpt.md) |
| Mistral Le Chat | Agent instructions (connector per chat) | [`mistral.md`](./mistral.md) |

**Prerequisite for all of them:** the Notion connector/MCP must be enabled for that client, or it
can't read or write the workspace.
