#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ZSHRC_TARGET="$HOME/.zshrc"
BACKUP_DIR="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"

echo ">>> Setting up Zsh (offline-friendly, safe backup)..."

# --- Ensure ~/.local/bin exists ---
mkdir -p ~/.local/bin

# --- Check Internet connectivity ---
if curl -s --head https://github.com > /dev/null; then
    ONLINE=true
else
    ONLINE=false
fi

# --- Install Starship if not present ---
if ! command -v starship &>/dev/null; then
    echo ">>> Starship not found. Installing Starship..."
    if [ "$ONLINE" = true ]; then
        curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" -y
    else
        echo "⚠️ Warning: Offline mode, cannot download/install Starship automatically."
    fi
else
    echo ">>> Starship is already installed."
fi

# --- Symlink ~/.zshrc ---
if [ -f "$ZSHRC_TARGET" ] || [ -L "$ZSHRC_TARGET" ]; then
    echo ">>> Backing up existing ~/.zshrc to $BACKUP_DIR"
    mv "$ZSHRC_TARGET" "$BACKUP_DIR"
fi

if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    ln -sf "$DOTFILES_DIR/.zshrc" "$ZSHRC_TARGET"
    echo ">>> Symlink created: $ZSHRC_TARGET -> $DOTFILES_DIR/.zshrc"
else
    echo "⚠️ Warning: .zshrc not found in dotfiles, skipping symlink"
    exit 1
fi

# --- Change default shell if needed ---
if [ "$SHELL" != "$(which zsh)" ] && [ "$(uname -s)" != "Darwin" ]; then
    echo ">>> Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

echo ">>> Zsh setup complete!"
