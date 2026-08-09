---
name: write-lab-skill
description: Create or update a focused, portable agent skill in the canonical Loop Labs skill library and verify discovery by Claude Code, Codex, and Hermes. Use when the user asks to add, adapt, rename, or improve a reusable Loop Labs skill or its bundled scripts, references, assets, validation, or source attribution.
---

# Write a Lab Skill

> Adapted from Loop Labs' earlier [`write-a-personal-skill`](https://github.com/RichStone/dotclaude/blob/0a76195036792592cb3ca0bcfbad670ba6b83fff/skills/write-a-personal-skill/SKILL.md).

Create one canonical skill. Never maintain separate Claude Code, Codex, and Hermes copies.

## Locate the library

This skill lives at `<repo>/skills/write-lab-skill/`; therefore the canonical skill root is its parent directory and the repository root is two levels above this file. Create new skills as `<repo>/skills/<skill-name>/`.

If the client exposes an official skill-creator skill, load its full instructions before editing. Otherwise follow this workflow directly.

## Build the skill

1. Confirm the task, triggering situations, representative examples, and whether deterministic scripts or supporting references are needed. Make reasonable assumptions when these are already clear.
2. Use a lowercase, verb-led hyphenated name under 64 characters. Name the folder exactly after the skill.
3. Create `SKILL.md` with YAML frontmatter containing only `name` and `description`. Put what the skill does and all trigger guidance in the description.
4. Keep the body imperative, concise, and under 500 lines. Put optional detail one level deep under `references/`; reusable deterministic operations under `scripts/`; output materials under `assets/`.
5. Add `agents/openai.yaml` with quoted `display_name`, `short_description`, and a one-sentence `default_prompt` that explicitly names `$skill-name`.
6. If adapting external work, link the exact upstream file and pinned commit inside `SKILL.md`, update `<repo>/SOURCES.md`, and retain the applicable license or notice under `<repo>/LICENSES/`.
7. Do not embed personal examples or secrets in a generic skill. Define an optional external profile or data format instead.

## Keep all three clients synchronized

Run:

```bash
<repo>/scripts/link-agent-skills.sh
<repo>/scripts/link-agent-skills.sh --check
```

The linker establishes one source of truth:

```text
~/.claude/skills  -> <repo>/skills       Claude Code
~/.agents/skills  -> <repo>/skills       Codex
Hermes active profile:
  skills.external_dirs: [<repo>/skills]
```

The linker is idempotent and must refuse to overwrite conflicting paths. Do not manually copy the new skill into any client directory. Restart or open a fresh client session only when that client does not reload skill discovery automatically.

## Validate

Run `<repo>/scripts/check-repo.sh`. Also use the client's official skill validator when available, and execute any added scripts against representative inputs.

Before handing off, confirm:

- the folder, frontmatter name, local links, and UI metadata agree;
- the description contains concrete triggers and no placeholders;
- references are one level deep and there are no unused files;
- source links and licenses are present for adapted work;
- all three clients point to the canonical skill root.

Report the created or changed files, validation evidence, and any client restart still required.
