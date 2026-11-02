---
name: implement
description: Implement one bounded specification or ticket, verify it at agreed seams, and review the resulting diff. Use when the user supplies approved work that is ready to build rather than explore.
---

> Adapted from [the upstream implement skill](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/implement/SKILL.md) at [the pinned commit](https://github.com/mattpocock/skills/commit/84fdeffd12f2ee307994d1eb6feb48173b6e0502).

# Implement

Implement only the approved specification or ticket the user supplied.

Apply the [development defaults](../karpathy-guidelines/SKILL.md#development-defaults): no new unit-test cases or explanatory code comments unless the user or repository explicitly requests them. Maintain existing ones and verify behavior throughout.

1. Read the full ticket, its blockers, repository instructions, glossary, and relevant ADRs.
2. State the bounded success criteria and verification commands.
3. Use the `tdd` skill for relevant existing tests or minimal integration/system coverage at pre-agreed public seams where behavior is non-trivial. Use a disposable behavior probe when new retained coverage is unwarranted.
4. Run the narrowest relevant checks throughout; run the full applicable suite once at the end.
5. Use `code-review` and `ponytail-review` on the final diff and address in-scope findings.
6. For app changes, show the completed result in the running local app before handing back. Reuse or start the appropriate isolated development server under the repository's lifecycle rules, open the affected page in a visible browser, and demonstrate the changed workflow. For server-only changes, demonstrate the relevant request and response against that server. Leave it available for inspection; report a concrete blocker if the local demonstration cannot be completed.
7. Report the changed behavior, concrete verification evidence, and the local URL with concise reproduction steps when applicable.

Commit when the repository workflow or user expects a commit. Never push, merge, deploy, or perform another irreversible action without the applicable authorization.
