#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
COMMAND=""

if command -v jq >/dev/null 2>&1; then
  COMMAND=$(
    printf '%s' "$INPUT" | jq -r '
      .tool_input.command? //
      .toolInput.command? //
      .command? //
      .arguments.command? //
      .tool_call.arguments.command? //
      .toolCall.arguments.command? //
      .payload.command? //
      empty
    ' 2>/dev/null | head -n 1
  )
fi

if [ -z "$COMMAND" ]; then
  COMMAND="$INPUT"
fi

DANGEROUS_PATTERNS=(
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push([[:space:]]|$)'
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+reset([^;&|]*)[[:space:]]--hard([[:space:]]|$)'
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+clean([^;&|]*)[[:space:]]-[^[:space:]]*f'
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+branch[[:space:]]+-D([[:space:]]|$)'
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+checkout[[:space:]]+\.([[:space:]]|$)'
  '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+restore[[:space:]]+\.([[:space:]]|$)'
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if printf '%s' "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: '$COMMAND' matches dangerous pattern '$pattern'. The user has prevented you from doing this." >&2
    exit 2
  fi
done

exit 0
