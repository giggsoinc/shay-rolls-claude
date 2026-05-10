#!/bin/bash
# Shay-Rolls Setup — Step 3: .gitignore
# Requires: PROJECT_DIR

G='\033[0;32m' Y='\033[1;33m' N='\033[0m'

if [ ! -f "$PROJECT_DIR/.gitignore" ]; then
    cat > "$PROJECT_DIR/.gitignore" << 'GIEOF'
# Secrets — NEVER commit
.env
.env.*
*.pem
*.key
*.p12
*.pfx
manifest.secrets.json
.shay-rolls/manifest.secrets.json
.shay-rolls/.cache/
.shay-rolls/audit/
.shay-rolls/guard/digest.log

# Shay-Rolls framework — never commit (lives outside project)
shay-rolls-claude/
shay-rolls-claude-guard/
.shay-rolls-claude/
.shay-rolls-claude-guard/

# Python
__pycache__/
*.py[cod]
.venv/
venv/

# Node
node_modules/

# OS
.DS_Store
Thumbs.db
GIEOF
    echo -e "  ${G}✅ .gitignore created${N}"
else
    MISSING=""
    for E in ".env" "*.pem" "manifest.secrets.json" "shay-rolls-claude/"; do
        grep -q "$E" "$PROJECT_DIR/.gitignore" 2>/dev/null || MISSING="$MISSING $E"
    done
    if [ -n "$MISSING" ]; then
        printf '\n# Shay-Rolls\n.env\n.env.*\n*.pem\n*.key\nmanifest.secrets.json\n.shay-rolls/manifest.secrets.json\nshay-rolls-claude/\nshay-rolls-claude-guard/\n' \
            >> "$PROJECT_DIR/.gitignore"
        echo -e "  ${Y}⚠️  .gitignore updated — added:$MISSING${N}"
    else
        echo -e "  ${G}✅ .gitignore OK${N}"
    fi
fi
printf 'manifest.secrets.json\n.cache/\naudit/\n' > "$PROJECT_DIR/.shay-rolls/.gitignore"
