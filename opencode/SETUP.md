# OpenCode Global Setup

Snapshot of a global (user-level) OpenCode configuration, recorded so it can be
recreated on another machine or ported to Claude Code.

- Host: Linux, user `jpojsl`
- OpenCode: **v2.0.21**
- Config root: `~/.config/opencode/`

## 1. File layout

```
~/.config/opencode/
├── opencode.jsonc              # global config (LSP, plugins, MCP)
├── AGENTS.md                   # global rules (loaded every session)
├── agents/                     # 16 custom subagents/primary agents
│   └── <name>.md
└── skills/                     # 28 skills
    ├── <name>/SKILL.md
    └── THIRD_PARTY_NOTICES.md  # MIT attributions for imported skills
```

OpenCode loads global config from `~/.config/opencode/` (not `~/.opencode/`).
Changes are read at startup; restart OpenCode to apply.

## 2. opencode.jsonc

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": true,
  "plugins": [],
  "mcp": {
    "servers": {
      "context7": {
        "type": "remote",
        "url": "https://mcp.context7.com/mcp"
      },
      "gh_grep": {
        "type": "remote",
        "url": "https://mcp.grep.app"
      },
      "playwright": {
        "type": "local",
        "command": ["npx", "-y", "@playwright/mcp"]
      }
    }
  }
}
```

V2 notes: MCP servers live under `mcp.servers`; disable with `"disabled": true`.
The plugin key is `plugins` (plural) — an empty list here means no plugins.

## 3. Global rules (AGENTS.md)

```markdown
# Global OpenCode Instructions

