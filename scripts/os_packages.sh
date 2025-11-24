#!/usr/bin/env bash
set -e

# --- Enable universe repository (needed for fzf, etc.) ---
echo "Enabling universe repository..."
sudo add-apt-repository -y universe
sudo apt update -y

echo ">>> Updating system..."
sudo apt update && sudo apt upgrade -y

# ---------------------------------------------------------
# Base developer packages
# ---------------------------------------------------------
echo ">>> Installing base packages..."
sudo apt install -y --no-install-recommends \
	git curl wget build-essential neofetch\
	unzip zip \
	zsh btop \
	python3-pip python3-venv \
	meld gpg\
	fonts-firacode xsel

# ---------------------------------------------------------
# ripgrep setup
# ---------------------------------------------------------
echo ">>> Installing ripgrep..."
cd /tmp
wget -q --inet4-only https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep_15.1.0-1_amd64.deb
sudo dpkg -i ripgrep_15.1.0-1_amd64.deb
cd -

# ---------------------------------------------------------
# batcat setup
# ---------------------------------------------------------
echo ">>> Installing batcat..."
cd /tmp
wget -q --inet4-only wget https://github.com/sharkdp/bat/releases/download/v0.26.0/bat_0.26.0_amd64.deb
sudo dpkg -i bat_0.26.0_amd64.deb
cd -

# ---------------------------------------------------------
# fd-find setup
# ---------------------------------------------------------
echo ">>> Installing fd-find ..."
cd /tmp
wget -q --inet4-only https://github.com/sharkdp/fd/releases/download/v10.3.0/fd_10.3.0_amd64.deb
sudo dpkg -i ripgrep_15.1.0-1_amd64.deb
cd -

# ---------------------------------------------------------
# fzf setup
# ---------------------------------------------------------
echo ">>> Installing fzf..."
cd /tmp
wget -q --inet4-only https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz
tar -zxvf fzf-0.67.0-linux_amd64.tar.gz
sudo mv fzf /usr/local/bin
cd -

# ---------------------------------------------------------
# tmux AppImage setup
# ---------------------------------------------------------
echo ">>> Installing tmux AppImage..."
cd /tmp
wget -q --inet4-only https://github.com/nelsonenzo/tmux-appimage/releases/download/3.5a/tmux.appimage
chmod u+x tmux.appimage
sudo mv tmux.appimage /usr/local/bin/tmux
cd -

# ---------------------------------------------------------
# zoxide (a ls command) setup
# ---------------------------------------------------------
echo ">>> Installing zoxide..."
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sudo sh -s -- --bin-dir /usr/local/bin --man-dir /usr/local/share/man

# ---------------------------------------------------------
# git-delta setup
# ---------------------------------------------------------
echo ">>> Installing git-delta ..."
cd /tmp
wget -q --inet4-only https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
sudo dpkg -i git-delta_0.18.2_amd64.deb 
cd -

# ---------------------------------------------------------
# eza setup
# ---------------------------------------------------------
echo ">>> Installing eza (latest from GitHub)..."
cd /tmp
wget -q --inet4-only https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
sudo chmod +x eza
sudo chown root:root eza
sudo mv eza /usr/local/bin/
sudo rm -f /usr/local/bin/exa
sudo ln -s /usr/local/bin/eza /usr/local/bin/exa
cd -

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
