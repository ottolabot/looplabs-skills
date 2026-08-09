---
name: implement
description: Implement one bounded specification or ticket, verify it at agreed seams, and review the resulting diff. Use when the user supplies approved work that is ready to build rather than explore.
---

> Adapted from [the upstream implement skill](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/implement/SKILL.md) at [the pinned commit](https://github.com/mattpocock/skills/commit/84fdeffd12f2ee307994d1eb6feb48173b6e0502).

# Implement

Implement only the approved specification or ticket the user supplied.

1. Read the full ticket, its blockers, repository instructions, glossary, and relevant ADRs.
2. State the bounded success criteria and verification commands.
3. Use the `tdd` skill at pre-agreed public seams where behavior is non-trivial.
4. Run the narrowest relevant checks throughout; run the full applicable suite once at the end.
5. Use `code-review` and `ponytail-review` on the final diff and address in-scope findings.
6. Report the changed behavior and concrete verification evidence.

Commit when the repository workflow or user expects a commit. Never push, merge, deploy, or perform another irreversible action without the applicable authorization.
