# Product analytics platform decision

- Reviewed: 2026-08-29
- Scope: one reusable default for public websites, authenticated web apps, backends, and potential native or cross-platform mobile clients
- Evidence: current first-party product documentation only

## Decision

Use **PostHog Cloud** as the Loop Labs default when a project has not already selected an analytics provider.

PostHog has official or documented SDKs for JavaScript web, Android, iOS, Flutter, React Native, Ruby, Node.js, Python, Go, PHP, and other common runtimes. Its SDK comparison covers event capture, identity, autocapture, session recording, feature flags, group analytics, and error tracking by library. Server libraries deliberately do not autocapture or record sessions, which reinforces the correct split between client behavior and authoritative backend outcomes ([SDK comparison](https://posthog.com/docs/libraries)).

The browser SDK supports identity, replay, feature flags, surveys, experiments, error tracking, opt-out controls, and tracking a journey across a marketing site and application. It lazy-loads optional capabilities and also offers an experimental slim bundle for projects that need tighter control over client weight ([JavaScript SDK](https://posthog.com/docs/libraries/js)). The Ruby SDK supplies Rails-compatible backend capture and feature-flag evaluation for successful server-side outcomes ([Ruby SDK](https://posthog.com/docs/libraries/ruby)).

PostHog documents native Android, iOS, React Native, and Flutter SDKs. React Native currently exposes lifecycle capture, offline behavior, feature flags, experiments, error and crash tracking, session replay, surveys, and tracing headers that can connect frontend activity to backend events. Android likewise supports queued offline capture, screen tracking, flags, experiments, error tracking, replay, and event filtering ([React Native SDK](https://posthog.com/docs/libraries/react-native), [Android SDK](https://posthog.com/docs/libraries/android), [iOS SDK](https://posthog.com/docs/libraries/ios), [Flutter SDK](https://posthog.com/docs/libraries/flutter), [mobile replay](https://posthog.com/docs/session-replay/mobile)). Feature parity is not exact: for example, some survey targeting differs on React Native and native Android survey UI remains experimental.

The current free allowances include one million analytics events, 5,000 session recordings, and one million feature-flag requests per month. A free project has one-year retention, one project, and unlimited team members; collection stops at the free limit unless billing is enabled ([pricing](https://posthog.com/pricing)).

Use Cloud for production. PostHog's own self-hosting disclaimer describes the open-source deployment as a hobby instance with limited support and fewer capabilities, not the production-default equivalent of PostHog Cloud ([self-hosting disclaimer](https://github.com/PostHog/posthog.com/blob/master/contents/docs/self-host/open-source/disclaimer.mdx)). Raw product data can be batch-exported to BigQuery when warehouse ownership becomes necessary ([BigQuery export](https://posthog.com/docs/cdp/batch-exports/bigquery)).

## Agent operability

PostHog remains the default when agent friendliness is part of the requirement. Its official hosted MCP server explicitly supports Codex, Claude Code, Cursor, VS Code, and other MCP clients. Agents can read and write across product analytics, HogQL/SQL, dashboards, replay, error tracking, feature flags, experiments, surveys, CDP, support, and other product surfaces. PostHog also maintains a CLI designed for coding agents and an official AI plugin with task-specific skills ([MCP overview](https://posthog.com/docs/model-context-protocol), [tool reference](https://posthog.com/docs/model-context-protocol/tools), [CLI](https://posthog.com/docs/cli), [AI plugin](https://github.com/PostHog/ai-plugin)).

The hosted MCP has unusually practical safety and context controls. A connection can be pinned to one organization or project, made read-only, filtered by product category or exact tool name, and run in a token-optimized CLI mode that discovers hundreds of tools on demand rather than loading every schema into the prompt. OAuth is the default, while a project-scoped MCP Server API-key preset is available for non-OAuth clients. PostHog warns that write access remains vulnerable to prompt injection and should be reviewed ([MCP safety and scoping](https://posthog.com/docs/model-context-protocol/faq)).

**Amplitude is the strongest agent-first challenger.** Its official OAuth MCP can query analytics and replays, inspect users and taxonomy, and create or edit charts, dashboards, notebooks, cohorts, experiments, flags, metrics, and tracking-plan branches. It has progressive tool discovery, explicit write RBAC, an official plugin marketplace, and machine-oriented documentation via `llms.txt` and Markdown responses. For a mature analytics organization whose agents mainly govern taxonomy and analysis, Amplitude may be the better choice ([Amplitude MCP](https://amplitude.com/docs/amplitude-ai/amplitude-mcp), [common MCP tasks](https://amplitude.com/docs/amplitude-ai/amplitude-mcp/common-tasks)). PostHog still wins for Loop Labs' broader requirement because the same agent surface spans Rails-supported instrumentation, product analysis, feature delivery, replay, errors, and potential mobile clients.

Mixpanel's official MCP can query behavior, build dashboards, manage Lexicon, launch experiments, and inspect replay, while inheriting Mixpanel's governance. It launched in 2026 and is less proven and less completely documented as an agent-control surface than the PostHog and Amplitude offerings ([Mixpanel MCP](https://mixpanel.com/ai/mcp), [launch announcement](https://mixpanel.com/blog/mixpanel-mcp-server/)). Google's official Analytics MCP is read-only, so it is useful for questions but not a general agent-operated product loop ([Google Analytics MCP](https://developers.google.com/analytics/devguides/MCP)).

Use the direct PostHog MCP connection first. The optional AI plugin bundles additional hooks and many vendor skills; that surface should not be added automatically to a shared Loop Labs skill environment. As of this review, the plugin's official issue tracker also contains an open Codex Desktop OAuth callback report, so verify that path before depending on it rather than assuming the plugin is required ([plugin issue](https://github.com/PostHog/ai-plugin/issues/183)).

## Why not make GA4 the default?

GA4 remains the stronger acquisition companion when Google Ads, Search Console, cross-channel attribution, or raw BigQuery export is the main need. It supports websites and apps, events, key events, and funnel exploration, but it does not replace PostHog's combined product analytics, replay, flags, experiments, surveys, and engineering context ([GA4 overview](https://marketingplatform.google.com/about/analytics/), [key events](https://support.google.com/analytics/answer/9267568), [funnels](https://support.google.com/analytics/answer/9327974), [Search Console](https://support.google.com/analytics/answer/10737381)). Add it to public acquisition surfaces only when those Google-specific strengths justify a second event schema and tracker.

## Closest alternatives

| Platform | Prefer it when | Why it is not the default |
|---|---|---|
| **Amplitude** | The team already uses it or needs its enterprise analysis and activation workflows | The free plan currently includes two million monthly events and one year of analytics history, but Ruby product events use its HTTP API, Flutter replay remains Early Access, and Amplitude is not a first-class error tracker ([pricing](https://amplitude.com/pricing), [HTTP API](https://amplitude.com/docs/apis/analytics/http-api-quickstart), [Flutter replay](https://www.amplitude.com/docs/sdks/session-replay/session-replay-flutter-standalone-sdk)) |
| **Mixpanel** | A product team prioritizes polished funnels, retention, flows, and cohorts over an integrated engineering toolkit | The free plan currently includes one million events, 10,000 replays, ten flags, and experiments for 1,000 monthly evaluated users, but only five saved reports per seat and 30-day replay retention; it lacks first-class surveys and error tracking ([SDKs](https://docs.mixpanel.com/docs/tracking-methods/sdks), [pricing](https://mixpanel.com/pricing/)) |
| **Heap** | Retroactive autocapture is the overriding requirement and explicit event design is not yet possible | Autocapture does not remove the need for backend outcome events, and the current free history and advanced-feature limits are less attractive ([pricing](https://www.heap.io/pricing)) |
| **Microsoft Clarity** | A site needs a free replay and heatmap companion | Excellent qualitative evidence, but not the shared web/mobile/server product event system ([Clarity](https://clarity.microsoft.com/)) |

When a native mobile product needs dedicated crash and performance diagnostics, Firebase Crashlytics and Performance Monitoring are reasonable no-cost companions. Keep PostHog as the sole behavioral event source rather than dual-writing product events to Firebase Analytics; otherwise the two systems will disagree about users and sessions. Firebase documents native Analytics, Crashlytics, Performance Monitoring, and BigQuery exports, but it is not the same cross-web/mobile product workflow and has no first-party React Native SDK ([Firebase pricing](https://firebase.google.com/pricing), [BigQuery exports](https://firebase.google.com/docs/projects/bigquery-export)).

## Reconsider the default when

- the project already has reliable instrumentation and historical continuity in another provider;
- Google Ads or Search Console attribution is the primary business requirement;
- a regulated deployment, data-residency constraint, or offline environment rules out the available cloud regions;
- exact mobile capability parity for a required feature is missing; or
- measured event volume makes another platform materially simpler or cheaper.

Do not switch providers on feature-list preference alone. Require a concrete product question, runtime constraint, or total-cost difference that the current platform cannot reasonably satisfy.
