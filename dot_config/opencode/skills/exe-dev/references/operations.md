# Deployment, security, and troubleshooting

Documentation snapshot: **2026-10-15**. No live account or guest testing performed.
Commands are templates to adapt after confirming authorization and inspecting the target.

## A persistent private app

Keep deployment and exposure separate. Inspect `share show` before switching the selected
port, especially on an existing VM: `share port` does not reset public/private status.
New exeuntu uses application port 8000. EXPOSE metadata normally chooses 80 if present,
otherwise the smallest exposed TCP port >=1024; explicitly selecting the port avoids guesses.
Test the app locally, then as an authenticated owner through HTTPS, then as the intended recipient.
An unauthenticated login redirect alone does not prove the app is healthy or broken.

Use the repository's production startup path. A systemd unit should specify an actual
unprivileged user, working directory, absolute executable, restart policy, and boot target.
Do not install this illustrative unit until paths, user, and execution behavior are reviewed:

```ini
[Unit]
Description=Example HTTP application
After=network.target

[Service]
Type=simple
User=APP_USER
WorkingDirectory=/srv/APP_DIRECTORY
ExecStart=/ABSOLUTE/PATH/TO/APP --port 8000
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

For an approved unit installation, systemd's usual sequence is daemon-reload, enable/start,
status, and journal inspection. An EnvironmentFile is not secret isolation from guest Root;
prefer scoped integrations or an existing secrets mechanism and restrictive file permissions.
For containers, publish the intended HTTP port and persist data volumes deliberately.
Guest-loopback proxy support does not expose a container's unpublished loopback listener.
Do not install duplicate supervisors or overwrite an existing unit without investigating it.

Sources: [migration](https://exe.dev/docs/migrating-to-exe.md),
[proxy](https://exe.dev/docs/proxy.md), [Docker](https://exe.dev/docs/faq/docker.md),
[official systemd pattern](https://exe.dev/docs/use-case-gh-action-runner.md).

## Bind addresses, frameworks, and protocols

Official migration uses `localhost:8000`; Shelley socket source uses `127.0.0.1:9999`.
Do not insist on `0.0.0.0` universally. Framework dev-server guidance does use it where
appropriate, alongside narrow origin/host allowlists:

- Next.js >=15.2: `allowedDevOrigins: ['my-vm.exe.xyz', 'my-vm.exe.xyz:8000']`;
  documented start example `npx next dev -H 0.0.0.0 -p 8000`.
- Vite >=5: `server: {host: '0.0.0.0', port: 5173, allowedHosts: ['my-vm.exe.xyz']}`.
- Adapt to installed framework versions and the actual selected/custom hostname.
- Additional HTTPS port range is 3000–9999; do not describe that as public raw TCP/UDP.
- Private database access normally needs forwarding/Tailscale, not HTTPS on port 5432.

Configure proxy-aware scheme/host handling deliberately. `X-Forwarded-Host` includes port;
`X-Forwarded-For` preserves prior values and appends the client IP. Do not trust arbitrary
client-supplied forwarding or identity headers without an established trusted ingress path.

Sources: [framework FAQ](https://exe.dev/docs/faq/nextjs-and-friends.md),
[cross-VM networking](https://exe.dev/docs/faq/cross-vm-networking.md),
[network model](https://exe.dev/docs/faq/how-exedev-works.md).

## Domains and 421

Inspect DNS and `domain ls` independently. For a subdomain, CNAME to the actual VM hostname,
then register with `domain add`. A 421 with correct DNS strongly points to unregistered Host.
Do not “fix” it by making the app public, selecting Shelley port, or adding guest certbot.

For apex domains prefer provider ALIAS/ANAME/flattened CNAME support; the documented fallback
is an A record to the VM hostname's current IP, which can change. Register each intended name.
Cloudflare normally needs DNS-only (grey cloud) and “Flatten CNAME at root,” not flatten-all.
Ordinary orange-cloud proxying breaks exe.dev DNS validation. Paid Workers/Snippets rewriting
is a different advanced setup; do not enable it as an unexplained workaround.

Wildcard routing `*.app.example.com` covers one level, not `app.example.com` itself.
Parent wildcard-certificate reuse (`--wildcard`) still needs per-subdomain DNS and registration.
Follow the printed ACME challenge/delegation instructions rather than inventing DNS tokens.
Source: [current custom-domain guide](https://exe.dev/docs/cnames.md).

## Access and identity

Only the selected app can be public. Web collaborators get the selected app; Root collaborators
also get SSH, Shelley, Terminal, and private routes. Broader older “all users with access”
wording must not override this distinction. A fixed 2026 incident involving Web users reaching
administrative ports reinforces why access types matter; it was not anonymous Internet access.

Private requests carry stable user ID/email; public apps can explicitly require login at
`https://<vm>.exe.xyz/__exe.dev/login?redirect={path}`. Logout is POST to
`https://<vm>.exe.xyz/__exe.dev/logout`. Keep redirects constrained by app policy.
Local requests do not get identity automatically; manually inserted headers are testing only.
Documentation does not establish an exhaustive anti-spoofing guarantee for every ingress path.

