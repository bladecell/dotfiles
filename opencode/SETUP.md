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
  "agents": {
    "explore": {
      "model": "opencode-go/mimo-v2.6-flash",
      "permissions": [
        { "action": "skill", "resource": "*", "effect": "allow" }
      ]
    },
    "general": { "model": "opencode-go/minimax-m3" }
  },
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

The `agents` overrides pin the built-in subagents to tiers. Without them,
`explore` and `general` have no model and inherit the parent session's model
(e.g. the orchestrator's DEEP model). `explore` is pinned FAST
(`mimo-v2.6-flash`); `general` is pinned STANDARD (`minimax-m3`) because it does
multi-step implementation work.

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

## 4. Skills (31)

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

### 4d. Svelte (3)

- `sveltejs/ai-tools` @ `a5a92c680ebe0d432593f4228a122cb59f5a0c74` (MIT):
  - `svelte-core-bestpractices` — copied with its `references/` folder
  - `svelte-code-writer` — uses `npx @sveltejs/mcp` (`list-sections`, `get-documentation`, `svelte-autofixer`)
- `sveltejs/svelte` @ `020242d6bef059df9ae8c13dc8dbff4c9b31e0ff` (MIT):
  - `performance-investigation` — Svelte repo benchmark / CPU-profile workflow

## 5. Agents (21)

All live in `~/.config/opencode/agents/<name>.md`. `mode` is `primary` or
`subagent`; `model` is an OpenCode Go model ID. System prompts for the specialists are deliberately
condensed: role + when-to-use + domain rules + a short process + an output
contract, with no fabricated metrics, pseudo message-bus JSON, or stale
cross-agent references. `codebase-orchestrator` is excluded and keeps its full
protocol (work lanes, open decisions, approval gates).

Taxonomy:

- **Orchestration:** `codebase-orchestrator`, `agent-organizer`
- **Investigation:** `explore` (built-in), `researcher`, `debugger`
- **Implementation:** `typescript-pro`, `python-pro`, `rust-engineer`, `database-engineer`, `websocket-engineer`, `docker-expert`, `iot-engineer`, `embedded-systems`, `ui-designer`
- **Design:** `api-designer`
- **Validation / Review:** `test-engineer`, `security-reviewer`, `code-reviewer`, `architect-reviewer`, `performance-engineer`, `ui-ux-tester`
- **Documentation:** `api-documenter`

| Agent | Mode | Tier | Model |
|---|---|---|---|
| `codebase-orchestrator` | primary | DEEP | `opencode-go/glm-5.3` |
| `architect-reviewer` | subagent | DEEP | `opencode-go/qwen3.8-max` |
| `security-reviewer` | subagent | DEEP | `opencode-go/kimi-k3` |
| `debugger` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `typescript-pro` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `python-pro` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `rust-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `database-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `websocket-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `performance-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `embedded-systems` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `iot-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `api-designer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `code-reviewer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `test-engineer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `docker-expert` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `ui-designer` | subagent | STANDARD | `opencode-go/minimax-m3` |
| `agent-organizer` | subagent | FAST | `opencode-go/mimo-v2.6-flash` |
| `api-documenter` | subagent | FAST | `opencode-go/mimo-v2.6-flash` |
| `ui-ux-tester` | subagent | FAST | `opencode-go/mimo-v2.6-flash` |
| `researcher` | subagent | FAST | `opencode-go/mimo-v2.6-flash` |

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
| `researcher` | `10-research-analysis` |

Four agents are renamed from their upstream file:

| New agent | Upstream file |
|---|---|
| `database-engineer` | `02-language-specialists/sql-pro.md` |
| `test-engineer` | `04-quality-security/test-automator.md` |
| `security-reviewer` | `04-quality-security/security-auditor.md` |
| `code-reviewer` | `04-quality-security/code-reviewer.md` |
| `researcher` | `10-research-analysis/research-analyst.md` |

### 5a. Delegation (`codebase-orchestrator`)

`codebase-orchestrator` is a **primary** agent that drives a phased flow:
classify → work graph → investigate → consolidate → approval → implement →
reconcile → validate → review → complete.

It includes a **Fast Path** (skip the graph/approval/review for LOW-risk,
obvious, single-file changes), a **Work Graph** of lanes (objective,
dependencies, mode, specialist, write ownership, validation owner), two
**Delegation Modes** (INVESTIGATION-ONLY vs IMPLEMENTATION-AUTHORIZED, the
latter requiring `verification-planning` and `tdd`), a **Preserve Open
Decisions** rule, **session reuse** for related follow-ups, and a
**Completion Standard** requiring red-before-green evidence per lane.

Delegation is gated by v2 `permissions` rules with `action: subagent`:
a blanket `resource: "*"` deny followed by explicit `allow` entries for the
specialists above (`explore`, `researcher`, `debugger`, `agent-organizer`, `api-designer`,
`api-documenter`, `architect-reviewer`, `code-reviewer`, `database-engineer`,
`docker-expert`, `embedded-systems`, `iot-engineer`, `performance-engineer`,
`python-pro`, `rust-engineer`, `security-reviewer`, `test-engineer`,
`typescript-pro`, `ui-designer`, `ui-ux-tester`, `websocket-engineer`).
Independent investigations may run in parallel; implementation runs in
parallel only when file ownership does not overlap.

Original upstream frontmatter used `tools: <comma list>` and `model: inherit|sonnet|haiku`.

### 5b. Hierarchy, model tiers, and escalation

Three practical tiers:

```
DEEP — orchestration / architecture / security / very hard debugging
  ├── codebase-orchestrator
  ├── architect-reviewer
  └── security-reviewer
STANDARD — most implementation / testing / review
  ├── debugger
  ├── typescript-pro / python-pro / rust-engineer
  ├── database-engineer / websocket-engineer
  ├── performance-engineer / embedded-systems / iot-engineer
  ├── api-designer
  ├── code-reviewer / test-engineer
  ├── general            (built-in, pinned)
  └── docker-expert / ui-designer
FAST — search / docs / triage / simple validation
  ├── explore            (built-in, pinned via config)
  ├── researcher
  ├── agent-organizer
  ├── ui-ux-tester
  └── api-documenter
```

| Tier | Model | Rationale |
|---|---|---|
| DEEP | `glm-5.3`, `kimi-k3`, `qwen3.8-max` | orchestration, architecture, security, very hard debugging. Only three agents, spread across three frontier models because each has a $15/month Go allowance. |
| STANDARD | `minimax-m3` | most implementation, testing, and review; capable coder with a large ($60/month) allowance. |
| FAST | `mimo-v2.6-flash` | search, docs, triage, simple validation; cheapest zero-retention model with a large allowance. |

#### Escalation ladder

Assign the cheap tier by default and escalate only when needed:

```
FAST   explore / researcher / ui-ux-tester / api-documenter / agent-organizer
  ↓ only when needed
STANDARD   debugger / language pros / database / websocket / code-reviewer / test-engineer
  ↓ only when genuinely hard or high-risk
DEEP   architect-reviewer / security-reviewer / codebase-orchestrator
```

Examples:

- `explore` (FAST) → `debugger` (STANDARD) → `architect-reviewer` / `security-reviewer` (DEEP)
- `code-reviewer` (STANDARD) → `security-reviewer` (DEEP) when it detects auth/input risk

In OpenCode this is realized through delegation: `codebase-orchestrator` (which
can launch any tier) starts with FAST work and escalates to STANDARD or DEEP only
when the task warrants it, rather than parking an expensive model on every agent.

To regenerate this setup on Claude Code, map tiers to Claude models, e.g.
DEEP → `opus`, STANDARD → `sonnet`, FAST → `haiku`.

### 5c. Return protocol

Every specialist subagent ends with the same `## Return Protocol` instruction and
a shared schema, then only the fields its category needs:

```
status: complete|blocked|needs_decision
summary: []
evidence: []
changes: []
validation: []
risks: []
open_decisions: []
blockers: []
escalation:
  agent: null
  reason: null
```

Category additions:

- **Implementation** (`typescript-pro`, `python-pro`, `rust-engineer`, `database-engineer`, `docker-expert`, `websocket-engineer`, `iot-engineer`, `embedded-systems`, `ui-designer`): `files_changed: []`
- **Investigation** (`researcher`, `debugger`): `findings: []`, `root_cause: null`, `recommendation: []`
- **Review** (`code-reviewer`, `security-reviewer`, `architect-reviewer`, `performance-engineer`, `ui-ux-tester`, `test-engineer`): `findings:` entries of `{severity, location, issue, evidence, recommendation}`
- **`api-designer`**: `decision: {recommendation, alternatives, tradeoffs}`
- **`api-documenter`**: `docs_updated: []`, `docs_missing: []`

The instruction tells agents to return concise YAML-like output (no emojis, no
tables, `path:line` references, no invented metrics). Built-in `explore`/`general`
and the primary agents do not carry this protocol.

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
`opencode-go/<model-id>` form. The three agent tiers are defined in
[§5b](#5b-hierarchy-model-tiers-and-escalation):

- **DEEP:** `glm-5.3`, `kimi-k3`, `qwen3.8-max`
- **STANDARD:** `minimax-m3`
- **FAST:** `mimo-v2.6-flash`

There is **no automatic model-escalation plugin**. Escalation is the ladder in
§5b: start FAST, move to STANDARD when needed, and reach DEEP only for genuinely
hard or high-risk work, driven by `codebase-orchestrator`'s delegation.

## 8. Adaptations applied (vs upstream sources)

When porting back to Claude Code, reverse these where relevant:

1. **Frontmatter:** VoltAgent `tools:` → OpenCode permissions. V2 uses a
   `permissions` array of `{action, resource, effect}` with a
   `{action:"*", resource:"*", effect:"deny"}` baseline plus explicit allows
   (actions `read`, `glob`, `grep`, `edit`, `shell`, `webfetch`, `websearch`,
   `subagent`, `skill`). Some agents still carry the legacy v1 `permission`
   object, which V2 also accepts. `model:` aliases (`inherit`/`sonnet`/`haiku`) →
   `opencode-go/*` IDs. Added `mode:`. All custom agents allow `skill` so they
   can load a matching skill on demand; the built-in `explore` is granted
   `skill` too via a config override.
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
- Svelte skills (ai-tools): https://github.com/sveltejs/ai-tools @ `a5a92c68`
- Svelte skills (svelte): https://github.com/sveltejs/svelte @ `020242d6`
- VoltAgent subagents: https://github.com/VoltAgent/awesome-claude-code-subagents @ `82b73821`
- Context7: https://github.com/upstash/context7
- Grep by Vercel: https://grep.app
- Playwright MCP: https://github.com/microsoft/playwright-mcp
- Licenses: `~/.config/opencode/skills/THIRD_PARTY_NOTICES.md`

_Generated as a point-in-time snapshot of the local setup. Pinned revisions are
not auto-updated._
