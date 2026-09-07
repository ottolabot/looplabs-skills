---
name: kickstart-prototype-rails-app
description: Bootstrap a small, working Rails prototype with Loop Labs defaults: Hotwire, SQLite, expressive dependency-free CSS, isolated git worktrees, optional integrations, an optional scoped Slack collaborator, and a first interactive homepage feature. Use when creating a new Rails app from scratch that should run locally now and be ready for a later Hetzner/Kamal graduation.
---

# Kickstart Prototype Rails App

Create a complete, inspectable Rails app in one pass. Prefer Rails defaults and native capabilities over starter kits, frontend frameworks, or new services.

## Run the setup wizard

Before creating files, ask for the app name and one-sentence purpose, then decide each optional integration explicitly:

- Is error tracking relevant? If yes, ask for the Honeybadger API key.
- Will the app send production email? If yes, use Resend; ask for its API key and a sender address on a verified Resend domain.
- Is a Cloudflare tunnel or public hostname needed now? If yes, collect the requested hostname and access level.
- Is the app intentionally open source? Default to no. This controls both the GitHub repository and production container-image visibility.
- Should the app have an agentic collaborator? If yes, collect its runtime, identity, dedicated Slack channel name, channel access, and the work it may perform.

Ask for keys through the client's secret-safe input surface, then write them directly to the app's 1Password environment. Do not accept, echo, save, or report a key in ordinary chat, source files, shell history, or terminal output. If a required key is unavailable, leave that integration unconfigured and name it as pending in the final report.

## Collect the project input

Obtain the app name and a one-sentence purpose. Treat the repository name as the app's kebab-case name unless the caller supplies one. Use `~/code/github/<repo-name>` by default; accept an explicit target directory.

Ask before overwriting a non-empty target directory. Do not ask for access that can be detected: inspect the authenticated GitHub, 1Password, Honeybadger, Resend, and Cloudflare clients first.

## Build the app

1. Create a new Rails 8.1 application using its defaults: Hotwire and Stimulus, Importmap, SQLite, Solid Queue/Cache/Cable, Minitest, Thruster, the Rails logger, and the standard production Dockerfile. Do not add React, Vue, Inertia, a SaaS starter, a CSS framework, or a second observability/logging service.
2. Give the homepage one small, original, game-like interaction inspired by the app's name and purpose. Keep it server-rendered; use Turbo and a small Stimulus controller only where browser-local interaction benefits. Avoid product-sized features, external APIs, and dependencies.
3. Replace the stock styling with a dependency-free Loop Labs baseline. Use CSS custom properties, system/fallback typefaces, expressive colour, CSS-made texture, responsive layout, visible focus states, and contrast that meets accessibility basics. Allow ordinary app CSS to override it, and honor an explicit request for a complete redesign.
4. Add first-class worktree support as described below.
5. Add the smallest tests that prove the homepage and its interaction work. Run the focused tests and the normal Rails test suite.

### Worktrees

Generate an executable `bin/worktree` helper with `new`, `setup`, `start`, and `url` commands. Keep it short, readable shell and use only Git, Ruby/Rails, and tools already required by the app.

- `new <name>` creates a sibling Git worktree on a new branch, then runs `setup` inside it.
- `setup` gives that checkout an available loopback port, records it in a worktree-local ignored environment file, installs dependencies as needed, and runs `bin/rails db:prepare`.
- `start` loads the worktree-local environment and starts `bin/dev`; `url` prints its localhost URL.

Every worktree must have a distinct localhost port. Keep all development SQLite databases, Solid Queue/Cache/Cable state, uploads, logs, and temporary files inside that worktree's own ignored Rails directories; do not point any development state at a shared path. Add the local worktree environment file to `.gitignore` and leave production configuration untouched.

Prove the helper once by creating a disposable worktree, bootstrapping it, and confirming its URL differs from the main checkout. Remove the disposable worktree afterward.

## Configure operations

### GitHub

When an authenticated GitHub client is available, initialize the repository, create the remote under that authenticated identity, set the default branch, push the initial commit, and record the remote in the final report. Create the repository as private unless the caller explicitly says the app is open source. Otherwise initialize local Git and name GitHub setup as pending.

Make GitHub Actions the default CI. Add a minimal workflow that runs the Rails test suite on pull requests and changes to the default branch. Keep it readable, use the project's native Ruby/Bundler setup, and do not introduce a second CI provider.

