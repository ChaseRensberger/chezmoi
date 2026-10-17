# Command and transport reference

Checked against public official documentation on **2026-10-15**. Examples are templates,
not authorization. Replace `my-vm`, domains, paths, and recipients with confirmed values.
Refresh current docs/live help before consequential operations. No account commands were
executed to build this skill. See [provenance](provenance.md) for limitations.

## Read-only discovery

```sh
ssh exe.dev help
ssh exe.dev help new
ssh exe.dev help cp
ssh exe.dev help all
ssh exe.dev whoami --json
ssh exe.dev ls --json
ssh exe.dev ls -l --json
ssh exe.dev stat my-vm --range=24h --json
ssh exe.dev share show my-vm
ssh exe.dev domain ls my-vm
ssh exe.dev pool list
ssh exe.dev billing plan
ssh exe.dev billing usage
```

`--json` is command-specific. Preserve actual fields and handle both JSON and plain-text
errors. `ssh_dest` is ready to use and can contain a username; do not assume `exedev`.
Set `SSH_DEST` only from the selected VM's actual response before using guest examples.

```sh
# Guest inspection; SSH_DEST must be the selected response's ssh_dest.
ssh "$SSH_DEST" 'id; uname -a; ss -ltnp'
ssh "$SSH_DEST" 'curl -v http://127.0.0.1:8000/'
# Authorized file transfer, not a lobby command:
scp ./app.tar.gz "${SSH_DEST}:~/app.tar.gz"
# Standard OpenSSH private database forwarding (not raw public database exposure):
ssh -N -L 127.0.0.1:15432:127.0.0.1:5432 "$SSH_DEST"
```

