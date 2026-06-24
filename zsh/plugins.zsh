# =========================================================
# Lightweight Plugin Manager & Loader
# =========================================================

# Store cloned plugins in a standard local path to keep dotfiles clean
ZPLUGINDIR="$HOME/.local/share/zsh/plugins"

_zplugin_load() {
  local author="${1}"
  local repo="${2}"
  local plugin_path="${ZPLUGINDIR}/${repo}"
  
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing plugin: ${repo}..."
    git clone --depth=1 "https://github.com/${author}/${repo}" "$plugin_path" \
      || { echo "ERROR: failed to install ${repo}" >&2; return 1; }
  fi
  
  # Source plugin file (handles either repo.plugin.zsh or repo.zsh)
  if [[ -f "${plugin_path}/${repo}.plugin.zsh" ]]; then
    source "${plugin_path}/${repo}.plugin.zsh"
  elif [[ -f "${plugin_path}/${repo}.zsh" ]]; then
    source "${plugin_path}/${repo}.zsh"
  fi
}

# Update command to pull latest changes for all plugins
zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating plugin in ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# Load essential plugins
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode
_zplugin_load zdharma-continuum fast-syntax-highlighting
