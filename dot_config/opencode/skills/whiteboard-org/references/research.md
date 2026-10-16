# /dev/fast and Whiteboard

Snapshot: October 4, 2026. This rewrite preserves the supplied research and caveats without new research. Citations refer to [sources.md](sources.md).

## Contents

1. [Product and timeline](#1-product-and-timeline)
2. [Company and funding](#2-company-and-funding)
3. [People](#3-people)
4. [Architecture](#4-architecture)
5. [Repositories and releases](#5-repositories-and-releases)
6. [Open and planned products](#6-open-and-planned-products)
7. [Plugins and ecosystem](#7-plugins-and-ecosystem)
8. [Installation and use](#8-installation-and-use)
9. [Advice and limits](#9-advice-and-limits)
10. [Community and press](#10-community-and-press)
11. [Competitors](#11-competitors)
12. [Unknowns and recommendations](#12-unknowns-and-recommendations)

## 1. Product and timeline

/dev/fast is a confirmed Y Combinator Winter 2026 (W26) company. Founders: Sid Menon (CEO), Milan Bhandari (CTO), Ketan Agrawal (CSO), and Alex Iansiti (CPO). Its primary YC partner is Gustaf Alströmer. [1, 2]

Whiteboard is an MIT-licensed macOS, Windows, and Linux app built on bundled Code OSS, VS Code's open-source base. People and agents design software together. Its SDK, a software development kit, lets agents draw explanations. [3–10]

The site calls it `whiteboard(1) [beta]`, a canvas for thoughtful software combining diagrams, code comparisons, and agent histories. [2, 8] The team calls difficulty understanding agent-written changes “cognitive debt.” Its YC launch argues against merging code you cannot confidently describe. Reviewers act like staff engineers, reading design proposals and diagrams rather than 1000+ line comparisons. [1, 2]

The three main features are:

- Sequence, database/entity-relationship, and flow diagrams, plus call trees, link to code. Entity-relationship diagrams show relationships between data records. [6, 8]
- Semantic diffs compare code structure through abstract syntax trees (ASTs). Long added functions become pseudocode, or plain descriptions. Tests and documentation collapse. [3]
- The Decision Log links agent conversation quotes to their implementing code. These histories are also called trajectories or traces. [3, 8, 10]

YC calls it an “AI-native code forge,” a host for code and team development. Founder bios say “building the next GitHub.” [1, 2] Sid says it works alongside Cursor and other coding environments. He rejected the IDE (integrated development environment) label. Version v0.1.3 renamed `ide -> canvas` in #587. [11, 12]

It targets AI-heavy developers who want to understand their code. The old README excludes people happy with line-by-line review. [4] It is beta, version 0.x. Latest stable: v0.2.0, October 2, 2026, with later commits already merged. [13]

| Date | Event |
|---|---|
| 2025 | Founded, per YC. Crunchbase names the legal entity Workable Solutions Inc., Wilmington, DE. [1, 2, 14] |
| January 2026, W26 | YC launch: Carson, “More secure than OpenClaw, More capable than Cowork.” The desktop agent generated task-specific interfaces with detailed runtime permissions. YC still lists Carson under Previous Launches. [1, 2, 15] |
| Mid-2026 | Shifted to Review: “/dev/fast: Cursor for Code Review,” on YC. Repository: `devdotfast/review`. Initially macOS Apple silicon only. [1, 2, 4] |
| August 11, 2026 | StartupHub.ai profile, with unsupported claims discussed in section 10. [16] |
| September 21, 2026 | diffr 0.1.0 and 0.1.1 published to crates.io. [17, 18] |
| About September 23–24 | Review became Whiteboard in PRs #479–#482, labeled “Whiteboard 1–5/5,” plus #507 and #543. Release files became `Whiteboard.dmg`. [19, 20] |
| September 24 | Show HN: “Whiteboard (YC W26) – An open-source IDE for thoughtful software design.” Releases v0.1.1 and v0.1.2. [5, 21–23] |
| September 26–October 2 | Releases v0.1.3, v0.1.5, then v0.2.0 with the Ask agent preview. [12, 13, 24] |
| October 3 | diffr plugin interface v2, PR #80, merged. [25] |

The site uses tmux-like tabs and manual-page headings: `whiteboard(1)`, `SEE ALSO`, and `dev.fast(1)`. [8, 9] The report interprets /dev/fast as a Unix device-file pun, like /dev/null. The team gives no explanation.

## 2. Company and funding

YC lists Active status, Developer Tools, San Francisco, four people, and zero jobs. [1, 2] Sid thanks partner James Evans on LinkedIn. [26] The site says “backed by YC” and lists founders@dev.fast. [8, 9]

All funding figures below come from aggregators, not company announcements:

- PitchBook: Accelerator/Incubator, January 29, 2026, $500K. It matches YC's standard deal, but no source confirms the connection. [27]
- Tracxn lists $500K as a Seed round on January 1, 2026. [28]
- Crunchbase lists Carson with two rounds: a Toloka.vc-led Grant and a Pre-Seed. Its three investors are Toloka.vc, Y Combinator, and Founder Factor. [14, 29]

No announced priced seed round after Demo Day or valuation was found. Funding beyond the reported YC deal and Toloka.vc grant remains undisclosed.

The founders plan paid Hosted Whiteboard for company session creation, trace storage, and shared reviews. They promise everything will remain self-hostable. [6, 30] Pricing is unpublished. [8]

HN claims Salesforce and Modal users, unverified. [10] YC claims 2x faster mean review time and lower token costs. The 2x figure lacks public methodology: treat it as marketing. [1]

## 3. People

Three founders studied Harvard computer science, and two worked at Palantir. Alex, Sid, and Milan met through Harvard projects. Sid and Ketan met in elementary school. [1] HN describes four college friends who left tech-lead jobs. [11]

### Sidharth “Sid” K. Menon, co-founder and CEO

Sid was a Palantir cloud infrastructure tech lead for secure hybrid-cloud deployments. [1, 2] He studied Harvard computer science and math, class of 2022. Earlier work: Elementl (Dagster) engineering fellow, AWS software engineering intern, freelance backend developer at The DTX Company (Flowcode), and Systems and Technology Research machine learning intern. [31, 32]

He grew up in Ohio, attending Columbus Academy. [33, 34] He mainly authored diffr plugin v2 and the Whiteboard rename. [19, 25] Accounts: GitHub `sidkmenon`, X `@sidharthkmenon`, sidharthkmenon.com, sidkmenon.com, LinkedIn `/in/sidkmenon`. Old GitHub `sidkmenon-zz` pins `dagster-io/dagster`. [26, 31, 32, 34–36]

### Milan Bhandari, co-founder and CTO

Milan co-founded Bolto, YC S23, for AI human resources, payroll, and recruiting. Formerly Onnix AI, it raised a Series A. Aggregators report $12M. [1, 37, 38] He previously built model deployment and evaluation tools on Palantir's machine learning infrastructure team. He studied Harvard computer science, class of 2021. Accounts: GitHub `milanb17`, LinkedIn `/in/milan-bhandari-623979163`. [1, 2]

### Ketan Jay Agrawal, co-founder and CSO

Ketan engineered machine learning at Robust Intelligence for adversarial AI testing and Snowflake for data-querying agents. [1, 2] He studied Stanford Symbolic Systems, then a computer science master's around 2021–22. [39, 40] He co-authored developmental psychology papers about infants' visual experience with Michael C. Frank's lab. [41]

Projects: org-spotify in Emacs Lisp, the “nebula” digital garden, an MLX/Parakeet macOS voice transcriber, and Raspberry Pi hardware. Accounts: GitHub `ketan0`, X `@_ketan0`, ketan.me. [42, 43]

### Alex Iansiti, co-founder and CPO

Alex led full-stack engineering at Flowcode (The DTX Company) for about six years, including an enterprise architecture rebuild. [1, 2, 44] A former Pinterest software engineering intern, he wrote “The Pinternship: A Retrospective” on Medium. [45]

He attended Milton Academy and Harvard computer science, class of 2021, and wrote for HuffPost as a teenager. His bio says “rethinking dev tools for the era of slop code.” [1, 2, 46] Accounts: LinkedIn `/in/alex-iansiti`, likely GitHub `thesiti92`, which authors most release and roadmap PRs. The GitHub identity is unconfirmed.

### Contributors and advisors

Release notes name core committers `thesiti92`, `sidkmenon`, `ketan0`, and `milanb17`, plus `jykim256` in #628. [12, 19, 47] Contributor graph and GitHub API failures prevented individual commit counts. No advisors were identified.

Version v0.2.0 credits these external contributors and reporters: [13]

- patrickvossler18 for KaTeX math, KappaShilaff for layout and speed fixes, and marclundgren for the Sublime keymap.
- LeFelps for Arch packaging, plus KiranGershenfeld.
- Issue reporters namxam, MElkady, cannonpalms, and mhebert-inkbit.

## 4. Architecture

### Desktop app

Code OSS is bundled in `apps/review-desktop` because agents struggle with patch series. The team removes stock features, noting that Copilot accounts for about 45% of VS Code's codebase. [4] Whiteboard inherits VS Code keybindings and Language Server Protocol (LSP) navigation. [6] The README promises regular upstream security and feature patches. [3, 4]

The TypeScript workspace uses Node 24, pnpm 11, and oxlint/oxfmt for linting/formatting. [4] React and StyleX power the UI, with react-query/zustand state since v0.2.0. [13] MDX/Markdown reviews embed sections, markdown, flow diagrams, code peeks, call-stack diffs, sequences, and database “lenses.” [48] DeepWiki claims Electron and Hono, unconfirmed. [49]

Agents connect through four routes:

1. MCP (Model Context Protocol) agent tools through `whiteboard mcp`: `session_edit`, `session_get`, `review_upload`/`session_upload`, `review_lens_edit`, and `session_activity_begin/update/end`. Upload kinds: `image | trace | map`. Activity uses lease IDs and `POST /:id/activity/{begin,update,end}`. Commands use UUID command IDs. Internal links use `review-source:`. [48, 50–52]
2. CLI (command-line interface) fallback: `… api session_get`, `… api session_edit`, `… api tools`. The report's ellipsis is a placeholder. [53]
3. Agent skills `/dev-review` and `/dev-review-map`, plus `.claude-plugin`/`.agents/plugins` manifests. [3, 54]
4. ACP, the Agent Client Protocol, for the Ask panel. [55]

Supported agents include Claude Code, Codex, Cursor, OpenCode including OpenCode 2, Pi/oh-my-pi, and Copilot CLI. Pull request reviews support GitHub Enterprise Server. [13, 24]

Agents receive fixed base/head checkouts and write reviews through MCP for Whiteboard to display. Copy for Agent, `⇧⌘C`, copies selections back to agents. [8] Ask, `⌘L` in v0.2.0, streams local-agent answers into a side panel. Default behavior refuses edits and requires approval for other tools. Margin-anchored threads become Outdated when their text changes. [13, 56]

Checkouts are local. Optional anonymous PostHog telemetry excludes code, diffs, Whiteboard text, prompts, and model output. [3, 4] Linux GPG fingerprint: `0760DDC0AACD234D42A2C62626D3C32D039A5EC3`. [9] macOS builds are notarized.

Version v0.2.0 reduced the DMG from 322.0 to 274.2 MiB and installation from 734.3 to 657.7 MiB. Release notes claim 25% smaller than VS Code 1.140.0. [13]

### diffr engine

diffr forks Wilfred Hughes's MIT-licensed difftastic in Rust. Its TUI (text-based user interface) comes from Modem Labs' MIT-licensed hunk. The fork adds better TUI behavior, AST-based fold matching, and plugins. Folds hide code regions. [57]

Its processing steps are:

1. Load the Git comparison through gix, which replaced libgit2 in #80. [25]
2. Let the classifier plugin tag files and choose which to hide. [25]
3. Parse each file with tree-sitter, then run difftastic's AST comparison plus a line comparison. [57]
4. Let shape plugins set folds and display state. [25]
5. Stream records in completion order as NDJSON, newline-delimited JSON: `diffr main HEAD --format ndjson`. [25, 57]

WebAssembly (WASM) plugins use WIT (WebAssembly Interface Types). Wasmtime 49 runs them with `component-model-async` on tokio workers. Each worker thread holds one Store with every enabled plugin instantiated. Files go to the least-loaded worker. A runtime trap fails only that file. [25]

The summarizer calls large language models from the WASM sandbox through wasi-http. [25] The README supports only Gemini for pseudocode summaries. [57]

The #80 author reports about 30x faster first diffs and 5x faster total processing on large comparisons. Regex performance features reduced classification from about 1 ms to 15 µs per file. For 5,600 files, first-record delay fell from 5.6 s to 0.1 s. [25]

PR #81 zstd-compresses grammar tables in `diffr-grammars`, shrinking the macOS binary from 108.07 MB to 58.00 MB. [58] PR #82 bundles all languages into one 62.12 MB edition. [59]

The workspace requires Rust 1.99 and contains: [25]

- `crates/diffr-core`, the engine without async, Git, or WASM.
- `diffr-plugin-sdk` and `diffr-grammars`.
- `plugins/`, a `wasm32-wasip2` workspace with prebuilt `plugin.wasm` files.
- `diffr-ts`, the npm wrapper `@dev.fast/diffr`, and `tui/`, which uses Bun.
- `wit/`, `xtask/`, `vendored_parsers/`, and the manual page `diffr.1`.

## 5. Repositories and releases

Repository figures are snapshots, not current totals:

- `devdotfast/whiteboard`: desktop monorepo with `apps/review-desktop`, `packages/`, `docs/`, `scripts/`, `tools/oxlint`, `AGENTS.md`, `CLAUDE.md`, and `CONTEXT.md`. About 553 commits. Launch-week stars rose 2.2k → 2.7k, forks 97 → 124. About 42–44 open PRs and 6–9 issues. Discussions and Wiki/Roadmap enabled. MIT, with Microsoft's MIT license retained for Code OSS. [3, 4, 13, 60]
- `devdotfast/diffr`: Rust structural diff library, CLI, TUI, WASM plugins. Stars: 15 → 16+. Releases: 0.1.0, September 21, through 0.1.8. MIT plus NOTICE. [25, 57]
- `devdotfast/review`: old name, 51 stars, MIT. Matching repository IDs indicate Whiteboard's rename or redirect. [4, 13]
- `devdotfast/skills`: work in progress, with `deslop` for cleaning agent commits. The original table supplied no statistics or separate license entry. [61]

The team openly builds largely with agents. Long, prose-heavy commits include `Agent-Session:` and `Claude-Session:` trailers and “AI assistance: developed with Claude Code and OpenAI coding agents.” [25] Automated integration (CI) runs 35–46 checks per PR: native macOS end-to-end tests, Codecov, a typo checker, and clippy. diffr includes `AI_POLICY.md`. [25, 62]

Packages: npm `@dev.fast/review` v0.2.10, 33 versions, plus `@dev.fast/diffr`. [54] PR #80 renames crates.io `diffr-cli` to `diffr`. [25, 63] Homebrew: `devdotfast/tap/diffr`. [57]

| Release | Date, 2026 | Changes |
|---|---|---|
| v0.0.x | Before rename | Still named Review Desktop. [19] |
| v0.1.0–v0.1.2 | September 24 | Launch releases. [22, 23] |
| v0.1.3 | September 26 | Ubuntu APT, oh-my-pi, and PostHog symbolication, which maps error traces to source names. [12] |
| v0.1.5 | September 28 | Intel Mac, Arch pacman repository, Copilot CLI, and GitHub Enterprise Server. [24] |
| v0.2.0 | October 2 | Ask agent, sharing without a Git repo, `reviewReady` notifications, KaTeX, saved state, and diffr 0.1.8. Splitting `session_activity` requires older agent configurations to update. [13] |

## 6. Open and planned products

The desktop app, diffr engine/plugins, SDK, MCP tools, and skills are reported MIT-licensed. No license changes were found: the codebase remained MIT.

Hosted Whiteboard is planned, closed or not yet built, for the team features in section 2. [6, 8, 30] Private repository `Fix-Fast/dev` runs the install.dev.fast Worker, per #543. [20] The pricing invitation says “Interested? Get in touch.” [8]

## 7. Plugins and ecosystem

diffr has seven publishable plugin crates, including context, summarize, test/documentation collapse, and hide-files, now folded into the classifier. [63] Plugin API v2 dates to October 3.

Start plugin code with `use diffr_plugin_sdk::prelude::*;`. The two plugin kinds are: [25]

| Kind | Interface and export |
|---|---|
| Classifier | `GuestClassifier::classify(&self, FileEntry) -> Classification { tags, hidden }`, exported with `export_classifier!`. |
| Shape | `GuestPlugin::visit(&self, cursor: &Cursor, phase: Visit)`, exported with `export_shape!`. The host calls it before and after each node, like Go's `astutil.Apply`. |

Declare fold queries per language in `plugin.toml`. Compilation before WASM execution catches query errors early. Plugins access typed Git operations `check-attr` and `cat-file`. Build with `cargo xtask build-plugins`, test with `test-plugins`. [25]

Claude Code and Codex have plugin marketplaces, alongside the MCP/ACP integrations. Listed command: `claude plugin marketplace add devdotfast/skills`. [61]

TrueDaerk/ike's TUI “Epic 0540: Agent trace graph” cites MIT Whiteboard as inspiration. [64] Public forks include patrickvossler18 and dhx. [65, 66]

## 8. Installation and use

Before using these dated commands, consult official instructions for your version.

1. Download macOS arm64/x64 or Windows x64 builds from https://dev.fast/install/. [9]
2. For Linux, use the signed repositories. The report lists this DNF example: [9]

   ```sh
   dnf config-manager addrepo --from-repofile=https://install.dev.fast/repos/whiteboard.repo && dnf install whiteboard
   ```

3. For Ubuntu 24.04, use APT. For Arch, use the pacman `[whiteboard]` repository. [9]
4. For preview builds, use https://dev.fast/install/preview. They install alongside stable builds. [9]
5. Connect Claude Code, Codex, or another supported agent from the welcome screen. [3, 4]
6. Ask: “review your current branch against up-to-date main and open the result in Whiteboard.” [3, 4]
7. Request a proposed API, examples, motivation, and then implementation, in that order. [3]
8. Highlight unwanted content, copy it to the agent, and request a redraw. [3]

For npm onboarding, run `npm i -g @dev.fast/review@latest && review install`. Update with `review update`. By default, `review install` targets all supported agents. [54]

Another installer pipes jsDelivr's `onboarding.md` into `claude --dangerously-skip-permissions`. The report cautions: “think twice before running that.” [54]

For standalone diffr, install with `brew install devdotfast/tap/diffr` or `cargo binstall diffr-cli`. It accepts `git diff` arguments, such as `diffr main...HEAD -- src/`. Run `diffr config` to enable Gemini summaries. [57]

## 9. Advice and limits

The team recommends frontier models “GPT-6 Sol and Claude Opus 5.5” for intelligence/cost/speed balance, as of the snapshot. [3] Use automated reviewers like Greptile for small PRs and Whiteboard for human judgment. Request a prototype and session, refine the design, then review line by line. [6, 11]

The reported limits are:

- Whiteboard cannot edit files. [3]
- A review covers one repository. Broader support is weak. Issue #832 covers mono, poly, and meta repositories. [3, 4, 67]
- Shared reviews do not update after sharing. [3]
- Diff search covers one file at a time, tracked in #886. [68]
- Ask cannot yet comment on diagrams or show diffr inline. [13]
- Summaries support only Gemini. Issue #788 requests more vendors. [57, 69]
- diffr is alpha, with an API subject to breaking changes. AST comparisons use much CPU and memory. [57]

Known issues and fixes include:

- A top-level `oneOf` in MCP tool schemas breaks Anthropic and OpenCode. PR #621 fixed it. [51]
- Splitting `session_activity` in v0.2.0 breaks old agent configurations. [13]
- pi-acp does not pass MCP servers to Pi. Use Pi 0.99+ per #828. [53]
- Arch packages previously conflicted with `/usr/bin/review`. This was fixed. [13]

## 10. Community and press

Sid's `sidharthkmenon` posted Show HN 49833867 on September 24. It reached about 149 points/63 comments that day, then 424 points/142 comments. [6, 70] Objections changed “IDE” to “canvas.” Requests became issues, including #593. [11]

Discord: https://discord.gg/wYvd2cpMQg. [9] YouTube demos: `ChPn3ftULWE` (Whiteboard), `mDgxhzrFi2Y` (Review). [1–3] Salesforce and Modal are the only named company users, unverified.

The report calls press coverage thin and mostly auto-generated. StartupHub.ai's “Claude's Corner,” August 11, claims “git-native memory” and virtual private cloud (VPC) deployment. Neither has primary-source support. The report advises against relying on this apparent AI speculation. [16, 71] Stork.ai and search-focused aggregators repeat Show HN. [72]

## 11. Competitors

The report groups alternatives as follows:

- Automated AI reviewers: CodeRabbit, Greptile, Cursor BugBot, Copilot code review, Ellipsis. The team positions Whiteboard's human understanding as complementary to automated review. [4]
- Plan/diff annotation: Plannotator, a lighter terminal-review alternative per Review's old README. Review calls itself an opinionated framework for AI-code review. [4]
- Similar open-source “Cursor for code review”: LightLayer. [73]
- Structural diff tools: difftastic, diffsitter, and delta. [74]

Whiteboard combines code-linked diagrams/LSP, AST comparisons/WASM plugins, and agent decision links. It runs locally under MIT. Drawbacks: about 650 MiB installed, single-repository reviews, agent-dependent explanation quality, and no paid product yet.

## 12. Unknowns and recommendations

The report could not retrieve dev.fast/about or blog posts. Sid says the about page describes hosted, shared forge plans. Roadmap Wiki content, contributor rankings, and language percentages remain unconfirmed. “Next GitHub” is unproven: the product remains a local review canvas.

Agent-harness developers can study diffr's WIT/Wasmtime host and Whiteboard's flat MCP schemas, activity leases, and read-only ACP Ask. Try large agent-written PRs. Pin versions: APIs and MCP tool names change weekly.