- Read the project's `AGENTS.md` and relevant repository guidance before making changes. Follow project-specific conventions over these general preferences.
- Inspect the relevant code and existing worktree changes first; do not discard changes you did not make.
- Prefer the smallest correct change. Add abstractions or dependencies only when they solve a concrete need.
- Run focused checks appropriate to the change, and report what passed, failed, or could not be verified.
- Ask before destructive operations or actions that publish work, such as pushing changes or deploying.
- Keep project commands, architecture, and technology-specific rules in the project's `AGENTS.md`, not here.
- If you are unsure or reveal any unknowns, ask the user first for clarification, better ask then make a bad jugment call
```

## 4. Skills (28)

Each skill is a folder with a `SKILL.md`. Frontmatter uses `name` +
`description`; OpenCode ignores Claude-only keys such as
`disable-model-invocation` and `argument-hint`.

### 4a. Pre-existing / locally adapted (5)

Adapted from the `oh-my-opencode-slim` plugin bundle, except `logo-design`
(installed separately). No upstream pin recorded.

| Skill | Notes |
|---|---|
| `codemap` | Hierarchical repo codemaps; `.slim/codemap.json` state |
| `clonedeps` | Clone dependency sources under `.slim/clonedeps/` |
| `simplify` | Behavior-preserving simplification |
| `verification-planning` | Evidence-path planning for non-trivial changes |
| `logo-design` | Logo/brand-mark design (large library + Python scripts) |

### 4b. Matt Pocock — `mattpocock/skills` (15)

- Source: https://github.com/mattpocock/skills
- Revision: `d81f3a183412e71a5b1e84ca21bc1a35eea03a60`
- License: MIT (see `skills/THIRD_PARTY_NOTICES.md`)

| Skill | Upstream path |
|---|---|
| `improve-codebase-architecture` | `skills/engineering/improve-codebase-architecture` |
| `to-spec` | `skills/engineering/to-spec` |
| `implement` | `skills/engineering/implement` |
| `prototype` | `skills/engineering/prototype` |
| `diagnosing-bugs` | `skills/engineering/diagnosing-bugs` |
| `research` | `skills/engineering/research` |
| `tdd` | `skills/engineering/tdd` |
| `codebase-design` | `skills/engineering/codebase-design` |
| `code-review` | `skills/engineering/code-review` |
| `wizard` | `skills/engineering/wizard` |
| `domain-modeling` | `skills/engineering/domain-modeling` |
| `setup-matt-pocock-skills` | `skills/engineering/setup-matt-pocock-skills` |
| `grilling` | `skills/productivity/grilling` |
| `writing-for-agents` | `skills/productivity/writing-for-agents` |
| `handoff` | `skills/productivity/handoff` |

### 4c. Jeff Allan — `Jeffallan/claude-skills` (8)

- Source: https://github.com/Jeffallan/claude-skills
- Revision: `882ef55e377dbf9a4dbe496bb41ac6ccd0e555cf`
- License: MIT (see `skills/THIRD_PARTY_NOTICES.md`)

`api-designer`, `cli-developer`, `python-pro`, `javascript-pro`,
`typescript-pro`, `rust-engineer`, `secure-code-guardian`,
`embedded-systems` — each copied with its `references/` folder.

## 5. Agents (16)

All live in `~/.config/opencode/agents/<name>.md`. `mode` is `primary` or
`subagent`; `model` is an OpenCode Go model ID.

| Agent | Mode | Model |
|---|---|---|
| `agent-organizer` | primary | `opencode-go/glm-5.3` |
| `codebase-orchestrator` | primary | `opencode-go/glm-5.3` |
| `api-designer` | subagent | `opencode-go/qwen3.8-max` |
| `ui-designer` | subagent | `opencode-go/qwen3.8-max` |
| `architect-reviewer` | subagent | `opencode-go/kimi-k3` |
| `debugger` | subagent | `opencode-go/kimi-k3` |
| `performance-engineer` | subagent | `opencode-go/glm-5.3` |
| `typescript-pro` | subagent | `opencode-go/glm-5.3-flash` |
| `docker-expert` | subagent | `opencode-go/glm-5.3-flash` |
| `ui-ux-tester` | subagent | `opencode-go/glm-5.3-flash` |
| `python-pro` | subagent | `opencode-go/mimo-v2.6-flash` |
| `websocket-engineer` | subagent | `opencode-go/mimo-v2.6-flash` |
| `iot-engineer` | subagent | `opencode-go/mimo-v2.6-flash` |
| `api-documenter` | subagent | `opencode-go/mimo-v2.6-flash` |
| `rust-engineer` | subagent | `opencode-go/deepseek-v4.1-flash` |
| `embedded-systems` | subagent | `opencode-go/deepseek-v4.1-flash` |

**Source:** VoltAgent `awesome-claude-code-subagents`
(https://github.com/VoltAgent/awesome-claude-code-subagents), `main` observed at
`82b73821baa7a911d5b14cfb6da238b7f0db6b42`. Upstream paths are
`categories/<category>/<name>.md`:

| Agent | Upstream category |
|---|---|
| `api-designer`, `ui-designer`, `websocket-engineer` | `01-core-development` |
| `typescript-pro`, `python-pro`, `rust-engineer` | `02-language-specialists` |
| `docker-expert` | `03-infrastructure` |
| `architect-reviewer`, `debugger`, `ui-ux-tester`, `performance-engineer` | `04-quality-security` |
| `api-documenter`, `embedded-systems`, `iot-engineer` | `07-specialized-domains` |
| `agent-organizer`, `codebase-orchestrator` | `09-meta-orchestration` |

Original upstream frontmatter used `tools: <comma list>` and `model: inherit|sonnet|haiku`.

## 6. MCP servers

Added globally with the CLI, e.g. `opencode mcp add <name> --global ...`.

| Server | Type | Endpoint | Auth |
|---|---|---|---|
| `context7` | remote | `https://mcp.context7.com/mcp` | none (optional API key) |
| `gh_grep` | remote | `https://mcp.grep.app` | none |
| `playwright` | local | `npx -y @playwright/mcp` | none |

