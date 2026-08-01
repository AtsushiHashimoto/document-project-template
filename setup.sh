#!/bin/bash
# Document Project Template Setup Script
# Usage: ./setup.sh "Project Name" "Project Description" "Author Name"

set -e

PROJECT_NAME="${1:-my-document-project}"
PROJECT_DESCRIPTION="${2:-A document project}"
RESEARCHER_NAME="${3:-Author}"
START_DATE=$(date '+%Y-%m-%d')

echo "Setting up document project: $PROJECT_NAME"

# sed -i は GNU と BSD(macOS) で引数解釈が異なる。`-i.bak` + rm が両者で動く唯一の形
sed_inplace() {
    local expr="$1" file="$2"
    sed -i.bak "$expr" "$file" && rm -f "$file.bak"
}
sanitize_sed() { printf '%s' "$1" | sed 's/[&|\\]/\\&/g'; }

sed_inplace "s|{{PROJECT_NAME}}|$(sanitize_sed "$PROJECT_NAME")|g" .claude/CLAUDE.md
sed_inplace "s|{{PROJECT_DESCRIPTION}}|$(sanitize_sed "$PROJECT_DESCRIPTION")|g" .claude/CLAUDE.md
sed_inplace "s|{{RESEARCHER_NAME}}|$(sanitize_sed "$RESEARCHER_NAME")|g" .claude/CLAUDE.md
sed_inplace "s|{{START_DATE}}|$(sanitize_sed "$START_DATE")|g" .claude/CLAUDE.md

echo ""
echo "Done. Next steps:"
echo "  1. Install the base template (Issue-driven machinery):"
echo "     curl -fsSL https://raw.githubusercontent.com/AtsushiHashimoto/research-project-template/main/install.sh | bash"
echo "  2. Start Claude Code and run /doc-init with your form and review criteria."
echo "     Do not write a single sentence before /doc-init completes."
