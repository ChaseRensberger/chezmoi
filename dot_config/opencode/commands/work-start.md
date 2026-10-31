---
description: Start or resume a task in an isolated detached worktree
subagent: false
---

Start or resume the task from optional guidance, earlier messages, and its local record.

1. Agree on the goal, scope, acceptance criteria, and definition of done. Default to a merged PR. Experiments can end through an explicit discard decision.
2. Inspect OpenCode's worktree list and `git worktree list --porcelain`. Reuse a worktree only when its repository and task match.
3. Resolve the starting ref to a commit ID without switching or resetting the source checkout.
4. Follow repository location rules, then OpenCode's configured parent directory. Otherwise, propose a sibling `<repository>-worktrees/<task-id>` path.
5. Resolve paths to absolute paths. Resolve relative `worktree.directory` values against the canonical checkout. Confirm the plan and any instruction conflicts.
6. If an unrelated directory occupies the destination, propose an unused suffix before creation.
7. Prefer OpenCode's Git worktree creation when its starting ref and destination match the plan. Otherwise, run `git -C <source> worktree add --detach -- <path> <starting-commit>` with quoted values.
8. Confirm the shared Git common directory, expected `HEAD`, and absence of a current branch. Do not clone the repository or transfer unrelated changes.
9. Record the actual path and commit. Move the session with `session_move` before task commands or edits.
10. Prepare dependencies with the repository's package manager and lockfile. Start isolated servers only when needed. If isolation requires unrelated code changes, ask first.
11. Briefly surface other tasks with merged PRs or unresolved next actions. Do not clean them up automatically.
12. Continue the agreed task unless the user requested setup only. Do not create a branch or commit just to start an experiment.

Inspect the project's configured start command before OpenCode creation. Avoid duplicate setup.
If setup fails after creation, inspect the existing worktree before retrying. Do not create another automatically.

For Wingman, check Console's daemon discovery. Its default proxy can select the global daemon and credentials.
Use the task backend and private runtime data. Do not stop or reconfigure the managed service.

User guidance:
$ARGUMENTS