Sources: [sharing](https://exe.dev/docs/sharing.md),
[login identity](https://exe.dev/docs/login-with-exe.md),
[security bulletin](https://exe.dev/security/over-sharing).

## Pools, clones, and independent backups

Check [plan](https://exe.dev/docs/billing/overview.md),
[usage](https://exe.dev/docs/billing/usage.md), [pricing](https://exe.dev/pricing),
[pools](https://exe.dev/docs/pools.md), and [standalone](https://exe.dev/docs/standalone-vms.md)
when making cost decisions; do not embed a permanent price sheet in a deployment plan.
An empty pool still bills. Resizing a VM does not resize the pool and vice versa.
Personal standalone capacity is extra even if its subscribed pool is idle. Stopped standalone
retains disk/count. Detach is irreversible and leaves original pool capacity charges unchanged.
Storage usage billing is not the same as allocated block-device capacity.

Before cloning, identify databases, `.env`, private keys, tokens, production endpoints, cron,
workers, webhooks, and outbound effects. Establish app-consistent backup/quiescence as needed.
Prefer a clean image plus sanitized data when starting copied jobs could affect production.
After copying, inspect actual grants, domains, integration attachments, credentials, and jobs;
their inheritance/exclusion semantics are not established by this research. Do not assume a
clone is scrubbed, isolated from outbound production services, or safe to expose.

Regional disk streaming is asynchronous durability, not a user-restorable backup history.
Maintain independently stored DB-aware backups, configuration, and recovery instructions;
test restores into an isolated target. Git covers committed code, not all live state/secrets.
No documented snapshot/undelete/PITR command or contractual backup retention was established.
Do not invent one or promise that cloning produces a transactionally consistent database.

Sources: [architecture](https://exe.dev/docs/architecture.md),
[clone explorer](https://exe.dev/api/step/copy-vm),
[disk usage](https://exe.dev/docs/faq/disk-usage.md).

## Shelley service and socket activation

Shelley is a privileged, single-user guest agent, not an independently secured multi-user app.
Use `https://<vm>.shelley.exe.xyz/` through intended private administrative access.
Check its working directory and `~/.config/shelley/AGENTS.md` plus project guidance.
Never make 9999 the public application port to bypass an authorization problem.

Inspect the installed generation inside the guest first:

```sh
systemctl status shelley.service shelley.socket --no-pager
systemctl cat shelley.service shelley.socket
systemctl is-enabled shelley.service shelley.socket
systemctl list-sockets --all --no-pager
ss -ltnp
```

Missing units and nonzero status for inactive units are diagnostic outcomes, not instructions
to install something. Current exeuntu source uses a socket on `127.0.0.1:9999`; older intro
docs suggest disabling only the service. If **both units exist** and disablement was requested,
a reviewed standard-systemd sequence is:

```sh
sudo systemctl disable --now shelley.socket
sudo systemctl disable --now shelley.service
```

Adapt to actual units/dependencies. Verify both inactive and not enabled, no activation socket,
and no Shelley listener. If testing the URL might activate a service, do so only after inspection
and then recheck units/listeners. A proxy login screen alone is not proof of disablement.
If stronger masking is necessary, explain why and request approval; do not mask blindly.
Rollback is to restore the previously recorded enabled/active state, not blindly enable everything.

Upgrades use UI “Check for New Version” or lobby `shelley install <vm>` when requested.
Do not upgrade/restart the live agent as an incidental dependency fix. Existing guest agent
versions are not necessarily updated by apt; inspect the image's supported update commands.
Do not assume automatic unattended security updates on long-lived guests.

Sources: [intro](https://exe.dev/docs/shelley/intro.md),
[upgrading](https://exe.dev/docs/shelley/upgrading.md),
[socket source](https://github.com/boldsoftware/exeuntu/blob/main/shelley.socket),
[Dockerfile](https://github.com/boldsoftware/exeuntu/blob/main/Dockerfile),
[Shelley security model](https://github.com/boldsoftware/shelley/blob/main/README.md).

## Integration and agent discovery

Inside an authorized guest, reflection at `https://reflection.int.exe.xyz/integrations` reveals
attached services. Prefer narrow VM attachments and minimal upstream permissions. Integrations
prevent reading stored credentials, not using them for harmful authorized-capability actions.
Respect an existing user-preferred environment/file-based credential workflow.

Current managed LLM integrations commonly use `https://llm.int.exe.xyz`; discover attachments
instead of assuming every guest has it. The metadata gateway at
`http://169.254.169.254/gateway/llm/<provider>` is deprecated and unavailable to accounts
created on/after **2026-08-03 00:00 UTC**. Do not revive old community recipes.

For optional action links, follow Shelley's actual built-in suggesting-exe-dev-actions skill:
URL-encode one command in `https://exe.dev/suggest?command=...`, preflight with `&preflight=1`,
omit all secrets, offer the human a choice, and recheck reflection after they connect.
Use a short safe Go-duration `for=` when the documented connection workflow supports it.
Do not equate the human visiting a suggestion with consent to unrelated changes.

Sources: [LLM migration](https://exe.dev/docs/shelley/llm-gateway.md),
[LLM integrations](https://exe.dev/docs/integrations-llm.md),
[built-in action skill](https://github.com/boldsoftware/shelley/blob/main/skills/builtin/suggesting-exe-dev-actions/SKILL.md).

## Layered troubleshooting

| Symptom | Read-only checks first | Avoid |
|---|---|---|
| Local app unreachable | Guest listener, process, service status, journal, local curl | Public sharing or DNS changes |
| Local works, HTTPS fails | Selected port, visibility, owner login, response status | Assuming 8080 is auto-selected |
| Login redirect | Expected private access and requesting identity | Calling it a server crash |
| Framework host/origin error | Narrow allowlist, hostname/port, installed version | Disable-all origin protection |
| Custom hostname 421 | DNS target, `domain ls`, registration, Cloudflare mode | Public exposure or guest certbot |
| Web collaborator cannot use Shelley | Web versus Root boundary, intended task | Automatic Root escalation |
| Unexpected signup | First SSH identity offered, IdentitiesOnly | Duplicate account creation |
| SSH hangs | Host prompt, intended key, routing fallback, network | Disable host verification |
| `/exec` 403 | Token transport, expiry, permissions, target scope | Issue an all-powerful token |
| `/exec` 422 | Command body/error and current help | Blind retries or JSON args wrapper |
| Shelley returns after stop | Socket/service units and activation state | Service-only success claim |

Typical guest diagnostics: `ss -ltnp`, `curl -v http://127.0.0.1:8000/`,
`systemctl status APP.service --no-pager`, `journalctl -u APP.service -n 100 --no-pager`.
Redact environment values, URLs with tokens, logs, and identity headers before sharing evidence.
For support, disclose minimal diagnostics; `grant-support-root <vm> on` is an explicit opt-in
management mutation, revoked with `off`, not a default troubleshooting step.
Sources: [getting help](https://exe.dev/docs/getting-help.md),
[HTTPS API errors](https://exe.dev/docs/https-api.md).
