---
name: git-guardrails-codex
description: Set up Codex hooks to block dangerous git commands (push, reset --hard, clean, branch -D, etc.) before they execute. Use when user wants to prevent destructive git operations, add git safety hooks, block git push/reset in Codex, or migrate Claude Code git guardrails to Codex.
---

# Setup Git Guardrails for Codex

Sets up a Codex `PreToolUse` hook that intercepts and blocks dangerous shell commands before Codex executes them.

Codex hook behavior differs from Claude Code:

- Hooks must be enabled with `[features].codex_hooks = true`.
- `PreToolUse` currently runs for shell commands.
- Blocking works by exiting with code `2` or returning a deny/block decision.
- This is an extra policy layer on top of Codex's normal sandbox and approval flow.

## What Gets Blocked

- `git push` (all variants including `--force`)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

When blocked, Codex sees a message telling it that the command matched a denied pattern.

## Steps

### 1. Ask scope

Ask the user: install for **this project only** (`.codex/`) or **all projects** (`~/.codex/`)?

### 2. Copy the hook script

The bundled script is at: [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

Copy it to the target location based on scope:

- **Project**: `.codex/hooks/block-dangerous-git.sh`
- **Global**: `~/.codex/hooks/block-dangerous-git.sh`

Make it executable with `chmod +x`.

### 3. Enable Codex hooks

Merge this into the appropriate config file:

**Project** (`.codex/config.toml`) or **global** (`~/.codex/config.toml`):

```toml
[features]
codex_hooks = true
```

If the config file already has `[features]`, add or update only `codex_hooks`.

### 4. Add hook to Codex hooks config

Add to the appropriate hooks file:

**Project** (`.codex/hooks.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$(git rev-parse --show-toplevel)\"/.codex/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

**Global** (`~/.codex/hooks.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.codex/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

If the hooks file already exists, merge the hook into the existing `hooks.PreToolUse` array — don't overwrite other hooks.

### 5. Ask about customization

Ask if user wants to add or remove any patterns from the blocked list. Edit the copied script accordingly.

### 6. Verify

Run a quick test:

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
echo '{"command":"git reset --hard HEAD"}' | <path-to-script>
```

Should exit with code 2 and print a BLOCKED message to stderr.
