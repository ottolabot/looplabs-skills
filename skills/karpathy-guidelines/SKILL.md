---
name: karpathy-guidelines
description: Reduce common agent coding mistakes by surfacing assumptions, choosing simple solutions, making surgical changes, and defining verifiable success criteria. Use while writing, reviewing, debugging, or refactoring code, especially for non-trivial work.
---

> Adapted from [the upstream karpathy-guidelines skill](https://github.com/multica-ai/andrej-karpathy-skills/blob/2c606141936f1eeef17fa3043a72095b4765b9c2/skills/karpathy-guidelines/SKILL.md) at [the pinned commit](https://github.com/multica-ai/andrej-karpathy-skills/commit/2c606141936f1eeef17fa3043a72095b4765b9c2).

# Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## Development defaults

Apply these [maintenance defaults](https://x.com/jasich/status/2116154785510338965) unless the user or repository explicitly requests otherwise:

- Do not add unit-test files or cases, including cases added to existing unit-test files. Maintain existing cases as behavior changes; remove only obsolete coverage, never a check that exposes a failure.
- Do not add explanatory code comments or docstrings. Update existing ones for accuracy or remove obsolete ones; make new code readable through names and structure.
- Verify behavior with existing suites and real workflow checks. Add integration or system coverage only when it protects a meaningful public contract; an isolated unit test does not become integration coverage by changing its label.
- Apply the same defaults to new projects, including newly generated scaffolding. Do not sweep existing projects to remove useful tests or comments.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Exercise valid and invalid inputs through the real interface"
- "Fix the bug" → "Reproduce it through the public workflow, fix it, then repeat the check"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.
