#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OH_MY_ZSH_DIR="$DOTFILES_DIR/oh-my-zsh"
ZSH_TARGET="$HOME/.oh-my-zsh"
ZSHRC_TARGET="$HOME/.zshrc"
BACKUP_DIR="$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"

echo ">>> Setting up Zsh + Oh My Zsh (offline-friendly, safe backup)..."

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

# --- Backup existing ~/.oh-my-zsh if exists ---
if [ -d "$ZSH_TARGET" ] || [ -L "$ZSH_TARGET" ]; then
    echo ">>> Backing up existing ~/.oh-my-zsh to $BACKUP_DIR"
    mv "$ZSH_TARGET" "$BACKUP_DIR"
fi

# --- Clone or update Oh My Zsh in dotfiles ---
if [ "$ONLINE" = true ]; then
    echo ">>> Internet available: cloning/updating Oh My Zsh..."
    if [ -d "$OH_MY_ZSH_DIR/.git" ]; then
        git -C "$OH_MY_ZSH_DIR" pull --rebase
    else
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR"
    fi
    VERSION=$(git -C "$OH_MY_ZSH_DIR" rev-parse --short HEAD)
    echo ">>> Oh My Zsh version: $VERSION"
else
    echo ">>> No internet: using Oh My Zsh from dotfiles"
    if [ ! -d "$OH_MY_ZSH_DIR" ]; then
        echo "❌ ERROR: Oh My Zsh not found in dotfiles, cannot continue."
        exit 1
    fi
fi

# --- Symlink ~/.oh-my-zsh ---
ln -sf "$OH_MY_ZSH_DIR" "$ZSH_TARGET"
echo ">>> Symlink created: $ZSH_TARGET -> $OH_MY_ZSH_DIR"

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
fi

# --- Change default shell if needed ---
if [ "$SHELL" != "$(which zsh)" ] && [ "$(uname -s)" != "Darwin" ]; then
    echo ">>> Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

echo ">>> Zsh setup complete!"
