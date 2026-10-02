---
name: handoff
description: Use ONLY when the user asks for a session handoff. Compact the current conversation into a redacted temporary document for another agent to pick up.
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Save to the temporary directory of the user's OS - not the current workspace.

Include a "suggested skills" section in the document, naming which skills the next agent should load via OpenCode's `skill` tool.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information.

If the user describes what the next session will focus on, tailor the doc accordingly.
