---
description: Confirm done and remove approved task worktrees and runtime resources
subagent: false
---

Clean up the task from optional guidance, earlier messages, and its local record.

1. Inspect only the cleanup target. Check Git state and query the recorded PR's current state.
2. Require proof of the agreed definition of done. Default to the matching PR being merged. A closed, unmerged PR does not qualify.
3. Inspect staged, unstaged, untracked, and ignored files for useful work. Check for local commits not covered by the published PR.
4. Account for squash and rebase merges. Compare local work with the PR's published head, not only the base branch's ancestry. If proof is missing, stop and ask.
5. For an abandoned experiment or another definition of done, confirm that outcome explicitly. Never treat age as permission to discard work.
6. Preview the exact worktree, local branch, processes, and runtime paths to remove. Identify edits, commits, or data that deletion would discard.
7. Ask for confirmation with the question tool. Unexpected work blocks normal cleanup. Discard it only after explicit, specific approval.
8. Verify process ownership and stop task servers. Move the session to the surviving checkout before removal.
9. For an OpenCode-managed Git worktree, prefer `worktree_remove` so OpenCode updates its records. Otherwise, run `git -C <surviving-checkout> worktree remove -- <path>` with quoted values.
10. Verify removal in the worktree list. Do not force removal without specific discard approval. Never delete the canonical checkout or worktree metadata by hand.
11. Remove only approved runtime resources. Delete the local task branch only when no other worktree uses it and its work is accounted for. Preserve remote branches unless separately authorized.
12. Update the record after each completed step so interrupted cleanup can resume. Remove the record last, after cleanup succeeds.

If removal fails, preserve the record and report the failure. Do not recursively delete the worktree directory.
Do not rerun review, merge PRs, change the definition of done, or sweep unrelated worktrees.
Report what was removed and anything preserved with its reason.

User guidance:
$ARGUMENTS
