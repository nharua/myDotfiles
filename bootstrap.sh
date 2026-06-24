#!/usr/bin/env bash
# =========================================================
# bootstrap.sh - orchestrator for modular dotfiles setup
# Author: Vinh Huynh
# =========================================================

set -e  # stop on error
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

echo ">>> Starting dotfiles setup..."

# ---------------------------------------------------------
# System-level preconfiguration
# ---------------------------------------------------------
echo "🔧 [0/8] Setting up system configurations..."

OS_TYPE="$(uname -s)"
if [ "$OS_TYPE" = "Linux" ]; then
    echo ">>> Configuring APT to skip recommended packages by default..."
    APT_CONF="/etc/apt/apt.conf.d/99no-recommends"
    if ! grep -q 'APT::Install-Recommends' "$APT_CONF" 2>/dev/null; then
        echo 'APT::Install-Recommends "false";' | sudo tee "$APT_CONF" > /dev/null
        echo ">>> APT configuration added: Install-Recommends=false"
    else
        echo ">>> APT configuration already set, skipping."
    fi
else
    echo ">>> macOS detected: skipping Linux APT recommendations configuration."
fi

# ---------------------------------------------------------
# Install OS packages and SSH server
# ---------------------------------------------------------
bash "$SCRIPTS_DIR/os_packages.sh" || true

# ---------------------------------------------------------
# Setup Zsh + Oh My Zsh
# ---------------------------------------------------------
bash "$SCRIPTS_DIR/setup_zsh.sh" || true

# ---------------------------------------------------------
# Setup Neovim (AppImage)
# ---------------------------------------------------------
if [ -f "$SCRIPTS_DIR/setup_nvim.sh" ]; then
	  bash "$SCRIPTS_DIR/setup_nvim.sh" || true
fi

# ---------------------------------------------------------
# Setup Git global config
# ---------------------------------------------------------
bash "$SCRIPTS_DIR/setup_git.sh" || true

# ---------------------------------------------------------
# Setup Commitizen
# ---------------------------------------------------------
if [ -f "$SCRIPTS_DIR/setup_commitizen.sh" ]; then
	bash "$SCRIPTS_DIR/setup_commitizen.sh" || true
fi

# ---------------------------------------------------------
# Setup Nerd Fonts
# ---------------------------------------------------------
bash "$SCRIPTS_DIR/setup_fonts.sh" || true

# ---------------------------------------------------------
# Setup Tmux
# ---------------------------------------------------------
bash "$SCRIPTS_DIR/setup_tmux.sh" || true

echo ">>> ✅ All done! 🎉"
echo "You may now restart your terminal or run: source ~/.zshrc"
