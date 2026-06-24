#!/usr/bin/env bash
# =========================================================
# setup_nvim.sh - Install latest Neovim (AppImage version)
# Author: Vinh Huynh
# =========================================================

set -e

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
DOTFILES_NVIM="$DOTFILES/nvim"

OS_TYPE="$(uname -s)"

if [ "$OS_TYPE" = "Darwin" ]; then
    echo ">>> macOS detected: installing Neovim via Homebrew..."
    if ! command -v nvim &>/dev/null; then
        brew install neovim
    else
        echo ">>> Neovim is already installed."
    fi
else
    echo ">>> Removing old Neovim from apt..."
    sudo apt remove --purge -y neovim || true
    sudo apt autoremove -y

    # Optional cleanup
    sudo rm -f /usr/bin/nvim /usr/local/bin/nvim 2>/dev/null || true

    # ---------------------------------------------------------
    # Install latest Neovim AppImage
    # ---------------------------------------------------------
    echo ">>> Installing latest Neovim AppImage..."
    cd /tmp

    # Download the latest stable AppImage
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

    # Make it executable
    chmod u+x nvim-linux-x86_64.appimage

    # Extract AppImage to avoid FUSE dependency
    ./nvim-linux-x86_64.appimage --appimage-extract
    sudo rm -rf /opt/nvim
    sudo mv squashfs-root /opt/nvim

    # Create shortcut "nvim"
    sudo ln -sf /opt/nvim/AppRun /usr/local/bin/nvim
    rm -f nvim-linux-x86_64.appimage
fi

# ---------------------------------------------------------
# Verify installation
# ---------------------------------------------------------
echo ">>> Verifying Neovim version..."
nvim_version=$(nvim --version | head -n 1)
echo "✅ $nvim_version installed successfully!"

# ---------------------------------------------------------
# Optional: Setup config folder if missing
# ---------------------------------------------------------


if [ ! -d "$NVIM_CONFIG" ] && [ -d "$DOTFILES_NVIM" ]; then
	echo ">>> Linking Neovim config..."
	mkdir -p "$(dirname "$NVIM_CONFIG")"
	ln -sf "$DOTFILES_NVIM" "$NVIM_CONFIG"
fi

echo ">>> Neovim setup complete! 🚀"
