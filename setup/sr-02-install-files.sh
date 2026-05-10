#!/bin/bash
# Shay-Rolls Setup — Step 2: Install files into project
# Requires: SR_REPO_DIR PROJECT_DIR (from sr-01)

G='\033[0;32m' N='\033[0m'

mkdir -p "$PROJECT_DIR"/{.claude/{agents,commands,scripts},.shay-rolls/{.cache,audit,guard}}
mkdir -p "$PROJECT_DIR/.claude/skills/"{shay-rolls-core/rules,shay-expert,shay-plan,\
shay-review,shay-security,shay-refactor,shay-test,shay-document,andie}

cp "$SR_REPO_DIR/CLAUDE.md"                                       "$PROJECT_DIR/CLAUDE.md"
cp "$SR_REPO_DIR/core/hooks/settings.json"                        "$PROJECT_DIR/.claude/settings.json"
cp "$SR_REPO_DIR/core/agents/"*.md                                "$PROJECT_DIR/.claude/agents/"
cp "$SR_REPO_DIR/core/commands/"*.md                              "$PROJECT_DIR/.claude/commands/"
cp "$SR_REPO_DIR/core/scripts/"*                                  "$PROJECT_DIR/.claude/scripts/"
chmod +x "$PROJECT_DIR/.claude/scripts/"*.py 2>/dev/null || true
chmod +x "$PROJECT_DIR/.claude/scripts/"*.sh 2>/dev/null || true
cp "$SR_REPO_DIR/core/skills/shay-rolls-core/SKILL.md"            "$PROJECT_DIR/.claude/skills/shay-rolls-core/"
cp "$SR_REPO_DIR/core/skills/shay-rolls-core/rules/"*.md          "$PROJECT_DIR/.claude/skills/shay-rolls-core/rules/"
for SK in shay-expert shay-plan shay-review shay-security shay-refactor shay-test shay-document andie; do
    cp "$SR_REPO_DIR/core/skills/$SK/SKILL.md" "$PROJECT_DIR/.claude/skills/$SK/"
done
cp "$SR_REPO_DIR/templates/architecture.md"   "$PROJECT_DIR/.shay-rolls/architecture.md"
mkdir -p "$PROJECT_DIR/.shay-rolls/ci"
cp "$SR_REPO_DIR/core/ci/"*                   "$PROJECT_DIR/.shay-rolls/ci/"

[ ! -d "$PROJECT_DIR/.git" ] && git -C "$PROJECT_DIR" init --quiet && \
    git -C "$PROJECT_DIR" checkout -b main 2>/dev/null || true

cp "$SR_REPO_DIR/core/hooks/pre-commit"  "$PROJECT_DIR/.git/hooks/pre-commit"
chmod +x "$PROJECT_DIR/.git/hooks/pre-commit"

echo -e "  ${G}✅ All files installed${N}"
