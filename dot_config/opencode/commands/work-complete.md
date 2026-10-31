---
description: Review and publish work, or confirm done and clean up
subagent: false
---

Read prior context, the task record, local changes, and current PR state and feedback.
Propose publication, cleanup, or keeping work in progress. Use the question tool if the next action is unclear.
Never merge automatically. Publication does not authorize cleanup.

## Review and publish

1. Review all task changes since the starting commit, including staged, unstaged, and untracked files. Read relevant code for bugs, security issues, and regressions. Do not edit during review.
2. Run required checks against acceptance criteria. Report findings with locations, severity, and failure scenarios, then results and gaps. Resolve blockers before publication.
3. Preview scope, commit subject, branch, push destination, and PR action. Confirm with the question tool, and reconfirm scope changes.
4. If detached, create the approved branch without losing edits. Commit approved changes and push without force. Open or update the PR, checking for an existing PR before creation or retry.
5. Keep PR text brief and preserve unrelated content. Record the PR, commit, reviewed file state, and verification. Keep the worktree for feedback. Stop task servers unless requested otherwise.

## Clean up after done

1. Require a merged PR or an explicitly agreed alternative, such as discarding an experiment. Closed without merge is not done.
2. Check uncommitted and useful ignored files, plus unpublished commits. Compare against the PR's published head, accounting for squash and rebase merges. Missing proof blocks cleanup.
3. Preview exact resources and any work or data that deletion would lose. Confirm with the question tool. Unexpected work requires specific discard approval.
4. Stop only verified task-owned processes and leave the worktree. Use `git worktree remove`, never recursive directory deletion or unapproved force.
5. Remove approved runtime data. Delete the local branch only when its work is accounted for and no other worktree uses it. Preserve the main checkout, remote branches, caches, and unrelated tasks.
6. Verify removal and report anything preserved. Record progress so failures can resume. Remove the task record last, after success.

User guidance:
$ARGUMENTS
