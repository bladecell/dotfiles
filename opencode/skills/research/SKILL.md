---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

Use a **background `general` agent** for independent research when available; otherwise research directly. Do not spawn an agent if its task duplicates work already in progress.

Its job:

1. Investigate the question against **primary sources** (official docs, source code, specs, first-party APIs), not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Report findings with citations. If the user wants a persistent research note, write the findings to a single Markdown file and confirm the target location.
3. When saving a note, follow the repo's existing convention; if there is none, propose a sensible location before writing.
