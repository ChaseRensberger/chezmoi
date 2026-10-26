---
description: Suggest one Conventional Commits subject for the current changes
agent: plan
---

Load `chase-dev` and read `references/commits.md` from its base directory.
Suggest one Conventional Commits subject for the current changes.
Use earlier context when arguments are absent. If the commit scope is unclear, use the question tool first.
Do not change files, stage changes, or commit.
Return only the subject in a copyable code block. Omit a body, footer, and explanation.

User guidance:
$ARGUMENTS
