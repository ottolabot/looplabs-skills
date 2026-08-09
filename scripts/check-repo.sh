#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

python3 "$repo_root/scripts/validate-skills.py" "$repo_root/skills"
bash -n "$repo_root/scripts/link-agent-skills.sh"
bash -n "$repo_root/scripts/check-repo.sh"

printf 'Repository checks passed.\n'
