#!/bin/bash
# Install the document-writing layer into an existing project.
# Usage: curl -fsSL <raw-url>/install.sh | bash [-s -- /path/to/project] [--force]
set -e

REPO="https://github.com/AtsushiHashimoto/document-project-template.git"
TARGET=""
FORCE=""
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    *) TARGET="$arg" ;;
  esac
done
if [ -z "$TARGET" ]; then
  TARGET="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
git clone --depth 1 "$REPO" "$TMP/tpl" >/dev/null 2>&1

copy() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ -z "$FORCE" ]; then
    echo "  skip (exists): ${dst#$TARGET/}"
  else
    mkdir -p "$(dirname "$dst")"
    cp -R "$src" "$dst"
    echo "  installed: ${dst#$TARGET/}"
  fi
}

echo "Installing document layer into: $TARGET"
for d in "$TMP/tpl/.claude/skills/"doc-*; do
  copy "$d" "$TARGET/.claude/skills/$(basename "$d")"
done
mkdir -p "$TARGET/.claude/rules/template"
for f in "$TMP/tpl/.claude/rules/template/"*.md; do
  copy "$f" "$TARGET/.claude/rules/template/$(basename "$f")"
done
for f in "$TMP/tpl/worksheet/"*.md; do
  copy "$f" "$TARGET/worksheet/$(basename "$f")"
done
mkdir -p "$TARGET/worksheet/sources" "$TARGET/docs/references" "$TARGET/docs/question-sets"

echo ""
echo "Done. Run /doc-init before writing anything."
