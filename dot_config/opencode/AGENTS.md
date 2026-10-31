# Global agent instructions

These are defaults. Explicit requests and repository instructions take precedence.

## Communication and alignment

- Load `technical-writing` and `unslop` for English and Markdown.
- Keep replies and docs concise. Explain unfamiliar commands and important choices. Keep private deliberations out of public docs.
- Use prior context when arguments are absent. Distinguish suggestions from approval. Use the question tool until scope, acceptance criteria, and permission are clear.
- Before changes, state the result, assumptions, and verification. Prefer simpler approaches. Discuss product conflicts or awkward workarounds before proceeding.

## Implementation

- Read current documentation and relevant code before design decisions. For agent systems, consult OpenCode V2 and Pi.
- Reuse existing components and behavior. Separate responsibilities and centralize shared configuration.
- Use Bun, bunx, and uv unless the repository requires otherwise. Prefer Oxlint and Oxfmt. Avoid accidental npm lockfiles and system Python dependencies.
- Run repository checks and tests that prove acceptance criteria. Report results and skipped checks. Recheck after relevant changes and honor browser restrictions.
- Preserve unrelated changes. Remove task-created temporary files and newly unused code. Keep generated output and local data ignored.
- Delegate only when explicitly requested.

## Git and tasks

- Inspect staged, unstaged, and relevant untracked changes. Use Conventional Commits with clear scopes and `!` for confirmed breaking changes. For suggestions, return one subject in a code block without explanation.
- Ask before committing, publishing, merging, or deleting resources. Suggestions grant no execution permission. Stage only approved changes, never with `git add -A` or `git commit -a`.
- Default to detached Git worktrees. Confirm the repository, base, commit, and path. Create an approved branch before commits. Work there and leave before removal.
- Isolate task ports, data, credentials, dependencies, and build output. Share caches, not writable build directories or symlinked `node_modules`. Confirm listeners, API target, authentication, and readiness.
- Stop only verified task-owned processes. Preserve unpublished work, useful data, other worktrees, and shared caches.
- Keep `work-*` records at `<git-common-dir>/chase-dev/<task-id>/record.md`. Record the goal, acceptance and completion criteria, decisions, questions, next step, Git and PR details, runtime resources, and verification. Update except during read-only checks. Recheck facts and omit credentials.

## UI

- Keep copy literal and the interface task-focused. Avoid decorative content.
- Prefer Tailwind and existing primitives. Use parent flex or grid gaps and consistent spacing and controls.
- Consult established interaction examples. If fixes repeat, inspect the shared layout instead of adding overrides.
