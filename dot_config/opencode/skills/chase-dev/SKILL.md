---
name: chase-dev
description: Follow Chase's development workflow for task alignment, detached worktrees, verification, code review, commits, pull requests, status, and cleanup. Use for work-* commands and suggest-commit.
---

# Chase development workflow

## Align before execution

- Treat command arguments as optional guidance. Recover the task from earlier messages and the local task record.
- Separate agreed decisions from suggestions. Do not treat an earlier proposal as approval.
- If the goal, scope, target, acceptance criteria, or permission is unclear, use the question tool before acting.
- Ask focused questions until the approach is clear. Do not make the user repeat settled context.
- Before changes, state the intended result, assumptions, and verification. Recommend a simpler approach when it fits better.
- Respect repository instructions and the active agent's limits. In Plan mode, discuss the workflow without executing it.
- A command authorizes its named step, not unrelated edits, publication, merging, or deletion.

## Load the relevant instructions

- For any `work-*` command, read `references/work.md`.
- For `work-review`, also read `references/review.md`.
- For `work-finish` or a commit suggestion, also read `references/commits.md`.
- Whenever you write English or Markdown, load and apply both `technical-writing` and `unslop`. This includes replies, docs, command prompts, commit messages, and PR descriptions.

## Preserve scope and evidence

- Inspect task files and necessary context. Preserve unrelated work, including staged changes.
- Use existing repository commands and OpenCode capabilities before adding tooling. Do not delegate unless the user requests it.
- Keep task notes local. Do not put private decisions, questions, or audit history in public documentation or PR descriptions.
- Report concrete results, blockers, and the next decision. Do not claim that a check passed unless you ran it.
- Keep workflow definitions under `~/.config/opencode/commands/` and `~/.config/opencode/skills/` for now.
