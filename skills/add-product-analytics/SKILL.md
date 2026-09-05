---
name: add-product-analytics
description: Add or improve product analytics for web and mobile applications, defaulting to PostHog when the project has no chosen provider. Use when instrumenting page or screen views, funnels, conversions, attribution, identity, session replay, feature flags, experiments, surveys, or a shared analytics event contract; do not use for infrastructure monitoring alone.
---

# Add Product Analytics

Build a small, trustworthy measurement system that can follow one product across its public website, authenticated web app, backend, and later mobile clients. Optimize for decisions the team will actually make, not maximum event volume.

## Select the platform

Honor an explicit provider choice. When a project already has a working analytics provider, improve it instead of migrating unless the user requests a migration.

When neither condition applies, use **PostHog Cloud** as the Loop Labs default. It provides one event model across browser, server, React Native, iOS, Android, Flutter, and other supported SDKs, with product and web analytics, replay, feature flags, experiments, surveys, and error tracking available in the same platform.

Do not add a second behavioral analytics suite by default. Add GA4 only when Google Ads, Search Console, or marketing attribution is a concrete requirement that PostHog does not satisfy. Add a replay-only tool only when the chosen analytics provider lacks adequate qualitative evidence.

Read [the platform decision](references/platform-decision.md) when the user asks for a comparison, mobile coverage is decisive, or project constraints may justify something other than PostHog.

When the browser needs only a few explicit events and strict control over payload size and properties matters more than sessions or optional products, read [the minimal PostHog capture guide](references/posthog-minimal-capture.md). Do not load the full browser SDK by reflex.

## Give agents bounded access

When the user wants agents to analyze or manage the resulting product data, prefer PostHog's hosted MCP endpoint over browser automation or a custom API wrapper. MCP is for querying and managing PostHog; keep production event ingestion in application instrumentation—not MCP—using the selected SDK or a qualifying minimal browser adapter.

Start with one project-pinned, read-only connection. Expose only the capabilities needed for the task, such as schema, events, SQL, insights, dashboards, replay, or error tracking. Use PostHog's token-optimized CLI mode for clients such as Codex and Claude Code rather than loading hundreds of tool schemas into every conversation.

Treat tool filtering as context and accident reduction, not the authorization boundary. For unattended use, give the agent a dedicated, project-scoped identity with minimum API scopes. Enable write tools only for an explicit workflow, and require the user's confirmation for launches, targeting changes, publications, and destructive actions. A dashboard-building agent does not need flag, survey, billing, support-ticket, or deletion tools.

Do not install the full PostHog AI plugin merely to obtain MCP access; add its extra hooks and bundled vendor skills only when the user requests those capabilities.

## Inspect before instrumenting

Determine:

- the decisions analytics must inform and the primary conversion or activation outcome;
- the public web, authenticated web, backend, and mobile surfaces currently in scope;
- the authentication lifecycle and stable internal identity available on every client;
- the router or navigation lifecycle, including Turbo, SPA history, and native screen transitions;
- any existing MCP, CLI, agent plugin, or analytics credentials and their current scope;
- existing analytics, consent, secret management, content security policy, and data-filtering behavior; and
- the smallest official SDK for each active runtime, or whether the browser qualifies for the minimal direct-capture mode.

Do not provision a vendor account, create a cloud project, accept terms, or enable billing without the user's authorization. If account access or a project token is unavailable, implement only provider-neutral contracts and name the blocked wiring.

## Define the measurement contract

Write the short measurement plan in the project before scattering calls through the code. Reuse an existing analytics or product document when one exists. Include:

1. the question each funnel or metric answers;
2. the semantic events and their owners;
3. the allowed properties and value types;
4. which runtime emits each event; and
5. an observable acceptance check.

Use lowercase `snake_case` event names. Prefer completed outcomes such as `account_created`, `onboarding_completed`, `subscription_started`, and `project_published`. Treat button clicks as interaction evidence, not conversions.

Keep one shared taxonomy across web, backend, iOS, Android, React Native, and Flutter. Platform belongs in a property supplied by the SDK, not in parallel names such as `ios_signup` and `web_signup`.

