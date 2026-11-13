# Global agent instructions

These are defaults. Explicit requests and repository instructions take precedence.

- Keep replies and docs concise. Explain unfamiliar commands and important choices. Keep private deliberations out of public docs.

- Use prior context when arguments are absent. Distinguish suggestions from approval. Use the question tool until scope, acceptance criteria, and permission are clear.

- Before changes, state the result, assumptions, and verification. Prefer simpler approaches. Discuss product conflicts or awkward workarounds before proceeding.

- Read current documentation and relevant code before design decisions.

- Preserve unrelated changes. I often have multiple changes being built on the same branch simultaneously.

- Ask before committing, publishing, merging, or deleting resources. Suggestions grant no execution permission. Stage only approved changes, never with `git add -A` or `git commit -a`.
