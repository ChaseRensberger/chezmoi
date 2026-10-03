---
description: Suggest one Conventional Commits subject for the current changes
agent: plan
---

Suggest one Conventional Commits 1.0.0 subject for the current changes.

Run `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff`.
If untracked files matter, read only what you need.

Do not change files, stage changes, or commit.
Use `feat` for new user-facing behavior and `fix` for bug fixes. Otherwise, use `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, or `chore`.
Add a scope only if it is clear. Add `!` only for a clear breaking change.

```text
<type>[(scope)][!]: <subject>
```

Output only the subject in a copyable code block. Do not add a body, footer, or explanation.

User guidance:
$ARGUMENTS
