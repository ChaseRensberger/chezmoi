# Suggest a commit subject

1. Inspect the task's status, diff summary, staged diff, and unstaged diff. Read relevant untracked files.
2. Separate task changes from unrelated work. If the intended commit scope is unclear, use the question tool.
3. Use Conventional Commits 1.0.0 with the form `<type>[(scope)][!]: <subject>`.
4. Use `feat` for new user-facing behavior and `fix` for bug fixes. Otherwise, choose `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, or `chore`.
5. Add a scope only when it is clear. Add `!` for a confirmed breaking change and follow repository requirements.
6. Describe the change in a short, concrete subject. For a suggestion, return only one subject in a copyable code block.

A commit suggestion never authorizes edits, staging, or committing.
For `work-finish`, show the proposed files and subject before requesting approval.
Stage only approved task changes. Never use `git add -A` or `git commit -a`.
If a file mixes task and unrelated edits, isolate the approved changes or ask before proceeding.
