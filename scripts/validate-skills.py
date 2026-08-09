#!/usr/bin/env python3

from __future__ import annotations

import re
import sys
from pathlib import Path


NAME_RE = re.compile(r"^[a-z0-9-]{1,63}$")
KEY_RE = re.compile(r"^([A-Za-z0-9_-]+):(?:\s*(.*))?$")
LINK_RE = re.compile(r"\[[^]]+\]\(([^)]+)\)")


def fail(errors: list[str], path: Path, message: str) -> None:
    errors.append(f"{path}: {message}")


def outside_fences(lines: list[str]) -> list[str]:
    kept: list[str] = []
    fenced = False
    for line in lines:
        if line.lstrip().startswith("```"):
            fenced = not fenced
            continue
        if not fenced:
            kept.append(line)
    return kept


def validate_skill(skill_dir: Path, errors: list[str]) -> None:
    skill_file = skill_dir / "SKILL.md"
    if not skill_file.is_file():
        fail(errors, skill_dir, "missing SKILL.md")
        return

    text = skill_file.read_text(encoding="utf-8")
    lines = text.splitlines()
    if len(lines) > 500:
        fail(errors, skill_file, f"SKILL.md has {len(lines)} lines; keep it under 500")
    if "TODO" in text:
        fail(errors, skill_file, "contains TODO")
    if not lines or lines[0] != "---":
        fail(errors, skill_file, "frontmatter must begin on line 1")
        return

    try:
        end = lines.index("---", 1)
    except ValueError:
        fail(errors, skill_file, "frontmatter is not closed")
        return

    fields: dict[str, str] = {}
    for line in lines[1:end]:
        if not line.strip():
            continue
        match = KEY_RE.match(line)
        if not match:
            fail(errors, skill_file, f"unsupported multiline or malformed frontmatter: {line!r}")
            continue
        key, value = match.groups()
        if key in fields:
            fail(errors, skill_file, f"duplicate frontmatter key {key}")
        fields[key] = (value or "").strip().strip('"').strip("'")

    if set(fields) != {"name", "description"}:
        fail(errors, skill_file, f"frontmatter keys must be name and description, found {sorted(fields)}")

    name = fields.get("name", "")
    description = fields.get("description", "")
    if name != skill_dir.name:
        fail(errors, skill_file, f"name {name!r} does not match folder {skill_dir.name!r}")
    if not NAME_RE.fullmatch(name):
        fail(errors, skill_file, f"invalid skill name {name!r}")
    if not description:
        fail(errors, skill_file, "description is empty")
    if "<" in description or ">" in description:
        fail(errors, skill_file, "description contains angle-bracket placeholders")
    if not any(word in description.lower() for word in ("use when", "use on", "use while")):
        fail(errors, skill_file, "description must say when to use the skill")
    if not "\n".join(lines[end + 1 :]).strip():
        fail(errors, skill_file, "body is empty")

    metadata = skill_dir / "agents" / "openai.yaml"
    if not metadata.is_file():
        fail(errors, skill_dir, "missing agents/openai.yaml")
    else:
        meta_text = metadata.read_text(encoding="utf-8")
        for key in ("display_name:", "short_description:", "default_prompt:"):
            if key not in meta_text:
                fail(errors, metadata, f"missing {key[:-1]}")
        if f"${name}" not in meta_text:
            fail(errors, metadata, f"default_prompt must mention ${name}")

    for line in outside_fences(lines[end + 1 :]):
        for target in LINK_RE.findall(line):
            if target.startswith(("http://", "https://", "mailto:", "#")):
                continue
            target_path = (skill_dir / target.split("#", 1)[0]).resolve()
            if not target_path.exists():
                fail(errors, skill_file, f"broken local link {target!r}")


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {Path(sys.argv[0]).name} <skills-root>", file=sys.stderr)
        return 2

    root = Path(sys.argv[1]).resolve()
    errors: list[str] = []
    skill_dirs = sorted(path for path in root.iterdir() if path.is_dir() and not path.name.startswith("."))
    if not skill_dirs:
        print(f"{root}: no skill directories", file=sys.stderr)
        return 1

    for skill_dir in skill_dirs:
        validate_skill(skill_dir, errors)

    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1

    print(f"Validated {len(skill_dirs)} skills.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
