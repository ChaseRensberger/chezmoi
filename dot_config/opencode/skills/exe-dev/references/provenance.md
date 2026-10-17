# Research provenance and freshness policy

## Scope and evidence

Research checked **2026-10-15**. This skill is independently authored from three public-source
research notes (platform, deployment, ecosystem), plus a direct reread of the official upstream
skill during synthesis. No account SSH, VM requests, credential creation, registration, billing,
or infrastructure mutations were performed. Public source checks are not live command tests.
Source `main` branches and hosted docs can change after this date.

Local synthesis inputs: `/home/chase/research_notes/Exe dev usage skill/{platform,deployment,ecosystem}.md`.
The installed skill is self-contained; those notes are provenance, not runtime dependencies.

## Authority and refresh rules

1. Start at the [official docs index](https://exe.dev/docs.md) for current feature discovery.
2. Read the specific current official guide; prefer detailed operational docs over marketing.
3. For account-authorized work, use read-only `help <command>` to confirm current syntax,
   flags, constraints, and error handling before unfamiliar or consequential mutations.
4. If live help is inaccessible, state that limitation; do not test syntax by making changes.
5. Treat generated explorer metadata as a discovery aid, not a complete current contract.
6. Treat third-party skills as ideas, not authority; verify each operational claim upstream.
7. Inspect installed guest/service versions: repository HEAD does not describe every old VM.
8. Refresh pricing, capacity limits, token permissions, integrations, domains, and destructive
   semantics at time of use. Never infer supported commands from their English descriptions.
9. Use only documented endpoints. [Undocumented commands](https://exe.dev/docs/faq/undocumented.md)
   and internal endpoints are unstable; do not reverse-engineer a management API as a shortcut.

## Primary sources checked

All entries below were checked in the research notes on **2026-10-15**; the upstream skill
was also fetched directly during synthesis that day. No exact commit pin was captured.

| Area | Sources |
|---|---|
| Discovery and official skill | [index](https://exe.dev/docs.md), [llms.txt](https://exe.dev/llms.txt), [agent skill endorsement](https://exe.dev/docs/agent-skill.md), [actual skill](https://github.com/boldsoftware/exe.dev/blob/main/skill/SKILL.md) |
| API, SSH, identity | [API](https://exe.dev/docs/api.md), [HTTPS](https://exe.dev/docs/https-api.md), [ssh_dest](https://exe.dev/docs/faq/ssh-destination.md), [key selection](https://exe.dev/docs/faq/ssh-key.md), [registration surprise](https://exe.dev/docs/faq/heisen-connect.md), [host key](https://exe.dev/docs/faq/host-key.md) |
| VM model and storage | [architecture](https://exe.dev/docs/architecture.md), [how it works](https://exe.dev/docs/faq/how-exedev-works.md), [customization](https://exe.dev/docs/customization.md), [copy files](https://exe.dev/docs/faq/copy-files.md), [disk usage](https://exe.dev/docs/faq/disk-usage.md) |
| Placement and money | [pools](https://exe.dev/docs/pools.md), [standalone](https://exe.dev/docs/standalone-vms.md), [billing overview](https://exe.dev/docs/billing/overview.md), [Personal](https://exe.dev/docs/billing/personal.md), [Work](https://exe.dev/docs/billing/work.md), [usage](https://exe.dev/docs/billing/usage.md), [pricing](https://exe.dev/pricing) |
| Network and access | [proxy](https://exe.dev/docs/proxy.md), [sharing](https://exe.dev/docs/sharing.md), [domains](https://exe.dev/docs/cnames.md), [login](https://exe.dev/docs/login-with-exe.md), [frameworks](https://exe.dev/docs/faq/nextjs-and-friends.md), [cross-VM](https://exe.dev/docs/faq/cross-vm-networking.md), [security bulletin](https://exe.dev/security/over-sharing) |
| Credentials | [integrations](https://exe.dev/docs/integrations.md), [attachments](https://exe.dev/docs/integrations-attach.md), [VM HTTP tokens](https://exe.dev/docs/https-tokens-for-vms.md), [private images](https://exe.dev/docs/private-image.md), [LLM integrations](https://exe.dev/docs/integrations-llm.md) |
| Apps and operations | [migration](https://exe.dev/docs/migrating-to-exe.md), [Docker](https://exe.dev/docs/faq/docker.md), [systemd example](https://exe.dev/docs/use-case-gh-action-runner.md), [agent updates](https://exe.dev/docs/upgrade-codex.md), [support](https://exe.dev/docs/getting-help.md) |
| Shelley | [intro](https://exe.dev/docs/shelley/intro.md), [upgrades](https://exe.dev/docs/shelley/upgrading.md), [guidance](https://exe.dev/docs/shelley/agents-md.md), [LLM deprecation](https://exe.dev/docs/shelley/llm-gateway.md), [README](https://github.com/boldsoftware/shelley/blob/main/README.md), [image](https://github.com/boldsoftware/exeuntu/blob/main/Dockerfile), [socket](https://github.com/boldsoftware/exeuntu/blob/main/shelley.socket) |

## Conflicts resolved explicitly

- **All management via SSH:** official skill wording is incomplete; official docs also expose
  HTTPS `/exec` and MCP. SSH remains the simple baseline, not the only transport.
- **Registration error shape:** API guide describes plain text; current skill describes JSON
  errors with an action command. Handle both and preserve the actual response.
- **Generated command tree:** [metadata](https://exe.dev/docs/_static/explorer/command-tree.js)
  dated 2026-08-21 omits newer standalone flags and conflicts on resource examples. Prefer
  current guides and authorized live help. Old `cli-*.md` links can return explorer HTML.
- **Setup-script size:** generated metadata says 10 KiB; current prose gives no value.
  Do not promise a durable exact limit; check current help and use reviewed indirection if needed.
- **Port/bind simplification:** VPS marketing omits explicit port selection in an 8080 example.
  Proxy docs describe EXPOSE selection including port-80 preference. Migration uses localhost;
  framework recipes use `0.0.0.0`. Test actual reachability, not a universal bind rule.
- **Alternate-port access:** older loose proxy wording does not override current Web/Root
  sharing definitions and the fixed over-sharing security bulletin.
- **Disable Shelley:** intro says disable the service; current image enables a loopback socket.
  Inspect actual installed units and verify socket plus service, not just service inactivity.
- **LLM recipes:** legacy metadata endpoint is deprecated and unavailable to accounts created
  since 2026-08-03 00:00 UTC. Discover current integration endpoints instead.
- **Pricing/capacity:** some pages mix GB/GiB or headline maxima with size-dependent limits.
  Do not normalize away the discrepancy or infer separate Personal VM allowances.
- **Backups and cloning:** regional replication and disk copy do not establish historical restore,
  undelete, DB consistency, or clone exclusion rules. These remain unverified.

## Existing-skill audit and reuse decisions

Discovery used [skills.sh](https://skills.sh/) and searches for `exe.dev`/`exedev`; install counts
were not correctness evidence. Findings below reflect source reads, not installed third-party code.

- [Official using-exe-dev](https://github.com/boldsoftware/exe.dev/blob/main/skill/SKILL.md):
  best baseline for two SSH destinations, progressive docs, identity selection, and human onboarding.
  Adopted the concepts, not copied prose. No root license was established for the skill text.
- [Kyle Lundstedt](https://github.com/kylelundstedt/dotfiles/blob/master/agents/.agents/skills/exe-dev/SKILL.md):
  useful scope/bootstrap distinctions; excluded personal vault/tailnet/services, disabled host-key
  checks, blanket forwarding, and anecdotal SSH rate-limit guarantees. Repo declares MIT.
- [Sundial](https://github.com/sundial-org/awesome-openclaw-skills/blob/main/skills/exe-dev/SKILL.md):
  explicitly auto-generated/untested; excluded stale apex target and missing domain registration.
  No root license established; a reference label/href mismatch also cautions against blind copying.
- [Metcalfc](https://github.com/metcalfc/claude-plugin/blob/main/plugins/exe-dev/skills/exe-dev-knowledge/SKILL.md):
  useful topic split; rejected overbroad triggers, universal username assumption, stale gateway,
  domain advice, and JSON `args` wrapper inconsistent with current `/exec` command-text docs.
- [Lollipopkit exedev-ctl](https://github.com/lollipopkit/exedev-cli/blob/main/skills/exedev-ctl/SKILL.md):
  useful inspect-first/error handling; third-party binary is optional, not a platform prerequisite.
  Repo declares OSL-3.0; no text/code copied.
- Popmechanic and bjesuiter discovery entries could not be matched to current skill paths in
  fetched trees. Catalog presence is not proof of current usable source.
- Shelley built-ins provide primary workflows for
  [action links](https://github.com/boldsoftware/shelley/blob/main/skills/builtin/suggesting-exe-dev-actions/SKILL.md),
  [frameworks](https://github.com/boldsoftware/shelley/blob/main/skills/builtin/node-and-js-frameworks/SKILL.md),
  and [customization](https://github.com/boldsoftware/shelley/blob/main/skills/builtin/customizing-shelley/SKILL.md).
  Shelley's actual LICENSE is Apache-2.0; this skill independently summarizes documented behavior.
