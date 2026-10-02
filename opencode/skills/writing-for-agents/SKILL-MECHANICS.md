# Skill mechanics

The skill-specific branch of [`writing-for-agents`](SKILL.md): what changes when the document is a skill (frontmatter, the invocation choice, and router skills). Everything else about writing it is the universal reference in `SKILL.md`.

## Invocation

OpenCode discovers every installed skill with a valid `name` and `description` in its `SKILL.md` frontmatter. The description is shown to the agent; the body loads on demand through the `skill` tool. `disable-model-invocation` and `argument-hint` from Claude Code are ignored by OpenCode.

For skills that should run only on explicit user request, start the description with "Use ONLY when the user asks ..." and repeat that gate in the body when needed. This is guidance, not a strict enforcement mechanism. If stronger gating is needed, use OpenCode's skill permissions (`ask`/`deny`) or a separate user-invoked command; document the intended invocation there.

Write a short description stating what the skill does and when it applies. Keep the skill in `~/.config/opencode/skills/<name>/SKILL.md` globally, or `.opencode/skills/<name>/SKILL.md` for a project. Add a reference file next to `SKILL.md` only when a subset of uses needs it.

## Splitting by invocation

The invocation cut of splitting (the sequence cut lives in `SKILL.md`): split off a separate skill when it has a distinct trigger or another skill needs to load it. Every installed skill adds a description to the available-skills list, so keep that description short and specific.

## Router skills

When skills multiply past what you can remember, a **router skill** can name the others and when to load each. In OpenCode it may load another skill through the `skill` tool; avoid a router unless navigation is actually a problem.
