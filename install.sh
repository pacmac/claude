#!/bin/bash
set -euo pipefail

REPO="pacmac/claude"
BRANCH="master"
DEFAULT_BIN_DIR="$HOME/.local/bin"

# ── Helpers ──────────────────────────────────────────────────────────

ask() {
  local prompt="$1" default="$2" reply
  printf "%s [%s]: " "$prompt" "$default" >&2
  read -r reply
  echo "${reply:-$default}"
}

confirm() {
  local prompt="$1" default="${2:-y}" reply
  if [ "$default" = "y" ]; then
    printf "%s [Y/n]: " "$prompt" >&2
  else
    printf "%s [y/N]: " "$prompt" >&2
  fi
  read -r reply
  reply="${reply:-$default}"
  [[ "$reply" =~ ^[Yy] ]]
}

# ── Header ───────────────────────────────────────────────────────────

echo ""
echo "  Claude Code Toolkit Installer"
echo "  ─────────────────────────────"
echo ""

# ── Download ─────────────────────────────────────────────────────────

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Fetching latest from github.com/$REPO..."
curl -fsSL "https://github.com/$REPO/tarball/$BRANCH" | tar xz -C "$TMP" --strip-components=1
echo ""

# ── Discover available skills ────────────────────────────────────────

AVAILABLE_SKILLS=()
for skill_dir in "$TMP"/skills/*/; do
  [ -d "$skill_dir" ] && AVAILABLE_SKILLS+=("$(basename "$skill_dir")")
done

# ── Choose what to install ───────────────────────────────────────────

echo "Available skills: ${AVAILABLE_SKILLS[*]}"
echo ""
echo "What would you like to install?"
echo "  1) Everything (all skills + cr script)"
echo "  2) All skills only (no cr script)"
echo "  3) Pick individual skills"
echo ""
CHOICE=$(ask "Choice" "1")

INSTALL_SKILLS=()
INSTALL_CR=false

case "$CHOICE" in
  1)
    INSTALL_SKILLS=("${AVAILABLE_SKILLS[@]}")
    INSTALL_CR=true
    ;;
  2)
    INSTALL_SKILLS=("${AVAILABLE_SKILLS[@]}")
    ;;
  3)
    echo ""
    for skill in "${AVAILABLE_SKILLS[@]}"; do
      if confirm "  Install /$skill?"; then
        INSTALL_SKILLS+=("$skill")
      fi
    done
    echo ""
    if confirm "Install cr script (session resume from terminal)?"; then
      INSTALL_CR=true
    fi
    ;;
  *)
    echo "Invalid choice. Exiting."
    exit 1
    ;;
esac

if [ ${#INSTALL_SKILLS[@]} -eq 0 ] && [ "$INSTALL_CR" = false ]; then
  echo "Nothing selected. Exiting."
  exit 0
fi

# ── Skills install path ──────────────────────────────────────────────

SKILLS_DIR="$HOME/.claude/skills"

if [ ${#INSTALL_SKILLS[@]} -gt 0 ]; then
  echo ""
  SKILLS_DIR=$(ask "Skills directory" "$SKILLS_DIR")
  mkdir -p "$SKILLS_DIR"

  echo ""
  for skill in "${INSTALL_SKILLS[@]}"; do
    if [ -d "$SKILLS_DIR/$skill" ]; then
      if ! confirm "  /$skill already exists — overwrite?"; then
        echo "  - skipped /$skill"
        continue
      fi
    fi
    rm -rf "$SKILLS_DIR/$skill"
    cp -r "$TMP/skills/$skill" "$SKILLS_DIR/$skill"
    echo "  + /$skill"
  done
fi

# ── cr script install ────────────────────────────────────────────────

if [ "$INSTALL_CR" = true ]; then
  echo ""
  BIN_DIR=$(ask "Install cr script to" "$DEFAULT_BIN_DIR")
  mkdir -p "$BIN_DIR"
  cp "$TMP/cr" "$BIN_DIR/cr"
  chmod +x "$BIN_DIR/cr"
  echo "  + cr -> $BIN_DIR/cr"

  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$BIN_DIR"; then
    echo ""
    echo "  Note: $BIN_DIR is not in your PATH. Add it with:"
    echo "    export PATH=\"$BIN_DIR:\$PATH\""
  fi
fi

# ── Done ─────────────────────────────────────────────────────────────

echo ""
echo "Done!"