Use a small property allowlist. Prefer bounded values such as `plan`, `placement`, `method`, `source`, and `result`. Do not send arbitrary payloads, form contents, tokens, authorization data, raw query strings, private page titles, or unbounded user-generated text.

## Implement at the authoritative seam

Use the official SDK for each active runtime and the deployment region's matching ingestion host, except when the browser qualifies for the deliberately limited direct-capture mode above.

- Let the browser adapter or client SDK report page or screen views and deliberate UI interactions. Capture referrers or campaign parameters only when the measurement contract explicitly allows them.
- Emit registrations, purchases, enrollments, publications, and other state changes from the backend only after the database transaction succeeds.
- Never emit the same semantic outcome independently from both client and server. If a multi-runtime flow makes that unavoidable, assign and test one stable deduplication key.
- Do not depend exclusively on autocapture. Use it for discovery and low-value interaction context while keeping important outcomes explicit and stable.
- Do not enable replay, surveys, flags, experiments, error tracking, or logs merely because PostHog includes them. Add each capability only when it answers an active product or engineering question.
- Keep an existing stack-native error tracker unless the user explicitly requests a migration. In a Rails application, Honeybadger can remain the sole error and operational tracker while PostHog owns product analytics; do not double-report exceptions by default.

For web navigation, verify one page view per completed navigation. Turbo and client routers can produce missing or duplicate views when both automatic history capture and application hooks fire.

For mobile navigation, use normalized screen names rather than class names containing IDs. Verify cold start, foreground/background transitions, offline queuing, deep links, and retries without inflating sessions or conversions.

## Join identities only when necessary

Start visitors anonymously. Identify them after authentication only when a named analysis requires cross-device, retention, or lifecycle joins. Use one stable opaque application or authentication ID shared by every client and the backend; never use an email address, display name, device ID, or mutable profile field as the distinct ID.

When aggregate page, interaction, and outcome counts answer the question, keep browser activity anonymous and backend outcomes personless. State that these events do not form a user-level funnel rather than quietly introducing identity.

When identity joining is enabled, call the selected client integration's reset operation on logout or account switching. Test that anonymous pre-auth activity merges into the intended signed-in person and that the next user on a shared device does not inherit the prior identity.

Attach person properties only when a named analysis needs them. Use group analytics for an organization, workspace, or account only when the product makes decisions at that level.

## Protect the signal and the user

Treat analytics as an external data boundary even when privacy is not the selection criterion.

- Configure replay masking before enabling replay; exclude credentials, payment fields, private messages, health or financial content, and administration screens.
- Filter query strings and dynamic route identifiers before capture.
- Suppress unwanted referrer data at both layers: omit referrer properties and configure the browser request with `referrerPolicy: "no-referrer"`. Omitting cookies or credentials does not suppress the HTTP `Referer` header.
- Configure client-visible project tokens and ingestion hosts through the project's established runtime or build configuration; these values necessarily ship in browser and mobile clients. Keep personal and server API keys in the secret manager, and never place those secrets in source, prompts, logs, test fixtures, or final reports.
- Respect the application's consent and opt-out state consistently on every client.
- Disable or clearly separate local, test, staging, synthetic-monitoring, and staff traffic from production analysis.
- Keep cardinality bounded; do not turn record IDs, timestamps, stack traces, or full URLs into event or property names.

## Verify end to end

Use the provider's debug or live-events view and inspect actual outbound payloads. Prove:

- one page or screen event per navigation;
- explicit events contain only allowed properties;
- failed validation and rolled-back transactions do not produce conversions;
- a successful outcome appears once and enters the intended funnel;
- when identity joining is enabled, anonymous-to-known joining and logout reset behave correctly;
- when replay is enabled, masking and excluded surfaces hold on real rendered content;
- when mobile capture is enabled, events survive an offline/online cycle without duplication; and
- development and automated tests do not contaminate production data.

Verify the browser is executing the currently served asset, not merely that the source file is correct. When observed behavior contradicts the source, inspect the resolved asset and clear stale generated build artifacts before drawing conclusions.

Run the project's focused and normal checks for the integration code. Finish with the provider and region, installed SDKs, event contract, verified funnels, enabled optional capabilities, data exclusions, account-side steps still required, and direct links to any dashboard the user authorized you to create.
