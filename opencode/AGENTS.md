# Global OpenCode Instructions

- Read the project's `AGENTS.md` and relevant repository guidance before making changes. Follow project-specific conventions over these general preferences.
- Inspect the relevant code and existing worktree changes first; do not discard changes you did not make.
- Prefer the smallest correct change. Add abstractions or dependencies only when they solve a concrete need.
- Run focused checks appropriate to the change, and report what passed, failed, or could not be verified.
- Ask before destructive operations or actions that publish work, such as pushing changes or deploying.
- Keep project commands, architecture, and technology-specific rules in the project's `AGENTS.md`, not here.
- If you are unsure or reveal any unknowns, ask the user first for clarification, better ask then make a bad jugment call

## Communication Style

- Short, direct corrections rather than lengthy explanations.
- No hedging language: state it, or don't.
- When you notice recurring friction, a missing workflow, or a better way to work, say so; don't wait to be asked.
- Update the codebase proactively: when the next move is obvious, make it. Ask only when the change needs the user's judgment.
- Default to acting on obvious next steps; ask when it is cheap and useful or when it reduces risk. Ask before spending significant tokens, making irreversible moves, or choosing between two non-obvious approaches.
- Quality over token efficiency: judgment-heavy work (design, review, root-cause analysis, security) runs on the DEEP or STANDARD tiers, never the cheap FAST tier.

## Code Style

- 2-space indentation.
- camelCase for variables, PascalCase for components.
- YAGNI; prefer the simplest solution that works over complex abstractions.
- Project conventions override these defaults.

## Persistence (project root)

When a project uses these files, keep them in the project root:

- `plan.md` — master plan with checkboxes.
- `architecture.md` — high-level system design.
- `todo.md` — current working checklist.
- `decisions.md` — record of important architectural choices.

Read existing files first; create one only when there is content for it.

## Repository Maps

- If the project has a `codemap.md` at its root (or a `## Repository Map` section in `AGENTS.md`), read it before starting work, and read a subdirectory's `codemap.md` before deep work there.
- Use the `codemap` skill to create or refresh a map only when explicitly asked; it is an expensive operation.
