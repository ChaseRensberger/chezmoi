---
name: exe-dev
description: Use whenever working with exe.dev (exedev), exe VMs, or *.exe.xyz infrastructure. Guides SSH/account discovery, VM creation and cloning, private app deployment, HTTPS ports and authentication, Web versus Root sharing, custom domains and 421 errors, pools/standalone costs, backups, Shelley setup/socket activation, scoped integrations, and debugging. Also use for migrating an app to exe.dev or reviewing exe.dev commands for safety, even when the user only says deploy, share, or fix their exe VM. Not a generic VPS or unrelated SSH skill.
---

# Operate exe.dev safely and effectively

## Working model

exe.dev provides persistent Linux VMs with managed HTTPS and SSH routing.
An OCI image supplies the initial filesystem; the machine is a VM, not just a container.
Do not assume a dedicated public IP, arbitrary public TCP/UDP, or a selectable kernel.
VMs in a pool share its reserved CPU/RAM; creating more VMs adds no pool capacity.
Managed TLS does not imply managed app deployment, app authorization, or backups.

## Choose the reference before acting

- For exact syntax, transports, registration, lifecycle, sharing, and tokens, read [commands](references/commands.md).
- For app setup, domains, identity trust, backups, Shelley, and debugging, read [operations](references/operations.md).
- For sources, conflicting advice, community skills, and freshness rules, read [research provenance](references/provenance.md).
- Start new feature research at <https://exe.dev/docs.md>; follow the relevant current page.
- Read task-specific references, not the entire manual by default.

## 1. Establish context and authorization

Determine whether you are on the user's workstation, inside an exe.dev VM, or in Shelley.
Identify the existing account/team, SSH identity, target VM, repository, and intended result.
Check project/ancestor AGENTS.md and existing service configuration before editing.
Ask only for missing decisions: deployment target, budget, audience, data persistence.
Use existing authorized credentials; do not ask the user to paste private keys or tokens.

Treat public exposure, Root grants, deletion, and additional spend as separate decisions.
Do not infer any of them from “make it work,” “share a preview,” or a failed request.
A deployment request permits its ordinary scoped steps, not unrelated infrastructure changes.
Before a consequential change, state the target, effect, cost/security/data risk, and rollback.
If authorization is unclear, propose the change and wait rather than execute it.
Keep discovery read-only until the task and target are understood.

Do not register accounts, activate subscriptions, buy credits, or accept trials incidentally.
If onboarding is requested, confirm the human's email and consent before registration.
Humans complete email/OAuth verification, payment, and ChatGPT sign-in themselves.
Treat activation, login, and share links as sensitive; never write bearer URLs to files or logs.
Opening an activation URL is not consent to subscribe.

## 2. Keep the two SSH destinations separate

**Control plane:** `ssh exe.dev <command>` sends an exe.dev management command.
It is a command lobby/REPL, not a Linux shell, and has no scp/sftp service.
**Guest:** `ssh "$SSH_DEST" '<shell command>'` executes inside the selected VM.
Full SSH, scp, sftp, and forwarding belong to the guest destination.

Use the exact `ssh_dest` from JSON creation/list output; it can include a username.
Do not invent the login username or split/rebuild `ssh_dest` unnecessarily.
For SSH libraries use returned `ssh_host` and optional `ssh_user` fields.
The normal hostname is `<vm>.exe.xyz`; a documented fallback is `vm+<vm>@vm.exe.xyz`.
Never send `apt`, `systemctl`, shell scripts, or file transfers to the lobby.
Inside a guest, use documented reflection/integration endpoints only when relevant.
Do not assume that VM-local discovery can administer the owning account.

## 3. Inspect first; discover syntax instead of guessing

The following are read-only account requests, not permission to access an unknown account:

```sh
ssh exe.dev help
ssh exe.dev help new
ssh exe.dev whoami --json
ssh exe.dev ls --json
```

For an existing target, inspect `share show`, resources, pool, and relevant billing usage.
Use `--json` for supported SSH commands; not every command accepts it.
Parse the actual response schema and preserve errors, exit status, and `ssh_dest`.
Errors can be plain text even when JSON was requested.
Before an unfamiliar mutation, obtain live `help <command>` when account access is authorized.
Do not execute a mutation as a way to discover its flags.
If no account access is authorized, use current official docs and label remaining uncertainty.
Never invent `stop`, `start`, `backup`, `snapshot`, restore, or force flags.