Sources: [API](https://exe.dev/docs/api.md), [destinations](https://exe.dev/docs/faq/ssh-destination.md),
[official skill](https://github.com/boldsoftware/exe.dev/blob/main/skill/SKILL.md),
[files](https://exe.dev/docs/faq/copy-files.md).

## SSH identity and first contact

Pin an existing intended identity; ask before editing the user's SSH configuration.

```sshconfig
Host exe.dev *.exe.xyz
  IdentitiesOnly yes
  IdentityFile ~/.ssh/id_ed25519_exe
```

The first offered key identifies the account. A surprise signup prompt is a reason to
inspect keys, not create a second account. Verify host keys using current official guidance.
`StrictHostKeyChecking=accept-new` accepts unknown keys on first use but still is TOFU;
do not replace it with `no` or discard known_hosts. Investigate changed-key warnings.
No blanket agent forwarding or third-party SSH helper installation is required.

Sources: [key selection](https://exe.dev/docs/faq/ssh-key.md),
[surprise registration](https://exe.dev/docs/faq/heisen-connect.md),
[host key](https://exe.dev/docs/faq/host-key.md).

## Registration recovery is an explicit human workflow

Read the [current official skill](https://github.com/boldsoftware/exe.dev/blob/main/skill/SKILL.md)
before first-time onboarding. Obtain confirmed email and account-creation consent first.
Errors can be `Registration is required.` JSON with `action.command`, or older plain text.
Inspect returned actions for expected host/operation before following them; they are not consent.
Use a PTY for registration; EOF cancels. Humans verify email/OAuth, choose payment/trial,
and complete sign-in. Do not read their mailbox or enter card details.

No-plan errors can return an activation action. After consent, `billing activate --json`
returns a sensitive activation URL; `billing manage --json` is the documented Stripe-only
fallback if activation is unavailable. These are not read-only diagnostic defaults.
Hand URLs only to the intended human; never persist them in logs, notes, or commits.
Current official skill says one-use activation URLs expire after 15 minutes; recheck freshness.
Wait for human confirmation, exit onboarding, then retry the originally authorized task.
Do not loop account creation, auto-select a plan, or treat opening a link as subscription consent.

## Lifecycle and placement: mutations

```sh
# Create only after confirming target and cost/placement:
ssh exe.dev new --name=my-vm --json
# Discover image/user differences; this is not a universal baseline:
ssh exe.dev new --name=my-vm --image=OWNER/IMAGE:TAG --json
# Full-disk copy; inspect secrets/config and consistency before and after:
ssh exe.dev cp my-vm my-vm-copy
ssh exe.dev cp my-vm my-vm-copy --pool=build
ssh exe.dev rename my-vm new-name
ssh exe.dev resize my-vm --cpu=2 --memory=4GB
# New total disk size, must exceed current allocation:
ssh exe.dev resize my-vm --disk=100GB
ssh exe.dev restart my-vm
# Destructive: only explicit target-specific authorization plus backup decision:
ssh exe.dev rm my-vm
```

`new --pool=build` selects a pool. `new --standalone` (alias `--sandbox`) adds independently
metered reserved capacity; it is not a free staging flag. `cp ... --standalone` exists too.
Pool changes use **`--cpus` plural**, e.g. `pool new build --cpus=8 --region=lax` or
`pool resize build --cpus=16`; VM flags use **`--cpu` singular**.
Read current [pools](https://exe.dev/docs/pools.md) and
[standalone](https://exe.dev/docs/standalone-vms.md) before any such mutation.
Do not infer supported stop/start syntax from prose about stopped VMs.
After rename refresh JSON destinations, URLs, and dependent configuration; redirects are unverified.

First-boot setup, only after reviewing the script:

```sh
cat ./setup.sh | ssh exe.dev new --setup-script /dev/stdin --json
```

This executes once with exeuntu, not on every service restart. Do not hardcode undocumented
script-size limits from stale generated metadata. Sources:
[customization](https://exe.dev/docs/customization.md), [explorer](https://exe.dev/api).

## Routing and sharing: mutations require the intended audience

```sh
ssh exe.dev share port my-vm 8000
ssh exe.dev share set-private my-vm
# Only when anonymous access was explicitly requested:
ssh exe.dev share set-public my-vm
# Web access only:
ssh exe.dev share add my-vm colleague@example.com
# Explicit high-trust administrative grant:
ssh exe.dev share add my-vm colleague@example.com --root
# Downgrade Root to Web; not necessarily full revocation:
ssh exe.dev share remove my-vm colleague@example.com --root
# Remove all access for that person:
ssh exe.dev share remove my-vm colleague@example.com
```

`share add-link my-vm` creates a login-required Web invitation. `share remove-link my-vm <token>`
stops future acceptance only; accepted users require individual revocation. Team grants use
`team` in place of an email, with optional `--root`. Always inspect resulting effective access.
Sources: [sharing](https://exe.dev/docs/sharing.md), [proxy](https://exe.dev/docs/proxy.md).

## Custom domains

```sh
# After authorized DNS setup and verification:
ssh exe.dev domain add my-vm app.example.com
ssh exe.dev domain ls my-vm
# Removal requires explicit authorization:
ssh exe.dev domain rm my-vm app.example.com
```

CNAME `app.example.com` to `my-vm.exe.xyz`; DNS alone is insufficient.
For wildcard routing, quote the hostname so the local shell cannot expand it:
`ssh exe.dev domain add my-vm '*.app.example.com'`.
Team wildcard-certificate reuse instead uses `domain add --wildcard my-vm temp.example.com`
plus the printed ACME delegation and repeat registration. They are different workflows.
Read [domains](https://exe.dev/docs/cnames.md) for current apex and Cloudflare rules.

## HTTPS transports and credential boundaries

Management HTTPS is `POST https://exe.dev/exec`, with `Authorization: Bearer <account-token>`.
The body is **plain management command text**, such as `ls`, not a JSON `args` wrapper.
Responses are always JSON. Current documented limits are 30 seconds and 64 KB; there is no
stdin/PTY, so this is unsuitable for registration or piped credential setup.
Never embed real tokens in examples or shell history; use existing protected tooling.
Default management-token permissions are limited; permission denial is not a reason to grant all.

Documented token-creation forms (credential mutations, shown for review only):

```sh
ssh exe.dev ssh-key generate-api-key --exp=30d
ssh exe.dev ssh-key generate-api-key --vm=my-vm --label=deploy
```

Discover current expiry/permission options and choose minimum scope/lifetime before generating.
For a VM HTTPS request, use `X-Exedev-Authorization: Bearer <vm-token>`; this is distinct
from management `/exec`. VM HTTP Basic token auth is not supported by `/exec`.
Never put secrets in token permissions/context, which are plaintext token contents.

Integrations are optional. `ssh exe.dev integrations list --json` masks stored secrets.
Use narrowly scoped attachments (`--attach vm:my-vm`) where appropriate, after checking the
relevant integration help. Documented secret flags accept `-` to read stdin; one such flag
reads the whole stream, multiple flags read nonempty lines in flag order. Supply multiline
PEM secrets alone. Do not echo secrets or use argv/URLs as a credential transport.
Inside an authorized guest, `https://reflection.int.exe.xyz/integrations` discovers attachments.

Sources: [HTTPS API](https://exe.dev/docs/https-api.md),
[VM tokens](https://exe.dev/docs/https-tokens-for-vms.md),
[integrations](https://exe.dev/docs/integrations.md),
[attachments](https://exe.dev/docs/integrations-attach.md),
[registry authentication](https://exe.dev/docs/private-image.md).