Sources: Context7 (https://github.com/upstash/context7), Grep by Vercel
(https://grep.app), Playwright MCP (https://github.com/microsoft/playwright-mcp).
Playwright also needs a browser: `npx playwright install chromium`.

## 7. Models and escalation

Provider: **OpenCode Go** (OpenCode Console, plan "Personal"). Model IDs use the
`opencode-go/<model-id>` form.

- **Frontier / judgment tier:** `glm-5.3`, `qwen3.8-max`, `kimi-k3`.
- **Implementation / efficient tier:** `mimo-v2.6-flash`, `glm-5.3-flash`,
  `deepseek-v4.1-flash` (spread across models to balance monthly Go quotas).

There is **no automatic model-escalation plugin**. Escalation is static routing
(judgment agents on frontier models) plus delegation: a flash-tier agent can
hand a hard problem to a frontier-tier subagent.

## 8. Adaptations applied (vs upstream sources)

When porting back to Claude Code, reverse these where relevant:

1. **Frontmatter:** VoltAgent `tools:` → OpenCode `permission` with a
   `"*": deny` baseline plus explicit allows. `model:` aliases
   (`inherit`/`sonnet`/`haiku`) → `opencode-go/*` IDs. Added `mode:`.
2. **Invocation:** Claude-only `disable-model-invocation` / `argument-hint`
   removed; manual-only workflows gated with "Use ONLY when..." descriptions.
3. **Reference scrubbing:** `Claude Code`→`OpenCode`,
   `Query context manager for`→`Inspect`, `Task tool`→`task tool`,
   `~/.claude/agents`→`~/.config/opencode/agents`,
   `.claude/agents`→`.opencode/agents`, `CLAUDE.md`→`AGENTS.md`.
4. **Safety:** removed auto-commit/auto-publish steps (`implement`, `prototype`,
   `wizard`); commit/branch/publish now require approval.
5. **Removed MCP coupling:** `chrome-mcp`, `computer-use`,
   `airis-mcp-gateway`, `pied-piper`, `subagent-catalog` references dropped or
   made optional.
6. **Security fixes:** corrected unsafe examples in Jeff Allan's
   `secure-code-guardian` (JWT algorithm/issuer/audience, path-boundary check,
   CSRF) and `embedded-systems` (ISR queue instead of single-byte flag).

## 9. Recreating on Claude Code

| OpenCode | Claude Code |
|---|---|
| `~/.config/opencode/AGENTS.md` | `~/.claude/CLAUDE.md` |
| `~/.config/opencode/skills/<n>/SKILL.md` | `~/.claude/skills/<n>/SKILL.md` |
| `~/.config/opencode/agents/<n>.md` | `~/.claude/agents/<n>.md` |
| `opencode mcp add ...` | `claude mcp add ...` |
| `plugins` / marketplace | Claude Code plugin marketplace |

**Skills:** copy the `SKILL.md` folders into `~/.claude/skills/`. Upstream
Matt Pocock / Jeff Allan skills already target Claude Code, so their original
frontmatter (including `disable-model-invocation`) can be restored from the
pinned revisions instead of the OpenCode-adapted copies.

**Agents:** recreate each as a Claude subagent with frontmatter
`name`, `description`, `model`, `tools`. Suggested mapping: frontier tier →
`opus`, implementation tier → `sonnet`, `api-documenter` → `haiku`. Build a
`tools` allowlist from the OpenCode permissions (the upstream VoltAgent `tools:`
list is the ground truth). `mode: primary` has no Claude equivalent — Claude
Code agents are all subagents.

Original upstream `tools:` per agent: most are
`Read, Write, Edit, Bash, Glob, Grep`; `api-documenter` is
`Read, Write, Edit, Glob, Grep, WebFetch, WebSearch`; `agent-organizer` is
`Read, Write, Edit, Glob, Grep`; `ui-ux-tester` additionally had
`WebSearch, chrome-mcp, computer-use`; `codebase-orchestrator` additionally had
`WebFetch` and VoltAgent-internal MCP tools (dropped).

**MCP (verify current Claude Code syntax):**

```sh
claude mcp add --transport http context7 https://mcp.context7.com/mcp
claude mcp add --transport http gh_grep  https://mcp.grep.app
claude mcp add playwright -- npx -y @playwright/mcp
```

## 10. Sources

- OpenCode docs: https://opencode.ai/docs/ (V2: https://opencode.ai/v2/docs/)
- OpenCode config schema: https://opencode.ai/config.json
- Matt Pocock skills: https://github.com/mattpocock/skills @ `d81f3a18`
- Jeff Allan skills: https://github.com/Jeffallan/claude-skills @ `882ef55e`
- VoltAgent subagents: https://github.com/VoltAgent/awesome-claude-code-subagents @ `82b73821`
- Context7: https://github.com/upstash/context7
- Grep by Vercel: https://grep.app
- Playwright MCP: https://github.com/microsoft/playwright-mcp
- Licenses: `~/.config/opencode/skills/THIRD_PARTY_NOTICES.md`

_Generated as a point-in-time snapshot of the local setup. Pinned revisions are
not auto-updated._
