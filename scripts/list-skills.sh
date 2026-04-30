#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"

cd "$REPO"
if [ "${1:-}" = "--all" ]; then
  find skills -name SKILL.md -not -path '*/node_modules/*' | sort
else
  find skills/engineering skills/productivity skills/misc \
    -mindepth 2 -maxdepth 2 -name SKILL.md | sort
fi
