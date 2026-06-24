# =========================================================
# Navigation & Directory Listing (eza replacements)
# =========================================================

alias ls='eza --group-directories-first --icons'
alias l='ls -lah'
alias ll='eza -lh --icons --git --group-directories-first'
alias la='eza -lah --icons --git --group-directories-first'
alias lt='eza --tree --icons'
alias tree='eza --tree --icons'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

alias -- -='cd -'  # cd to previous directory

# Follow lf navigation if installed
lf() {
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# =========================================================
# Core utilities & Modern Alternatives
# =========================================================

alias cat='bat'
alias bcat='bat --pager="less --RAW-CONTROL-CHARS --no-init"'
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias find='fd'
alias vim='nvim'
alias tmux='TERM=xterm-256color tmux'

# =========================================================
# Git
# =========================================================

alias cz='git cz'
alias glog='PAGER="less -F -X" git log'  # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.mydotfiles/.git --work-tree=$HOME/.mydotfiles'

# =========================================================
# Fuzzy Finder (fzf) Integrations
# =========================================================

alias fp='fzf --preview="bat --color=always {}"'
alias fv='nvim $(fzf -m --preview="bat --color=always {}")'

# fzf rg bat integration
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

# =========================================================
# System Maintenance
# =========================================================

alias upgrade='
(date; echo "Starting full system upgrade...") | tee -a ~/upgrade.log &&
sudo apt update &&
sudo apt upgrade -y &&
sudo apt dist-upgrade -y &&
sudo apt autoremove -y &&
command -v brew >/dev/null && brew update && brew upgrade && brew cleanup
'

# =========================================================
# Remote Desktop (RDP) Aliases
# =========================================================

alias rdp2k_39='xfreerdp /v:192.168.1.39 /u:vber_vinhhuynhv +clipboard /size:2560x1400 /gfx /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
alias rdp_39='xfreerdp /v:192.168.1.39 /u:vber_vinhhuynhv +clipboard /size:1920x1080 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'

alias rdp2k_36='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:2560x1400 /gfx /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
alias rdp_36='xfreerdp /v:192.168.1.36 /u:vber_vinhhuynhv +clipboard /size:1920x1080 /gfx +gfx-progressive +async-input +async-update /bpp:16 /compression /network:lan /sound:sys:alsa /cert:ignore /heartbeat /auto-reconnect /auto-reconnect-max-retries:10 -wallpaper -themes -menu-anims -window-drag -fonts -aero'
