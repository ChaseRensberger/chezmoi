---
description: Account for session changes and side effects without changing or cleaning up anything
agent: plan
subagent: false
---

Audit what the agents changed or caused during the whole current session, unless the user specifies a narrower scope below.
Include delegated work and side effects of tools, scripts, tests, builds, installers, and cleanup, not just direct file edits.

## Gather evidence

1. Establish the scope from the conversation and user guidance. State the boundary. Ask only if a narrower scope is ambiguous.
2. Review available messages, tool calls, results, and existing task records. Distinguish proposed actions, attempted actions, and confirmed effects. A failed command may still have changed something.
3. Verify current state with targeted read-only checks of the paths and resources implicated by that evidence. Include locations outside the repository and resources created and later removed.
4. In relevant repositories, inspect staged, unstaged, untracked, and relevant ignored files, plus commits, branches, worktrees, refs, stashes, and remote operations. Use Git without optional locks. A clean working tree does not prove that no changes occurred.
5. Separate confirmed agent changes from pre-existing work, other actors' changes, and changes whose origin is unknown. Do not infer ownership from timestamps or the current diff alone.

Cover each applicable category:

- Files and directories created, edited, overwritten, moved, or deleted, including generated output, temporary files, caches, logs, and task records.
- Project, user, system, shell, editor, and OpenCode configuration, including environment settings, startup files, and permissions.
- Dependencies, lockfiles, installed packages, tools, binaries, symlinks, and changes to shared caches.
- Git state and history, including commits, staging, branches, worktrees, pushes, resets, and force operations.
- Databases, migrations, volumes, persistent application data, credentials, authentication, and access changes. Never expose secret values.
- Processes, listeners, ports, containers, services, scheduled jobs, and startup behavior, including resources left running.
- External effects such as deployments, published packages, uploads, remote resources, PRs, comments, and messages. Distinguish ordinary read requests from changes to remote state.

## Keep the audit read-only

Do not edit or export files, update task records, clean up, undo changes, stage, commit, fetch, pull, install, run tests or builds, start services, or stop processes.
Do not make remote mutations or start infrastructure to inspect it. If a check requires a mutation, report that limitation instead.
Do not scan the whole machine or dump unrelated files, environment variables, credentials, or raw session logs. Inspect only evidence-linked resources.
Normal OpenCode session persistence, provider requests, and tool logging can still occur. Do not claim that the audit leaves zero traces.

## Report

Lead with a short summary of confirmed changes, what remains, and any destructive or hard-to-reverse actions.
Then list changes grouped by category. For each item, give the exact path or resource, the action, the evidence, and its current status.
Distinguish effects still present, effects already reverted or removed, operations still running, and state that could not be verified.
For destructive actions, state known data loss, available recovery evidence, and any uncertainty. Do not promise reversibility without evidence.
Keep repeated actions on the same resource together, but retain meaningful intermediate effects.
End with checks performed and coverage gaps, including missing or compacted history, missing baselines, inaccessible resources, and uncertain attribution.
If no changes are found, say "No changes found in the available evidence" and state the coverage. Never turn missing evidence into a claim that nothing changed.
Keep the report concise. Do not suggest or perform cleanup unless the user separately requests it.

User guidance:
$ARGUMENTS
