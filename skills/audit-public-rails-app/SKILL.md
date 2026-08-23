---
name: audit-public-rails-app
description: Audit a public Rails production app without leaking secrets, PII, or infrastructure details, and safely triage Dependabot PRs when explicitly authorized. Use when running scheduled or manual operational, security, privacy, and dependency-maintenance sweeps; do not use for feature development.
---

# Audit a Public Rails App

> Adapted from Rails Builders' [production operations audit skill](https://github.com/RichStone/rails.builders/blob/046d8dc8fc01ac19a9e820356b27ca8ed13371e2/.agents/skills/rails-builders-ops-audit/SKILL.md). See the [source notice](../../LICENSES/rails-builders-ops-audit-NOTICE.md).

Determine whether a public Rails app is healthy without leaking private application, customer, or infrastructure data. Treat commits, pull requests, CI logs, and repository files as public.

## Establish the application profile

Read the repository's deployment configuration and operational documentation before checking production. Identify only what is needed:

- public domains and health endpoint;
- default branch, CI workflow, and deployment mechanism;
- database and queue topology;
- error monitoring, host, and backup providers;
- expected externally reachable services.

Do not hardcode a provider or topology. Mark undiscoverable checks unavailable rather than guessing or exposing configuration values.

## Enforce the public-repository boundary

Treat all non-public data as sensitive, including credentials, environment values, provider and account identifiers, host addresses, user records, names, email addresses, IDs, membership state, request data, authentication events, and error payloads.

- Never print, paste, commit, upload, or put sensitive values in commands, URLs, branch names, commit messages, PR text, CI annotations, screenshots, or audit reports.
- Never use broad-output commands such as `env`, `printenv`, unrestricted container inspection, raw database dumps, user-table queries, or unfiltered production logs.
- Read secrets only through existing ignored configuration, credential stores, or provider integrations. Test presence or behavior without echoing values.
- Query production databases only for schema state, integrity checks, and aggregate operational counts. Never inspect application rows.
- Reduce authentication logs to counts and trends. Never show source IPs, attempted usernames, request paths, headers, or payloads.
- Reduce monitoring and provider results to status, counts, severity, and the smallest safe next action. Do not reproduce stack traces, request context, user context, or provider identifiers.
- Keep temporary artifacts outside the repository and remove them when finished. Before a commit or push, inspect the exact staged diff for secrets, PII, internal addresses, and raw logs.

If a check cannot be performed safely, skip it and report only that it was unavailable.

## Preserve authorization and local work

The audit is read-only by default. The skill does not authorize deploys, reboots, installations, credentials, account changes, network changes, provider mutations, code edits, PR updates, or merges.

Start with `git status --short --branch`. Never reset, clean, stash, overwrite, or commit unrelated work. Use a temporary worktree from the remote PR head when dependency verification needs a checkout and the current workspace is dirty.

## Audit production

Collect the minimum evidence required to determine status:

1. Verify the public homepage, health endpoint, TLS, and expected redirects.
2. Confirm the deployed version matches the latest green default-branch SHA and inspect the latest CI/deploy result.
3. When host access is authorized, check failed services, pending reboot and security updates, disk pressure, and memory pressure.
4. Confirm the effective SSH policy remains key-only and report failed-authentication counts and trend only.
5. Check external exposure and report only whether expected web and SSH access changed.
6. Run the datastore's native read-only integrity check. For multi-database Rails SQLite, check every configured database with `PRAGMA quick_check` and report only one status per database.
7. Report aggregate failed-job and recurring-task counts for the configured queue backend.
8. When authenticated access is available, check error-monitoring health, unresolved-error count, backup status, and deletion protection without copying private details.

A failed health check, integrity failure, unexpected network exposure, or failed deployment is a stop condition. Do not repair findings or mutate dependencies; report the smallest next action.

## Sweep Dependabot only when authorized

Dependabot branch updates and merges are allowed only when the current request or scheduled-task prompt explicitly authorizes them. Then consider only open PRs authored by `app/dependabot`.

- Automatically handle patch updates and minor updates whose current major version is at least 1.
- Require the candidate to include the current default branch and pass fresh CI.
- Inspect the exact diff and primary release notes. Accept only expected dependency or action-version files.
- Do not merge major updates, pre-1.0 minor updates, breaking notices, security-sensitive or ambiguous updates, framework or toolchain jumps, migrations, configuration or environment changes, unexpected files, or failed checks.
- Do not hand-edit Dependabot branches or bypass checks.
- Squash-merge one candidate at a time, at most three per sweep.
- After each merge, wait for default-branch CI and its automatic deployment. Verify the public health endpoint and deployed SHA before considering another PR. Stop on the first failure; never manually deploy as a workaround.

## Report

Return a concise private summary of overall health, sanitized check results, prioritized findings, Dependabot actions or safe skip reasons, unavailable checks, and the smallest next action.

Keep an all-clear short. Never include raw command output, raw logs, secrets, PII, internal addresses, or provider and account identifiers.