An unexpected registration prompt often means the wrong SSH key was offered first.
Check selected identity before concluding the user needs a new account.
Pin the intended key with `IdentitiesOnly yes`; do not enable blanket agent forwarding.
Keep host-key verification; investigate changed keys rather than deleting trust records.
`accept-new` is optional trust-on-first-use, not independent host verification.
For onboarding errors and PTY requirements, follow the commands reference.

## 4. Deploy a private application end to end

1. Inspect existing targets before creating a VM; confirm placement and cost if creation is needed.
2. Use `new --json` only when authorized; retain its returned SSH destination.
3. Inspect OS, login user, runtime, repository guidance, storage, and existing listeners.
4. Transfer code to the guest with scp/rsync or an authorized repository workflow.
5. Install only needed dependencies; keep durable credentials out of images and command arguments.
6. Configure an app listener and test it locally inside the guest.
7. Run persistent apps with systemd or a deliberate container restart policy and volumes.
8. Inspect current sharing before selecting the app port; port changes preserve visibility.
9. Verify via authenticated HTTPS before adding collaborators or making anything public.
10. Record service, port, URL, access mode, validation, and rollback without secrets.

The default exeuntu app target is 8000; do not assume 8080 is automatically selected.
Use `share port <vm> <port>` for the selected main application port.
This changes routing, not private/public status: an already-public VM remains public.
For a requested private deployment, ensure the selected app is private before switching traffic.

Guest loopback is allowed in official deployment examples; `0.0.0.0` is not universally required.
For a framework dev server, follow its current host/origin settings and test reachability.
For Docker, publish the container port to the guest; container loopback is a separate namespace.
Do not add certbot for the managed exe.dev HTTPS front door.
Do not use `nohup` or a foreground SSH session as a substitute for service supervision.
Adapt paths and service user to the actual image instead of assuming `exedev` everywhere.

## 5. Route ports without widening access

The main URL is `https://<vm>.exe.xyz/`, with TLS terminated by exe.dev.
Additional HTTPS ports 3000–9999 can proxy corresponding guest HTTP listeners.
They are not arbitrary raw TCP ports and are not automatically public with the main app.
Do not grant Root simply to make an app preview work.
For PostgreSQL, Redis, or other non-HTTP access, use an authorized SSH tunnel or private network.
Bind local tunnel listeners to `127.0.0.1` unless wider access is explicitly requested.
Do not assume VMs in the same account share a private LAN.

Next.js/Vite origin or host rejection is distinct from exe.dev authorization failure.
Allow only the intended VM/custom hostname and applicable ports in framework configuration.
Do not disable origin checks globally as the first fix.

## 6. Match sharing to the intended audience

Private HTTPS is the default; a login redirect can be correct behavior.
Inspect `share show <vm>` rather than assuming defaults still apply.
**Web** grants access to the selected app, not SSH, Shelley, or administrative ports.
**Root** grants guest-wide power, including SSH, Terminal, Shelley, and access to guest secrets.
Root sharing does not transfer ownership but can still destroy guest data.
Make a site public only on explicit request; only the selected app port becomes public.
Share links grant Web after login; do not call them anonymous public URLs.
Revoking an invitation link does not revoke people who already accepted it.
Removing a Root grant with `--root` can leave Web access; verify final effective grants.
Team grants follow team membership; check team external-sharing policy.
Warn that sharing reveals the owner's email to recipients.

## 7. Use proxy identity and credentials deliberately

Private proxy requests carry `X-ExeDev-UserID` and `X-ExeDev-Email`.
Public anonymous requests do not; app-level authorization still needs deliberate checks.
Use stable user IDs as identifiers; do not treat an email address alone as an access policy.
Trust identity headers only through the intended trusted ingress, not arbitrary direct clients.
Local curl does not receive proxy identity; injected test headers are impersonation fixtures only.
Do not claim a documented universal anti-spoofing guarantee for every ingress path.
`X-Forwarded-For` appends to prior values; its leftmost entry is not inherently verified.

