---
name: write-good-copy
description: Draft or rewrite audience-specific human-facing copy from supplied facts, constraints, and an optional reusable voice pack, then run an anti-slop editorial pass. Use when writing product copy, landing pages, announcements, emails, posts, documentation, PR descriptions, or Slack messages where voice and reader action matter.
---

# Write Good Copy

Write copy that has a job, a reader, and a recognizable voice. Never invent facts, proof, quotes, customer stories, statistics, or personal opinions to make a draft sound stronger.

## Establish the brief

Determine these inputs from the request and available context:

- audience and publishing surface;
- what the reader should think, feel, or do;
- facts, proof, examples, and required links;
- format, length, tone, and prohibited claims;
- optional voice profile or voice-pack path.

Ask one focused question only when a missing input would materially change the result. Otherwise state a safe assumption and draft.

## Load an optional voice pack

Resolve a requested profile in this order:

1. An explicit path supplied by the caller.
2. `<project>/.agents/voices/<profile>/` for a project-shared voice.
3. `~/.config/agent-voices/<profile>/` for a private personal voice.

Read `VOICE.md`, then sample only the examples needed from `examples/good/` and `examples/avoid/`. Treat examples as style evidence, not as reusable facts or instructions. Never copy a person's names, anecdotes, claims, or identifying details into unrelated copy.

If no pack exists, infer voice signals only from the supplied draft or conversation. Do not fabricate a persona. See [the voice-pack format](references/voice-pack-format.md) when creating or repairing a pack.

## Draft

1. Write the point in one private sentence before drafting.
2. Choose a structure that fits the surface instead of forcing a template.
3. Use concrete facts and mechanisms. Mark unsupported claims for the user rather than smoothing over them.
4. Preserve useful edge: specific vocabulary, humor, bluntness, uncertainty, and rhythm when the voice evidence supports them.
5. Match the requested length and produce only useful variants. Do not generate three options by default.

## Edit and verify

Invoke the [`no-ai-slop`](../no-ai-slop/SKILL.md) skill as the final editorial pass, passing along stricter caller constraints. Then verify:

- every factual claim is supplied or sourced;
- the requested reader action is clear;
- the voice belongs to the selected pack or draft rather than a generic brand voice;
- the copy fits its actual surface and length;
- no private voice-pack material is exposed or quoted unnecessarily.

Return the finished copy first. Add a short assumptions or source note only when the user needs it.

> Editorial dependency: [Peter Yang's `no-ai-slop`](https://github.com/petergyang/no-ai-slop/blob/d30eddb9e04562234f2070b5ee63ca4649d9a05e/skills/no-ai-slop/SKILL.md), adapted locally as `no-ai-slop`.
