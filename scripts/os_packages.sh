#!/usr/bin/env bash
set -e

# --- Enable universe repository (needed for fzf, etc.) ---
echo "Enabling universe repository..."
sudo add-apt-repository -y universe
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ noble-updates universe"
sudo apt update -y

echo ">>> Updating system..."
sudo apt update && sudo apt upgrade -y

# ---------------------------------------------------------
# Base developer packages
# ---------------------------------------------------------
echo ">>> Installing base packages..."
sudo apt install -y --no-install-recommends \
	git curl wget build-essential neofetch\
	unzip zip ripgrep fd-find \
	zsh tmux btop \
	python3-pip python3-venv \
	fzf bat exa zoxide meld git-delta gpg\
	fonts-firacode

# ---------------------------------------------------------
# eza setup
# ---------------------------------------------------------
sudo mkdir -p /etc/apt/keyrings
wget -qO- --inet4-only https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# ---------------------------------------------------------
# nvim setup
# ---------------------------------------------------------
sudo apt install -y python3-neovim luarocks
sudo luarocks install jsregexp
sudo pip3 install pynvim --upgrade
sudo curl -sL "https://deb.nodesource.com/setup_22.x" | sudo -E bash -
sudo apt install -y nodejs

# ---------------------------------------------------------
# SSH server setup
# ---------------------------------------------------------
echo ">>> Installing and enabling SSH server..."
sudo apt install -y --no-install-recommends openssh-server

# Enable and start the SSH service
sudo systemctl enable ssh
sudo systemctl start ssh

# Optionally check status
sudo systemctl status ssh --no-pager || true

# ---------------------------------------------------------
# Convenience links (Ubuntu-specific renames)
# ---------------------------------------------------------
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat || true
ln -sf /usr/bin/fdfind ~/.local/bin/fd || true

# ---------------------------------------------------------
# Add-on packages (forDEV)
# ---------------------------------------------------------
sudo apt install -y --no-install-recommends autoconf automake libtool

# --- Clean up ---
echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

echo ">>> Packages installed!"
