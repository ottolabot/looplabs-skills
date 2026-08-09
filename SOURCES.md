# Sources and attribution

Loop Labs owns the adaptations and original skills in this repository. The following skills incorporate work from the linked upstream sources. Every adapted `SKILL.md` also links its exact source and pinned commit.

## Matt Pocock skills

Source repository: [mattpocock/skills](https://github.com/mattpocock/skills)
Pinned commit: [`84fdeffd12f2ee307994d1eb6feb48173b6e0502`](https://github.com/mattpocock/skills/commit/84fdeffd12f2ee307994d1eb6feb48173b6e0502)
License: MIT; retained as `LICENSES/mattpocock-skills-MIT.txt`.

| Loop Labs skill | Upstream source |
|---|---|
| `wayfinder` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/wayfinder/SKILL.md) |
| `grilling` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/productivity/grilling/SKILL.md) |
| `grill-me` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/productivity/grill-me/SKILL.md) |
| `grill-with-docs` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/grill-with-docs/SKILL.md) |
| `domain-modeling` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/domain-modeling/SKILL.md) and its format references |
| `research` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/research/SKILL.md) |
| `prototype` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/prototype/SKILL.md) and its prototype guides |
| `to-spec` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/to-spec/SKILL.md) |
| `to-tickets` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/to-tickets/SKILL.md) |
| `implement` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/implement/SKILL.md) |
| `tdd` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/tdd/SKILL.md) and its testing references |
| `code-review` | [SKILL.md](https://github.com/mattpocock/skills/blob/84fdeffd12f2ee307994d1eb6feb48173b6e0502/skills/engineering/code-review/SKILL.md) |

The adaptations normalize frontmatter, remove the separate setup-skill dependency, add tracker fallbacks, and make background-agent behavior portable across the three clients.

## Ponytail

Source repository: [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail)
Pinned commit: [`2ed6c52c9d7e5e56942508591085fd45dea277d3`](https://github.com/DietrichGebert/ponytail/commit/2ed6c52c9d7e5e56942508591085fd45dea277d3)
License: MIT; retained as `LICENSES/ponytail-MIT.txt`.

- [`ponytail`](https://github.com/DietrichGebert/ponytail/blob/2ed6c52c9d7e5e56942508591085fd45dea277d3/skills/ponytail/SKILL.md)
- [`ponytail-review`](https://github.com/DietrichGebert/ponytail/blob/2ed6c52c9d7e5e56942508591085fd45dea277d3/skills/ponytail-review/SKILL.md)

## Karpathy guidelines

Source: [`karpathy-guidelines/SKILL.md`](https://github.com/multica-ai/andrej-karpathy-skills/blob/2c606141936f1eeef17fa3043a72095b4765b9c2/skills/karpathy-guidelines/SKILL.md) in [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills).
Pinned commit: [`2c606141936f1eeef17fa3043a72095b4765b9c2`](https://github.com/multica-ai/andrej-karpathy-skills/commit/2c606141936f1eeef17fa3043a72095b4765b9c2).
The upstream file declares an MIT license; the repository does not currently contain a separate license file. See `LICENSES/karpathy-guidelines-NOTICE.md`.

## No AI slop

Source: [`no-ai-slop/SKILL.md`](https://github.com/petergyang/no-ai-slop/blob/d30eddb9e04562234f2070b5ee63ca4649d9a05e/skills/no-ai-slop/SKILL.md) and [`eval.md`](https://github.com/petergyang/no-ai-slop/blob/d30eddb9e04562234f2070b5ee63ca4649d9a05e/skills/no-ai-slop/eval.md) in [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop).
Pinned commit: [`d30eddb9e04562234f2070b5ee63ca4649d9a05e`](https://github.com/petergyang/no-ai-slop/commit/d30eddb9e04562234f2070b5ee63ca4649d9a05e).
License: MIT; retained as `LICENSES/no-ai-slop-MIT.txt`.

`write-good-copy` is an original Loop Labs orchestration skill that invokes the adapted `no-ai-slop` skill for its editorial pass.

## write-lab-skill

`write-lab-skill` is adapted from Loop Labs' earlier [`write-a-personal-skill`](https://github.com/RichStone/dotclaude/blob/0a76195036792592cb3ca0bcfbad670ba6b83fff/skills/write-a-personal-skill/SKILL.md). It replaces dotclaude-specific paths with this repository and documents the shared Claude Code, Codex, and Hermes linking mechanism.
