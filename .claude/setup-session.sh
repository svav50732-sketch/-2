#!/usr/bin/env bash
# SessionStart hook: install/update third-party skills the project relies on.
# Runs async so it doesn't block session startup.

set -euo pipefail

# Tell Claude Code to run us async — the session can start while we work.
echo '{"async": true, "asyncTimeout": 120000}'

# Ensure the skills dir exists.
mkdir -p "$HOME/.claude/skills"

# humanizer — removes AI-writing patterns from text. Used after UGC drafts.
HUMANIZER_DIR="$HOME/.claude/skills/humanizer"
if [ -d "$HUMANIZER_DIR/.git" ]; then
  git -C "$HUMANIZER_DIR" pull --ff-only --quiet 2>/dev/null || true
else
  rm -rf "$HUMANIZER_DIR"
  git clone --quiet --depth 1 https://github.com/blader/humanizer.git "$HUMANIZER_DIR" 2>/dev/null || true
fi
