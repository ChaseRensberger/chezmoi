---
description: Preview and confirm task commits and PR publication
subagent: false
---

Prepare the task from optional guidance, earlier messages, and its local record for a PR.

1. Recover the agreed scope and current PR feedback. Check that review and verification cover the exact changes to publish.
2. If evidence is missing or stale, follow `~/.config/opencode/commands/work-review.md` first. Resolve blockers with the user before publication.
3. Apply the global commit rules. Preview the commit scope, subject, proposed branch if detached, push destination, and PR action.
4. Use the question tool to approve the commit and publication plan. If the scope changes, ask again.
5. If detached, create the approved task branch with `git switch -c <branch>`. Confirm the previous `HEAD` and uncommitted edits remain unchanged.
6. Commit only approved changes, push without force, and open or update the PR against the agreed base. Check for an existing PR before creation or retry.
7. Keep the PR description brief. State the result, verification, and relevant limitations. Preserve unrelated PR text and omit private task notes.
8. Record the PR URL and published commit. Stop task-owned servers unless the user wants them running. Keep the worktree and branch for PR feedback.

Do not merge, clean up, or mark the task done because publication succeeded.
If the user is not ready to commit, preserve the experiment without publishing it.

User guidance:
$ARGUMENTS
