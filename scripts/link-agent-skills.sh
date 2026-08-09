#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
skills_root="$repo_root/skills"
mode="link"

usage() {
  printf 'Usage: %s [--check]\n' "$0"
}

case "${1:-}" in
  "") ;;
  --check) mode="check" ;;
  -h|--help) usage; exit 0 ;;
  *) usage >&2; exit 2 ;;
esac

failures=0

check_link() {
  local path="$1"
  local target="$2"
  local label="$3"

  if [[ -L "$path" && "$(readlink "$path")" == "$target" ]]; then
    printf 'OK   %s: %s -> %s\n' "$label" "$path" "$target"
  else
    printf 'FAIL %s: expected %s -> %s\n' "$label" "$path" "$target" >&2
    failures=$((failures + 1))
  fi
}

link_path() {
  local path="$1"
  local target="$2"
  local label="$3"

  mkdir -p "$(dirname "$path")"

  if [[ -L "$path" ]]; then
    if [[ "$(readlink "$path")" == "$target" ]]; then
      printf 'OK   %s already linked: %s -> %s\n' "$label" "$path" "$target"
      return
    fi
    printf 'Refusing to replace existing symlink: %s -> %s\n' "$path" "$(readlink "$path")" >&2
    exit 1
  fi

  if [[ -d "$path" ]]; then
    if rmdir "$path" 2>/dev/null; then
      printf 'Removed empty directory: %s\n' "$path"
    else
      printf 'Refusing to replace non-empty directory: %s\n' "$path" >&2
      exit 1
    fi
  elif [[ -e "$path" ]]; then
    printf 'Refusing to replace existing path: %s\n' "$path" >&2
    exit 1
  fi

  ln -s "$target" "$path"
  printf 'LINK %s: %s -> %s\n' "$label" "$path" "$target"
}

hermes_config_path() {
  local active_file="$HOME/.hermes/active_profile"
  [[ -f "$active_file" ]] || return 1
  local profile
  profile="$(tr -d '[:space:]' < "$active_file")"
  [[ -n "$profile" ]] || return 1
  printf '%s/.hermes/profiles/%s/config.yaml\n' "$HOME" "$profile"
}

check_hermes() {
  local config_path
  if ! config_path="$(hermes_config_path)" || [[ ! -f "$config_path" ]]; then
    printf 'SKIP Hermes: no active profile config found\n'
    return
  fi

  if HERMES_CONFIG="$config_path" SKILLS_ROOT="$skills_root" ruby -ryaml -e '
    config = YAML.load_file(ENV.fetch("HERMES_CONFIG")) || {}
    dirs = config.dig("skills", "external_dirs")
    exit(dirs == [ENV.fetch("SKILLS_ROOT")] ? 0 : 1)
  '; then
    printf 'OK   Hermes: skills.external_dirs contains only %s\n' "$skills_root"
  else
    printf 'FAIL Hermes: expected skills.external_dirs: [%s]\n' "$skills_root" >&2
    failures=$((failures + 1))
  fi
}

configure_hermes() {
  local config_path
  if ! config_path="$(hermes_config_path)" || [[ ! -f "$config_path" ]]; then
    printf 'SKIP Hermes: no active profile config found\n'
    return
  fi

  HERMES_CONFIG="$config_path" SKILLS_ROOT="$skills_root" ruby -ryaml -rtempfile -e '
    path = ENV.fetch("HERMES_CONFIG")
    config = YAML.load_file(path) || {}
    config["skills"] ||= {}
    config["skills"]["external_dirs"] = [ENV.fetch("SKILLS_ROOT")]
    mode = File.stat(path).mode
    Tempfile.create([".config", ".yaml"], File.dirname(path)) do |file|
      file.write(YAML.dump(config))
      file.flush
      file.fsync
      File.chmod(mode, file.path)
      File.rename(file.path, path)
    end
  '
  printf 'LINK Hermes: skills.external_dirs = [%s]\n' "$skills_root"
}

if [[ "$mode" == "check" ]]; then
  check_link "$HOME/.claude/skills" "$skills_root" "Claude Code"
  check_link "$HOME/.agents/skills" "$skills_root" "Codex"
  check_hermes
  "$repo_root/scripts/check-repo.sh"
  if (( failures > 0 )); then
    exit 1
  fi
  printf 'All three agent clients use the canonical skill root.\n'
  exit 0
fi

link_path "$HOME/.claude/skills" "$skills_root" "Claude Code"
link_path "$HOME/.agents/skills" "$skills_root" "Codex"
configure_hermes

printf 'Shared skills linked. Restart Claude Code, Codex, and Hermes to reload them.\n'
