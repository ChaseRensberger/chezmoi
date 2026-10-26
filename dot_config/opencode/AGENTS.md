# Global Agent instructions

These are personal defaults. Follow explicit task requirements and repository instructions when they differ.

- Before development work load the `chase-dev` skill and follow its instructions.

## Communication and writing

- Keep responses short, but explain unfamiliar commands and important design choices.
- For questions that need my input, use the question tool.
- Keep UI copy literal and minimal. Avoid slogans such as “A little magic in progress” or “A clearer shape for your spending.”
- Prefer concise documentation over exhaustive coverage. Remove repetition and internal project commentary without deleting useful explanations.
- Keep private planning notes, audit history, and product deliberations out of public documentation.
- When asked for a commit message, return one Conventional Commits subject in a copyable code block. Omit explanations.

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

## UI

- Keep the interface focused on the task. Do not fill empty space with logos, headings, statistics, instructions, or decorative controls.
- Prefer Tailwind and existing component primitives over custom CSS and controls.
- Put spacing in parent layouts with flex/grid and gap. Avoid scattered child margins and separate top/bottom padding fixes.
- Keep padding, alignment, control heights, and radii consistent across related components.
- For complex tables and interactions, consult established examples before inventing another implementation.
- If repeated visual fixes fail, investigate the shared layout or component instead of adding more local overrides.
