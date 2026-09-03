---
name: kickstart-prototype-rails-app
description: Bootstrap a small, working Rails prototype with Loop Labs defaults: Hotwire, SQLite, expressive dependency-free CSS, optional Honeybadger and Resend integrations, and a first interactive homepage feature. Use when creating a new Rails app from scratch that should run locally now and be ready for a later Hetzner/Kamal graduation.
---

# Kickstart Prototype Rails App

Create a complete, inspectable Rails app in one pass. Prefer Rails defaults and native capabilities over starter kits, frontend frameworks, or new services.

## Run the setup wizard

Before creating files, ask for the app name and one-sentence purpose, then decide each optional integration explicitly:

- Is error tracking relevant? If yes, ask for the Honeybadger API key.
- Will the app send production email? If yes, use Resend; ask for its API key and a sender address on a verified Resend domain.
- Is a Cloudflare tunnel or public hostname needed now? If yes, collect the requested hostname and access level.
- Is the app intentionally open source? Default to no. This controls both the GitHub repository and production container-image visibility.

Ask for keys through the client's secret-safe input surface, then write them directly to the app's 1Password environment. Do not accept, echo, save, or report a key in ordinary chat, source files, shell history, or terminal output. If a required key is unavailable, leave that integration unconfigured and name it as pending in the final report.

## Collect the project input

Obtain the app name and a one-sentence purpose. Treat the repository name as the app's kebab-case name unless the caller supplies one. Use `~/code/github/<repo-name>` by default; accept an explicit target directory.

Ask before overwriting a non-empty target directory. Do not ask for access that can be detected: inspect the authenticated GitHub, 1Password, Honeybadger, Resend, and Cloudflare clients first.

## Build the app

1. Create a new Rails 8.1 application using its defaults: Hotwire and Stimulus, Importmap, SQLite, Solid Queue/Cache/Cable, Minitest, Thruster, the Rails logger, and the standard production Dockerfile. Do not add React, Vue, Inertia, a SaaS starter, a CSS framework, or a second observability/logging service.
2. Give the homepage one small, original, game-like interaction inspired by the app's name and purpose. Keep it server-rendered; use Turbo and a small Stimulus controller only where browser-local interaction benefits. Avoid product-sized features, external APIs, and dependencies.
3. Replace the stock styling with a dependency-free Loop Labs baseline. Use CSS custom properties, system/fallback typefaces, expressive colour, CSS-made texture, responsive layout, visible focus states, and contrast that meets accessibility basics. Allow ordinary app CSS to override it, and honor an explicit request for a complete redesign.
4. Add the smallest tests that prove the homepage and its interaction work. Run the focused tests and the normal Rails test suite.

## Configure operations

### GitHub

When an authenticated GitHub client is available, initialize the repository, create the remote under that authenticated identity, set the default branch, push the initial commit, and record the remote in the final report. Create the repository as private unless the caller explicitly says the app is open source. Otherwise initialize local Git and name GitHub setup as pending.

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

## Verify and hand off

Run the app, tests, and production build/boot checks appropriate to the available environment. Create an initial commit containing the Rails app, homepage feature, visual baseline, tests, and safe operational configuration.

Finish with a compact report that separates:

- verified local behavior;
- GitHub repository and production-image visibility, including the anonymous registry check;
- created GitHub, Honeybadger, Resend, 1Password, and Cloudflare resources;
- pending or failed external wiring and its recovery step;
- any hostname or access policy requested;
- the app's readiness for later Hetzner/Kamal deployment.

Do not deploy to production, make risky migrations, change credentials or permissions beyond the requested app setup, or bypass a human approval gate.