For machine app access use a VM-scoped, expiring token when authorized.
Use `X-Exedev-Authorization: Bearer ...`; the generic Authorization form is deprecated here.
Keep management `/exec` credentials separate from VM-proxy credentials.
Token creation is a credential mutation, not a discovery step.
Redact tokens and permission contents from logs; never put secrets in token context/permissions.

Prefer scoped integrations attached only to the intended VM over broad credential distribution.
Integration storage hides the stored secret, but the attached VM can exercise its capabilities.
Root collaborators can still read ordinary guest `.env` files, keys, and configuration.
Use documented stdin credential input or an existing secret manager; never put secrets in URLs.
Discover attached integrations before asking the human for another credential.
Keep private-registry boot authentication separate: it happens before guest integrations exist.

## 8. Register custom domains, not just DNS

Read current domain docs before editing DNS or registration; inspect the current mapping first.
A subdomain normally needs a CNAME to `<vm>.exe.xyz` **and** `domain add <vm> <domain>`.
Correct DNS with an unregistered hostname produces **421 Misdirected Request**.
Register every intended name; TLS certificates are managed automatically.
For apex domains, follow provider ALIAS/ANAME/flattening guidance; do not target bare `exe.xyz`.
Cloudflare normally needs DNS-only and root-only flattening, not ordinary orange-cloud proxying.
Wildcard certificate reuse and wildcard routing are different features; read the reference.
Do not make a private app public to fix DNS, certificates, or a 421 response.

## 9. Check resource costs and clone hazards

Inspect current plan, placement, and usage instead of quoting cached prices as a promise.
An empty pool still bills; deleting member VMs alone does not remove pool capacity charges.
VM resize and pool resize are different: neither automatically resizes the other.
Standalone/sandbox VMs reserve separately metered capacity; Personal pays on top of subscription.
Stopped standalone VMs retain disk and count toward limits; discover supported control syntax.
Pool detach is irreversible to standalone and does not reduce the original pool's capacity bill.
Never resize, create a pool, detach, buy credits, or delete resources solely to “optimize” costs.

Treat `cp` as a full-disk clone, not sanitized test data or a proven backup.
Review copied secrets, databases, scheduled jobs, integrations, sharing, and domains.
Do not assume an undocumented exclusion list or application-consistent database snapshot.
For risky clones, plan quiescing/backup and containment before creation, then inspect before use.
Disk resize is growth to a new total, not an increment; shrinking is not documented.
Before deletion or migration, establish independent, application-consistent backups and a restore plan.
Regional streaming replicas are durability infrastructure, not documented historical/undelete backups.

## 10. Treat Shelley as a privileged administrative agent

Its dedicated URL is `https://<vm>.shelley.exe.xyz/`; default guest port is 9999.
Keep it private: Shelley has no built-in authorization or sandboxing of its own.
Select the correct working directory and inspect personal/project AGENTS guidance.
Inspect installed version and units before proposing upgrades, restarts, or disablement.
Default image generations differ; an upgrade is not an incidental prerequisite to app deployment.
For disablement, inspect both `shelley.service` and `shelley.socket`.
Stopping the service alone can leave socket reactivation possible.
With authorization, stop/disable the installed socket and service as appropriate, then verify both.
Do not declare success just because one service is inactive; see the operations checklist.

Inside a guest, reflection can reveal attached integrations without asking for durable secrets.
Prefer current LLM integrations such as `https://llm.int.exe.xyz` when actually attached.
The legacy metadata LLM gateway is deprecated and unavailable to newer accounts.
For optional user-approved connections, follow Shelley's documented suggestion-link workflow.
Preflight suggestion links, encode one command each, omit credentials, and respect human choice.

## 11. Debug in layers and report evidence

Check guest process/service and local HTTP, then selected port and sharing, then authenticated HTTPS.
Next check framework host/origin restrictions, custom-domain DNS/registration, and Web/Root rights.
For SSH failures inspect key selection, host verification, destination routing, and network access.
For HTTPS API failures distinguish authentication/permission denial from a command-body error.
Do not retry mutations blindly or grant broader permissions to hide a diagnostic failure.
Collect minimal redacted evidence; support Root access is opt-in, never automatic.

Finish with: what changed, target VM, URL/access mode, checks passed, remaining risks, and rollback.
For a dry run, provide a plan and expected checks only; never contact an account or mutate a VM.
Label documentation-based reasoning separately from live verification; do not claim unrun tests passed.
