# Claude.ai bootstrap

**Setup (once):**
1. In the Claude.ai Project, connect Notion: Settings → Connectors → enable **Notion** (the hosted
   MCP). Authorize Sebastian's workspace.
2. Paste the pointer below into the Project's **custom instructions**.

**Pointer (paste verbatim):**

> You operate against a Notion-based long-term memory system ("Memory OS"). Notion is the canonical
> memory — do not rely on this platform's native memory; when they disagree, Notion wins. At the
> start of work, fetch and follow the protocol page:
> https://app.notion.com/p/378685b37645810f85d3e9150df56372 — and always load "📌 Top of Mind" and
> "👤 Profile" first. Write durable info only; never store secrets. Propose writes to the clean
> stores before saving.

**To mine this chat into memory:** say *"follow the Memory OS protocol and ingest this conversation."*
Claude will batch it through 📥 Inbox, then distill into the right stores for your approval.
