#!/usr/bin/env bash
# =========================================================
# setup_commitizen.sh - Automates installation and configuration of Commitizen
# =========================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CZRC_TARGET="$HOME/.czrc"
BACKUP_DIR="$HOME/.czrc.backup.$(date +%Y%m%d%H%M%S)"

echo ">>> Setting up Commitizen (Global)..."

# 1. Install necessary packages via NPM globally
if command -v npm >/dev/null 2>&1; then
    echo ">>> Checking and installing Commitizen globally..."
    if ! command -v cz >/dev/null 2>&1; then
        echo ">>> Installing commitizen and cz-conventional-changelog globally..."
        sudo npm install -g commitizen cz-conventional-changelog || npm install -g commitizen cz-conventional-changelog || true
    fi
    
    if ! command -v cz >/dev/null 2>&1; then
        echo "⚠️ Warning: Failed to automatically install Commitizen globally."
        echo "👉 Please run the following command manually to complete installation:"
        echo "   sudo npm install -g commitizen cz-conventional-changelog"
    else
        echo ">>> ✅ Commitizen has been successfully installed."
    fi
else
    echo "⚠️ Warning: npm is not installed. Please install Node.js & npm first."
fi

# 2. Create Symlink for the .czrc configuration file
if [ -f "$DOTFILES_DIR/.czrc" ]; then
    if [ -f "$CZRC_TARGET" ] || [ -L "$CZRC_TARGET" ]; then
        echo ">>> Backing up existing .czrc configuration to $BACKUP_DIR"
        mv "$CZRC_TARGET" "$BACKUP_DIR"
    fi
    ln -sf "$DOTFILES_DIR/.czrc" "$CZRC_TARGET"
    echo ">>> ✅ Symlink created: $CZRC_TARGET -> $DOTFILES_DIR/.czrc"
else
    echo "❌ Error: .czrc file not found in dotfiles."
    exit 1
fi

echo ">>> Commitizen setup complete!"
