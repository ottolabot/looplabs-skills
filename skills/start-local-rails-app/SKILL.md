---
name: start-local-rails-app
description: Build or extend a small Rails app that runs locally with SQLite and local files. Use when the user asks for a personal tracker, internal utility, or other low-impact local app without hosting or external services.
---

# Start a Local Rails App

Deliver a useful app the user can start on their own machine. Keep the Rails conventions
that reduce maintenance, and choose infrastructure in proportion to a single-user tool.

## Set the boundary

- Honor the requested app name, location, data model, and supplied design references.
- Inspect the destination and applicable repository instructions before generating files.
  Extend an existing Rails app in place; create a new app in its own empty directory.
- Use an installed, compatible Ruby and stable Rails version. Pin Ruby in `.ruby-version`
  and dependencies in `Gemfile.lock`; do not change the machine's global Ruby selection.
- Treat local operation as the default: no hosting, cloud storage, analytics, telemetry,
  error-tracking service, transactional email, external CI, payment service, or tunnel.
  Do not create service accounts or placeholder API keys for hypothetical later needs.
  Add an integration only when the user requests it or it is necessary to the stated task.
- When a supplied style guide describes a hosted site, reuse its relevant visual language
  without inheriting its deployment, tracking, signup, or SDK infrastructure. Keep private
  account identifiers and credentials out of generated public assets.

## Start with Rails

Prefer ERB, ordinary controllers and Active Record, Turbo/Stimulus, importmap, Propshaft,
SQLite, and local CSS. Use Tailwind when the user requests it or the existing app already
uses it. Keep Minitest for a new app unless project conventions call for another framework.
Do not add Node, Redis, PostgreSQL, containers, or separate workers without a concrete need.

Check `rails new --help` for the installed version before using generator flags. For a
Rails 8.1 app, a suitable starting command is:

```sh
rails new app_name --database=sqlite3 --javascript=importmap --no-rc \
  --skip-kamal --skip-docker --skip-thruster --skip-ci --skip-solid \
  --skip-action-mailer --skip-action-mailbox --skip-action-text \
  --skip-action-cable --skip-jbuilder
```

Replace `app_name` with the chosen directory. Keep Active Storage when the app needs
attachments and Active Job for its built-in support. Use the in-process job adapter for
small local work; omit durable job infrastructure until a task must survive restarts.
Do not use `--minimal` blindly when its omissions would remove required file support.

Run `bundle install`, `bin/rails db:prepare`, and `bin/rails about` before building the
feature. Resolve setup failures rather than leaving a generated app that does not boot.

## Keep data local and durable

- Configure SQLite explicitly for each environment; tests must use a separate database.
  Use database constraints for invariants as well as model validations.
- Use Active Storage's Disk service for attachments. Copy uploads into app-managed storage;
  do not depend on their original location in Downloads or a mounted drive.
- Preserve source filenames and useful provenance. Validate uploads according to the app's
  actual needs, and provide a working view or download link.
- Keep databases, WAL/SHM files, uploaded documents, backups, credentials, and real personal
  seed data out of Git. Document where the persistent database and files actually live.
- Make supplied-data imports repeatable without duplicating or silently overwriting records.
  Mark unknown information as unknown; do not infer a submission date or document assignment
  solely from filenames. Distinguish demonstration fixtures from the user's real records.
- Provide a simple backup and restore path when the app stores meaningful user data. Stop
  writes while taking a consistent SQLite backup and copying the matching attachment store.
  Use SQLite's backup mechanism for the database; copying only a live `.sqlite3` file can
  miss committed data still in WAL. Keep the backup outside the data being backed up.
  Verify a restore into a temporary location, including an attachment, before calling it
  usable. Never test a restore by overwriting the user's live data.

## Run on this machine

Provide a start command or small script that binds explicitly to loopback:

```sh
bin/rails server --binding=127.0.0.1 --port=3000
```

Use another available port when needed. Check the owning process before stopping anything;
do not kill an unrelated server to reclaim a port. Explain the selected URL and how to stop
this app. Do not expose it through `0.0.0.0`, a tunnel, or a deployment as a convenience.

Retain Rails CSRF and host protections. For a single-user loopback app, avoid adding account
management just to resemble a hosted product. Reassess authentication and deployment
settings if the user later requests shared or remote access.

Serve fonts, CSS, JavaScript, and images locally, with system-font fallbacks when useful.
Do not load CDN scripts or web fonts merely for appearance. Keep normal operation usable
without third-party network requests; downloading development dependencies is a separate
setup step.

## Verify and hand back

Build the smallest complete workflow the user requested. Favor accessible forms, useful
empty states, readable errors, and a clear path back to the main view over dashboard chrome.

Test meaningful behavior at the public boundary: persistence, critical policy/date rules,
uploads/downloads, and import idempotency where relevant. Include boundary cases for any
rolling-window or waiting-period rule rather than testing only today's happy path.
Use synthetic fixtures instead of committing the user's documents or personal data.

Run the relevant test suite and existing lint checks. Build assets if the chosen stack needs
it. Exercise the primary workflow in a browser and confirm a restart preserves the data and
attachments. Report failures candidly; successful generation is not verification.

Provide the app directory, verified local URL, start/stop instructions, database and file
locations, backup/restore instructions, and any unresolved data assumptions. Keep this
operating note short and in the app repository so the next session can use it.
