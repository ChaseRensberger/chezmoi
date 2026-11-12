# Global agent instructions

These are defaults. Explicit requests and repository instructions take precedence.

## Communication and alignment

- Keep replies and docs concise. Explain unfamiliar commands and important choices. Keep private deliberations out of public docs.
- Use prior context when arguments are absent. Distinguish suggestions from approval. Use the question tool until scope, acceptance criteria, and permission are clear.
- Before changes, state the result, assumptions, and verification. Prefer simpler approaches. Discuss product conflicts or awkward workarounds before proceeding.

## Implementation

- Read current documentation and relevant code before design decisions.
- Reuse existing components and behavior. Separate responsibilities and centralize shared configuration.
- Use Bun, bunx, and uv unless the repository requires otherwise. Prefer Oxlint and Oxfmt. Avoid accidental npm lockfiles and system Python dependencies.
- Preserve unrelated changes. I often have multiple changes being built on the same branch simultaneously.

## Approval & Commits

- Ask before committing, publishing, merging, or deleting resources. Suggestions grant no execution permission. Stage only approved changes, never with `git add -A` or `git commit -a`.

## UI

- Prefer Tailwind and existing primitives. Use parent flex or grid gaps and consistent spacing and controls.
- Consult established interaction examples. If fixes repeat, inspect the shared layout instead of adding overrides.
