# --- Local bin ---
export PATH="$HOME/.local/bin:$PATH"

# Path 'Oh My Zsh'
export ZSH="$HOME/.oh-my-zsh"

# Theme
#ZSH_THEME="amuse"
#ZSH_THEME="spaceship"
ZSH_THEME="agnosterzak"

# Enable plugins (example)
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
unsetopt share_history # Do not share history with other sessions
setopt append_history # Append to the history file, don't overwrite it
setopt inc_append_history # Write to the history file immediately, not at the end of the sessions
setopt extended_history # Save timestamps in history
setopt hist_expire_dups_first # Expire duplicates first when trimming share_history
setopt hist_ignore_dups # Ignore duplicate commands in history
setopt hist_verify # Verify history expansion before executing

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- fzf (fuzzy finder) ----
# Set up fzf key bindings and fuzzy completion 
source <(fzf --zsh)


alias fp='fzf --preview="bat --color=always {}"'
alias fv='nvim $(fzf -m --preview="bat --color=always {}")'
# >>> fzf rg bat integration
function frg {
    result=`rg --ignore-case --color=always --line-number --no-heading "$@" |
      fzf --ansi \
          --color 'hl:-1:underline,hl+:-1:underline:reverse' \
          --delimiter ':' \
          --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
          --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'`
    file="${result%%:*}"
    linenumber=`echo "${result}" | cut -d: -f2`
    if [ ! -z "$file" ]; then
        nvim +"${linenumber}" "$file"
    fi
}
# system aliases
alias -- bcat='bat --pager='\''less --RAW-CONTROL-CHARS --no-init'\'''
alias -- cz='git cz'
# -allias -- cd=z
alias -- find=fd
alias -- grep='grep --color=auto'
alias -- l='ls -lah'
alias -- la='eza -a --group-directories-first'
alias -- ll='eza -la --group-directories-first'
alias -- ls='eza --group-directories-first'
alias -- lt='eza --tree'
alias -- tmux='TERM=xterm-256color tmux'
# alias upgrade='(date; echo "Starting full system upgrade...") | tee -a ~/upgrade.log && sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && brew update && brew upgrade && brew cleanup && conda update -n base -c defaults conda -y && conda clean --all -y | tee -a ~/upgrade.log'
alias upgrade='
(date; echo "Starting full system upgrade...") | tee -a ~/upgrade.log &&
sudo apt update &&
sudo apt upgrade -y &&
sudo apt dist-upgrade -y &&
sudo apt autoremove -y &&
command -v brew >/dev/null && brew update && brew upgrade && brew cleanup
'
alias -- rdp2k_39='xfreerdp /v:192.168.1.39 /u:vber_vinhhuynhv +clipboard /size:2560x1400 /gfx /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
alias -- rdp_39='xfreerdp /v:192.168.1.39 /u:vber_vinhhuynhv +clipboard /size:1920x1080 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
# alias -- rdp2k='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:2560x1400 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
# alias -- rdp='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:1920x1080 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /reconnect-cookie /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
alias -- rdp2k_36='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:2560x1400 /gfx /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
alias -- rdp_36='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:1920x1080 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'


# ---- Custom DNS Switcher ----
# Dynamically locate the dotfiles directory by resolving the sourced .zshrc path or ~/.zshrc symlink
local _zshrc_path="${(%):-%x}"
local _dotfiles_dir
if [[ "$_zshrc_path" == *zshrc* ]]; then
    _dotfiles_dir="${_zshrc_path:A:h}"
else
    local _zshrc_symlink="$HOME/.zshrc"
    _dotfiles_dir="${_zshrc_symlink:A:h}"
fi

if [ -f "$_dotfiles_dir/scripts/setup_dns.sh" ]; then
    source "$_dotfiles_dir/scripts/setup_dns.sh"
fi

# Added by Antigravity CLI installer
export PATH="/home/rua/.local/bin:$PATH"
