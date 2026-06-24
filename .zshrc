# =========================================================
# .zshrc - Modern Zsh Configuration Entry Point
# Author: Vinh Huynh (Restructured following "The Perfect Zsh Setup For 2026")
# =========================================================

# --- Paths & Env ---
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Dynamically locate the dotfiles directory
local _zshrc_path="${(%):-%x}"
local _dotfiles_dir
if [[ "$_zshrc_path" == *zshrc* ]]; then
    _dotfiles_dir="${_zshrc_path:A:h}"
else
    local _zshrc_symlink="$HOME/.zshrc"
    _dotfiles_dir="${_zshrc_symlink:A:h}"
fi

export ZSH_CONFIG_DIR="$_dotfiles_dir/zsh"
export STARSHIP_CONFIG="$ZSH_CONFIG_DIR/starship.toml"

# =========================================================
# History Settings (Preserving user preference)
# =========================================================
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000

unsetopt share_history          # Do not share history with other sessions
setopt append_history           # Append to the history file, don't overwrite it
setopt inc_append_history       # Write to the history file immediately
setopt extended_history         # Save timestamps in history
setopt hist_expire_dups_first   # Expire duplicates first when trimming history
setopt hist_ignore_dups         # Ignore duplicate commands in history
setopt hist_verify              # Verify history expansion before executing
setopt HIST_IGNORE_SPACE        # Do not record lines starting with space

# =========================================================
# Shell Behavior Options
# =========================================================
setopt AUTOCD                   # cd by typing directory name only
setopt NOBEEP                   # Disable annoying beeps
setopt NUMERIC_GLOB_SORT        # Sort file10 after file9, not after file1

# =========================================================
# Smart Directory Navigation & Fuzzy Finder
# =========================================================
eval "$(zoxide init zsh)"
source <(fzf --zsh)

# =========================================================
# Completions
# =========================================================
autoload -Uz compinit
mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completions

# =========================================================
# Modular Config Files
# =========================================================
[[ -f "$ZSH_CONFIG_DIR/fzf.zsh" ]] && source "$ZSH_CONFIG_DIR/fzf.zsh"
[[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ]] && source "$ZSH_CONFIG_DIR/aliases.zsh"
[[ -f "$ZSH_CONFIG_DIR/bindings.zsh" ]] && source "$ZSH_CONFIG_DIR/bindings.zsh"
[[ -f "$ZSH_CONFIG_DIR/plugins.zsh" ]] && source "$ZSH_CONFIG_DIR/plugins.zsh"
[[ -f "$ZSH_CONFIG_DIR/prompt.zsh" ]] && source "$ZSH_CONFIG_DIR/prompt.zsh"

# =========================================================
# Custom DNS Switcher
# =========================================================
if [ -f "$_dotfiles_dir/scripts/setup_dns.sh" ]; then
    source "$_dotfiles_dir/scripts/setup_dns.sh"
fi

# =========================================================
# Welcome Banner (Pokemon-colorscripts + fastfetch)
# =========================================================
if [[ -o interactive ]]; then
    if command -v pokemon-colorscripts &>/dev/null && command -v fastfetch &>/dev/null && [[ -f "$HOME/.config/fastfetch/config-pokemon.jsonc" ]]; then
        pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -
    elif command -v fastfetch &>/dev/null; then
        fastfetch
    fi
fi
