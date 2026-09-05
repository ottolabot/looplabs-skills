# Loop Labs Skills

The shared agent-skill library for Loop Labs. One tracked `skills/` directory is exposed to Claude Code, Codex, and Hermes; do not maintain client-specific copies.

## Install on a Mac

```bash
git clone https://github.com/ottolabot/looplabs-skills.git ~/code/github/looplabs-skills
cd ~/code/github/looplabs-skills
./scripts/link-agent-skills.sh
./scripts/link-agent-skills.sh --check
```

The linker configures:

```text
~/.claude/skills  -> <repo>/skills       Claude Code
~/.agents/skills  -> <repo>/skills       Codex
Hermes skills.external_dirs: [<repo>/skills]
```

It is idempotent and refuses to replace conflicting files, non-empty directories, or unrelated symlinks. Restart the three clients after linking so they reload the library.

## Skills

- Planning: `wayfinder`, `grilling`, `grill-me`, `grill-with-docs`, `domain-modeling`, `research`, `prototype`
- Delivery: `to-spec`, `to-tickets`, `implement`, `tdd`, `code-review`, `kickstart-prototype-rails-app`
- Product engineering: `add-product-analytics`
- Implementation discipline: `karpathy-guidelines`, `ponytail`, `ponytail-review`
- Writing: `write-good-copy`, `no-ai-slop`
- Library maintenance: `write-lab-skill`

Use `write-lab-skill` to add or update a skill. Run `./scripts/check-repo.sh` before committing.

## Personal voice packs

`write-good-copy` can read optional voice packs without embedding anyone's personal examples in this repository. Put a project-shared pack in `.agents/voices/<profile>/` or a private personal pack in `~/.config/agent-voices/<profile>/`; see the skill's voice-pack reference for the format.

## Sources

Adapted skills link their exact upstream source and pinned commit inside each `SKILL.md`. [SOURCES.md](SOURCES.md) is the complete attribution index, and upstream license texts are retained under `LICENSES/`.
