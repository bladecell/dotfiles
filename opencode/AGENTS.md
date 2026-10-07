# Global OpenCode Instructions

- Read the project's `AGENTS.md` and relevant repository guidance before making changes. Follow project-specific conventions over these general preferences.
- Inspect the relevant code and existing worktree changes first; do not discard changes you did not make.
- Prefer the smallest correct change. Add abstractions or dependencies only when they solve a concrete need.
- Run focused checks appropriate to the change, and report what passed, failed, or could not be verified.
- Ask before destructive operations or actions that publish work, such as pushing changes or deploying.
- Keep project commands, architecture, and technology-specific rules in the project's `AGENTS.md`, not here.
- If ambiguity materially affects scope, risk, user-visible behavior, or an irreversible decision, ask; otherwise proceed with the safest reasonable interpretation.

## Communication Style

- Short, direct corrections rather than lengthy explanations.
- No hedging language: state it, or don't.
- When you notice recurring friction, a missing workflow, or a better way to work, say so; don't wait to be asked.
- Update the codebase proactively: when the next move is obvious, make it. Ask only when the change needs the user's judgment.
- Default to acting on obvious next steps; ask when it is cheap and useful or when it reduces risk. Ask before spending significant tokens, making irreversible moves, or choosing between two non-obvious approaches.

## Model Economy

Use the lowest-cost model adequate for the task.

- FAST tier: discovery, research, triage, routine validation, bounded mechanical work
- STANDARD tier: implementation, debugging, domain reasoning
- DEEP tier: high-risk architecture/security decisions

Agent-to-model assignments live in `agents/*.md`; escalate only when evidence shows the current tier is insufficient. Do not sacrifice correctness merely to save tokens.

## Code Style

- 2-space indentation.
- camelCase for variables, PascalCase for components.
- YAGNI; prefer the simplest solution that works over complex abstractions.
- Project conventions override these defaults.

## Persistence (project-specific)

Per-project conventions, not a global requirement. Use only when a project opts in (via its own `AGENTS.md`) or the work is substantial enough to provide persistent value; do not create these for every repository or task. When used, they live in the project root: `plan.md` (master plan with checkboxes), `architecture.md` (high-level design), `todo.md` (working checklist), `decisions.md` (important architectural choices).

## Repository Maps

- If the project has a `codemap.md` at its root (or a `## Repository Map` section in `AGENTS.md`), read it before starting work, and read a subdirectory's `codemap.md` before deep work there.
- Use the `codemap` skill to create or refresh a map only when explicitly asked; it is an expensive operation.
