# clonedeps

`clonedeps` is an OpenCode workflow skill for cloning a small set of
important dependency source repositories into a local ignored workspace so agents
can read library internals.

Research source URLs and refs directly, or delegate focused research to the
built-in `general` agent. Ask for approval, then perform git and filesystem
operations directly.

There is intentionally no helper script. Dependency discovery, ref validation,
and cloning are repo-specific enough that the guided workflow is
safer than a brittle cross-ecosystem script.

Cloned repositories live under `.slim/clonedeps/repos/<safe-repo-name>/`, one
folder per source repository, and are ignored by git. `.slim/clonedeps.json` is
intentionally trackable project
metadata. After cloning, add or update a concise
`## Cloned Dependency Source` section in root `AGENTS.md` that lists each
read-only cloned repo path directly with a one-sentence purpose.

If `.slim/clonedeps.json` already exists, read it first and reuse those clones
before researching new recommendations.
