#!/usr/bin/env bash
# =========================================================
# setup_nvim.sh - Install latest Neovim (AppImage version)
# Author: Vinh Huynh
# =========================================================

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
DOTFILES_NVIM="$DOTFILES/nvim"

echo ">>> Removing old Neovim from apt..."
sudo apt remove --purge -y neovim || true
sudo apt autoremove -y

# Optional cleanup
sudo rm -f /usr/bin/nvim 2>/dev/null || true

# ---------------------------------------------------------
# Install latest Neovim AppImage
# ---------------------------------------------------------
echo ">>> Installing latest Neovim AppImage..."
cd /usr/local/bin

# Download the latest stable AppImage
sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

# Make it executable
sudo chmod u+x nvim-linux-x86_64.appimage

# Create shortcut "nvim"
sudo ln -sf /usr/local/bin/nvim-linux-x86_64.appimage /usr/local/bin/nvim

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