### Project collaborator

When the wizard enables a collaborator, provision it step by step:

1. Create its dedicated Slack channel, private by default, using the requested name. Add only the project’s intended people and the collaborator. Do not connect it to broad workspace channels or bot-free spaces.
2. Inspect the selected runtime’s existing profile conventions, then create one separate profile for this project. Scope its Slack access to that channel and its filesystem/tool access to the project. Do not reuse a global profile or give it unrestricted vault access.
3. Create a committed, non-secret project knowledge file at `docs/agent-context.md`. Include the app purpose, repository and local path, development command, preview host if any, relevant integrations, permitted actions, required human approvals, and the collaborator’s Slack channel. Keep credentials, API keys, and private user data out of it.
4. Configure the profile to load that knowledge file and the Loop Labs skills. Verify the collaborator can read the project context and respond in its dedicated channel, then post a short onboarding message describing its project scope and approval limits.

For example, to add **Otto Labbot** running on **Hermes**, create a private `#app-<repo-name>` channel, then create an Otto Labbot profile in Hermes following the host’s existing profile format. Give it only that channel, the new app repository, and `docs/agent-context.md`; allow it to route and assist with project work, but not to access unrelated apps, unrestricted 1Password data, or production deployment without human approval.

### Honeybadger and 1Password

When error tracking is relevant, use Honeybadger as the only external observability integration. Create or select the app's Honeybadger project and a per-app 1Password environment, then wire its API key into the app through scoped `op run` usage or that environment.

Keep the Rails logger and request IDs. Configure Honeybadger context only for useful structured values such as app, environment, commit, channel, and request ID. Filter credentials, authorization headers, cookies, tokens, personal data, and request bodies before data leaves the process.

Never put a secret in Git, source files, terminal transcripts, the final report, or an agent prompt. If provisioning is not authenticated or fails, finish the independent app setup and report the exact unresolved integration without pretending it is connected.

### Email

When production email is relevant, configure Resend as the production Action Mailer delivery provider using its API key from the app's 1Password environment. Set the production sender from the wizard input; it must use a verified Resend domain. Add `letter_opener` only to the development group and configure local delivery to open mail rather than send it.

Do not add a mailer or send a real message solely to prove the integration. Verify configuration and, when a mailer exists, cover its local delivery behavior without using production credentials.

### Local preview and Cloudflare

Start and verify the app locally. Do not create a Cloudflare Tunnel, DNS record, Access policy, or public hostname unless the caller explicitly requests a tunnel or public exposure. When requested and authenticated, create the tunnel and hostname, configure Cloudflare Access by default, and make public access only when the caller explicitly asked for it.

Use one process and one tunnel per app. Verify the requested external URL before reporting it ready.

## Preserve the graduation path

Keep the generated Dockerfile, `/up` health endpoint, production asset setup, and environment-driven configuration working. Do not create Kamal deployment configuration, provision Hetzner, or deploy production during bootstrap. A later explicit graduation can use Kamal on Hetzner and replace SQLite with Postgres only when the app needs multi-instance operation, stronger backups, or shared production data.

During that production graduation, create the container registry repository before the first image push and make it private unless the app was explicitly declared open source. Do not rely on a first `docker push` to create the repository with the namespace default. Before launch, verify an anonymous manifest request or pull is denied while the authenticated Kamal deployment can still pull the image.

When production is established, extend GitHub Actions—not another CI system—so a successful default-branch workflow deploys through Kamal. Put the deploy job behind a protected production environment and require its human approval. Store deployment secrets only in 1Password or GitHub environment secrets; never place them in the workflow or repository.

## Verify and hand off

Run the app, tests, and production build/boot checks appropriate to the available environment. Create an initial commit containing the Rails app, homepage feature, visual baseline, tests, and safe operational configuration.

Finish with a compact report that separates:

- verified local behavior;
- GitHub repository and production-image visibility, including the anonymous registry check;
- GitHub Actions test and, when applicable, production-deploy status;
- collaborator channel, runtime profile, and project knowledge status;
- main checkout URL and the generated `bin/worktree` commands;
- created GitHub, Honeybadger, Resend, 1Password, and Cloudflare resources;
- pending or failed external wiring and its recovery step;
- any hostname or access policy requested;
- the app's readiness for later Hetzner/Kamal deployment.

Do not deploy to production, make risky migrations, change credentials or permissions beyond the requested app setup, or bypass a human approval gate.
