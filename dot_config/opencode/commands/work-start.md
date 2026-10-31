---
description: Start or resume a task in an isolated detached worktree
subagent: false
---

Start or resume the task from prior context and optional guidance.

1. Agree on the goal, acceptance criteria, and definition of done. Default to a merged PR or an explicitly discarded experiment.
2. Inspect `git worktree list --porcelain` and local task records. Reuse only a worktree that matches this task.
3. Confirm the repository, base branch, starting commit, and destination. Follow repository location rules or propose a sibling `<repository>-worktrees/<task-id>` path.
4. Create a detached worktree with `git worktree add --detach <path> <commit>`. Verify its repository, commit, and detached state. Preserve existing directories and unrelated changes.
5. Work from that directory and create or update the local task record.
6. Prepare dependencies and isolated servers as needed. Confirm ports, data paths, authentication, and the UI's backend target. Reuse the same worktree if setup fails.
7. Note forgotten tasks that need attention, then begin the agreed work unless the user requested setup only.

User guidance:
$ARGUMENTS
