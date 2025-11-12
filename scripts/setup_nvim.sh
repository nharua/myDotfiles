#!/usr/bin/env bash
# =========================================================
# setup_nvim.sh - Install latest Neovim (AppImage version)
# Author: Vinh Huynh
# =========================================================

set -e

echo ">>> Removing old Neovim from apt..."
sudo apt remove --purge -y neovim || true
sudo apt autoremove -y

# Optional cleanup
sudo rm -f /usr/bin/nvim 2>/dev/null || true

# ---------------------------------------------------------
# Install latest Neovim AppImage
# ---------------------------------------------------------
echo ">>> Installing latest Neovim AppImage..."
cd ~/.local/bin

# Download the latest stable AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

# Make it executable
chmod u+x nvim-linux-x86_64.appimage

# Create shortcut "nvim"
ln -sf ~/.local/bin/nvim-linux-x86_64.appimage ~/.local/bin/nvim

# ---------------------------------------------------------
# Verify installation
# ---------------------------------------------------------
echo ">>> Verifying Neovim version..."
nvim_version=$(~/.local/bin/nvim --version | head -n 1)
echo "✅ $nvim_version installed successfully!"

# ---------------------------------------------------------
# Optional: Setup config folder if missing
# ---------------------------------------------------------
NVIM_CONFIG="$HOME/.config/nvim"
DOTFILES_NVIM="$HOME/.dotfiles/nvim"

if [ ! -d "$NVIM_CONFIG" ] && [ -d "$DOTFILES_NVIM" ]; then
	  echo ">>> Linking Neovim config..."
	    mkdir -p "$(dirname "$NVIM_CONFIG")"
	      ln -sf "$DOTFILES_NVIM" "$NVIM_CONFIG"
fi

echo ">>> Neovim setup complete! 🚀"
