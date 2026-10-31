# Global Agent instructions

These are personal defaults. Follow explicit task requirements and repository instructions when they differ.

## Communication and writing

- Before writing English or Markdown, load and apply `technical-writing` and `unslop`. This includes replies, docs, command prompts, commit messages, and PR descriptions.
- Keep responses short, but explain unfamiliar commands and important design choices.
- For questions that need my input, use the question tool.
- Keep UI copy literal and minimal. Avoid slogans such as “A little magic in progress” or “A clearer shape for your spending.”
- Prefer concise documentation over exhaustive coverage. Remove repetition and internal project commentary without deleting useful explanations.
- Keep private planning notes, audit history, and product deliberations out of public documentation.
- When asked for a commit message, return one Conventional Commits subject in a copyable code block. Omit explanations.

## Align before execution

- Treat command arguments as optional guidance. Recover the task from earlier messages and any local task record.
- Separate agreed decisions from suggestions. Do not treat a proposal as approval or make the user repeat settled context.
- If the goal, scope, target, acceptance criteria, or permission is unclear, use the question tool before acting. Ask until the approach is clear.
- Before changes, state the intended result, assumptions, and verification. Recommend a simpler approach when it fits better.
- Respect the active agent's limits. In Plan mode, discuss changes without executing them.
- A command authorizes its named step, not unrelated edits, publication, merging, or deletion.

## Implementation

- Before recommending tools or designing complex behavior, read current documentation and relevant implementations. Do not guess from familiarity.
- For agent systems, consult OpenCode V2 and Pi. Adapt their ideas to the project rather than copying them without thought.
- If a design needs awkward workarounds or conflicts with the product model, pause and discuss it.
- Reuse existing components and their behavior. Moving custom page code into a shared directory does not satisfy a request to use existing components.
- Keep files easy to navigate. Separate distinct responsibilities before they become one large application file.
- Put shared configuration in one place. Common navigation must not require separate edits on every page.
- Use Bun/bunx and uv unless the repository requires other tooling. Avoid accidental npm lockfiles and project dependencies in system Python.
- For new JavaScript/TypeScript tooling, prefer Oxlint and Oxfmt.
- Before delivery, remove task-created temporary files and code that the change makes unused. Make sure that local data and generated output are appropriately ignored.
- Inspect task files and necessary context. Preserve unrelated work, including staged changes. Do not delegate unless explicitly requested.
- Run repository checks and task-specific tests that prove the acceptance criteria. Report results, skipped checks, and blockers without claiming unverified success.
- Treat review and verification as stale when the relevant source changes. Honor repository restrictions on browser automation.

## Commits

- Inspect the task's status, diff summary, staged diff, unstaged diff, and relevant untracked files before proposing a commit.
- Use Conventional Commits 1.0.0 with `<type>[(scope)][!]: <subject>`. Keep the subject short and concrete.
- Use `feat` for new user-facing behavior and `fix` for bug fixes. Otherwise, choose `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, or `chore`.
- Add a scope only when clear. Add `!` for a confirmed breaking change and follow repository requirements.
- A commit suggestion never authorizes edits, staging, or committing. If the intended scope is unclear, use the question tool.
- Stage only approved task changes. Never use `git add -A` or `git commit -a`. Isolate mixed changes or ask before proceeding.

## Worktrees and task servers

- Confirm the repository, base branch, starting commit, and destination before creating a task worktree. Default to detached HEAD. Create an approved task branch before committing.
- Prefer OpenCode's worktree tools when they support the agreed plan. Check the current capabilities rather than assuming custom refs or paths are supported.
- Preserve other checkouts. Move the session to the task worktree before edits, and move out before removal.
- Keep each worktree's database, daemon state, credentials, logs, build output, and dependency layout separate. Share tool-managed caches, not writable build directories or symlinked `node_modules`.
- Read server configuration before launch. Use task-local ports and confirm the actual listeners, API target, authentication, and readiness. Retry bind conflicts.
- Track task-owned processes and verify their identity before stopping them. Never kill by port or process name alone.
- Ask before deletion. Preserve unexpected edits, unpublished commits, and useful data. Never infer abandonment from age or remove shared caches.

## Local task records

- For `work-*` tasks, resolve the shared Git directory with `git rev-parse --path-format=absolute --git-common-dir`. Keep task records at `<git-common-dir>/chase-dev/<task-id>/record.md`. Leave existing records in place.
- Record the goal, acceptance criteria, definition of done, decisions, open questions, and next action. Include the checkout, worktree, starting commit, base, task branch, session ID, and PR URL.
- Record task-owned runtime paths, commands, process identities, URLs, and verification evidence. Never record credentials.
- Update the record after decisions and state changes, except during read-only status checks. Keep it concise and outside tracked project files.
- Treat records as context, not proof. Recheck Git, processes, and GitHub. If a record is missing, recover context and clarify uncertainty before creating one.

## UI

- Keep the interface focused on the task. Do not fill empty space with logos, headings, statistics, instructions, or decorative controls.
- Prefer Tailwind and existing component primitives over custom CSS and controls.
- Put spacing in parent layouts with flex/grid and gap. Avoid scattered child margins and separate top/bottom padding fixes.
- Keep padding, alignment, control heights, and radii consistent across related components.
- For complex tables and interactions, consult established examples before inventing another implementation.
- If repeated visual fixes fail, investigate the shared layout or component instead of adding more local overrides.
