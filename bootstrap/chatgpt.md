# ChatGPT bootstrap

**Setup (once):**
1. Add the Notion connector: Settings → **Connectors** → add the Notion MCP
   (`https://mcp.notion.com/mcp`) and authorize Sebastian's workspace.
2. Put the pointer below into a **Project's instructions** (or a custom GPT).

**Pointer (paste verbatim):**

> You operate against a Notion-based long-term memory system ("Memory OS"). Notion is the canonical
> memory — do not rely on this platform's native memory; when they disagree, Notion wins. At the
> start of work, fetch and follow the protocol page:
> https://app.notion.com/p/378685b37645810f85d3e9150df56372 — and always load "📌 Top of Mind" and
> "👤 Profile" first. Write durable info only; never store secrets. Propose writes to the clean
> stores before saving.

**Note:** ChatGPT connectors sometimes expose only search/fetch in certain modes — if it can't
write, do retrieval here and perform writes from Claude or the fleet.
