#!/usr/bin/env bash
set -euo pipefail

# Links promoted skills in the repository to local Codex skill roots.
#
# By default this writes to both historical Codex user-skill locations:
#   ~/.codex/skills
#   ~/.agents/skills
#
# Pass one or more destination directories as arguments to override.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
if [ "$#" -gt 0 ]; then
  DESTS=("$@")
else
  DESTS=("$HOME/.codex/skills" "$HOME/.agents/skills")
fi

PROMOTED_BUCKETS=(
  "$REPO/skills/engineering"
  "$REPO/skills/productivity"
  "$REPO/skills/misc"
)

for DEST in "${DESTS[@]}"; do
  # If the destination itself is a symlink that resolves into this repo, we'd
  # end up writing the per-skill symlinks back into the repo's own skills/ tree.
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $DEST is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
        exit 1
        ;;
    esac
  fi

  mkdir -p "$DEST"

  for bucket in "${PROMOTED_BUCKETS[@]}"; do
    find "$bucket" -mindepth 2 -maxdepth 2 -name SKILL.md -print0
  done |
  while IFS= read -r -d '' skill_md; do
    src="$(dirname "$skill_md")"
    name="$(basename "$src")"
    target="$DEST/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "skipped $name: $target exists and is not a symlink" >&2
      continue
    fi

    ln -sfn "$src" "$target"
    echo "linked $name -> $src"
  done
done
