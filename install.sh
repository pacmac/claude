#!/bin/bash
set -euo pipefail

REPO="pacmac/claude"
BRANCH="master"
INSTALL_DIR="$HOME/.claude"
BIN_DIR="$HOME/.local/bin"

echo "Installing Claude Code skills..."

# Download repo tarball to temp dir
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "https://github.com/$REPO/tarball/$BRANCH" | tar xz -C "$TMP" --strip-components=1

# Install skills
mkdir -p "$INSTALL_DIR/skills"
for skill_dir in "$TMP"/skills/*/; do
  skill=$(basename "$skill_dir")
  rm -rf "$INSTALL_DIR/skills/$skill"
  cp -r "$skill_dir" "$INSTALL_DIR/skills/$skill"
  echo "  + skill: /$skill"
done

# Install cr script
mkdir -p "$BIN_DIR"
cp "$TMP/cr" "$BIN_DIR/cr"
chmod +x "$BIN_DIR/cr"
echo "  + cr -> $BIN_DIR/cr"

# Check PATH
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
  echo ""
  echo "Add $BIN_DIR to your PATH:"
  echo "  export PATH=\"$BIN_DIR:\$PATH\""
fi

echo ""
echo "Done. Skills are ready — use /session-id, /codebox, /investigate, /no-guessing, /undo in Claude Code."
