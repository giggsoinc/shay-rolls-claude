#!/bin/bash
# Shay-Rolls Claude — One-Line Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/giggso/shay-rolls-claude/main/install.sh | bash
#
# What this does:
#   1. Downloads latest Shay-Rolls Core to ~/.shay-rolls-claude/
#   2. Makes shay-rolls-setup available as a global command
#   3. You then run: shay-rolls-setup  from any project
#
# Requires: git, bash, python3, claude (Claude Code)

set -e
G='\033[0;32m' Y='\033[1;33m' R='\033[0;31m' B='\033[0;34m' W='\033[1m' N='\033[0m'

REPO="https://github.com/giggso/shay-rolls-claude.git"
INSTALL_DIR="$HOME/.shay-rolls-claude"
BIN_DIR="$HOME/.local/bin"

echo ""
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${W}  Shay-Rolls Claude — Installer${N}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""

# Pre-checks
command -v git      &>/dev/null || { echo -e "${R}❌ git required${N}"; exit 1; }
command -v python3  &>/dev/null || { echo -e "${R}❌ python3 required${N}"; exit 1; }
command -v claude   &>/dev/null || { echo -e "${Y}⚠️  Claude Code not found — install from anthropic.com/claude-code${N}"; }

# Download or update
if [ -d "$INSTALL_DIR/.git" ]; then
    echo -e "${B}Updating existing install...${N}"
    cd "$INSTALL_DIR" && git pull --quiet
    echo -e "${G}✅ Updated to latest${N}"
else
    echo -e "${B}Downloading Shay-Rolls Claude...${N}"
    git clone --quiet --depth=1 "$REPO" "$INSTALL_DIR"
    echo -e "${G}✅ Downloaded to $INSTALL_DIR${N}"
fi

# Make command globally available
mkdir -p "$BIN_DIR"
cat > "$BIN_DIR/shay-rolls-setup" << CMDEOF
#!/bin/bash
bash "$INSTALL_DIR/shay-rolls-setup.sh" "\$@"
CMDEOF
chmod +x "$BIN_DIR/shay-rolls-setup"

# Add to PATH if not already there
SHELL_RC=""
[ -f "$HOME/.zshrc"  ] && SHELL_RC="$HOME/.zshrc"
[ -f "$HOME/.bashrc" ] && SHELL_RC="$HOME/.bashrc"

if [ -n "$SHELL_RC" ] && ! grep -q "$BIN_DIR" "$SHELL_RC" 2>/dev/null; then
    echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_RC"
    echo -e "${G}✅ Added $BIN_DIR to PATH in $SHELL_RC${N}"
fi

export PATH="$PATH:$BIN_DIR"

echo ""
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo -e "${G}  ✅ Shay-Rolls installed${N}"
echo -e "${W}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${N}"
echo ""
echo -e "  To init any project:"
echo -e "  ${B}cd YourProject && shay-rolls-setup${N}"
echo ""
echo -e "  To update Shay-Rolls later:"
echo -e "  ${B}cd ~/.shay-rolls-claude && git pull${N}"
echo ""
echo -e "  To install Guard:"
echo -e "  ${B}curl -fsSL https://raw.githubusercontent.com/giggso/shay-rolls-claude-guard/main/install.sh | bash${N}"
echo ""
