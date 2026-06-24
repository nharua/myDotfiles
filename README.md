# 🛠️ NhàRua's Dotfiles

Personal configuration files for a high-performance Linux development environment. Fully modernized, modular, and optimized for speed and productivity.

---

## 📂 Repository Structure

```
.
├── nvim/                   # Neovim (LazyVim, LSP, Treesitter, Mermaid, Preview)
│   ├── lua/                # Lua plugin configurations & keymaps
│   └── init.lua            # Entry point for Neovim config
├── tmux/                   # Tmux configuration modules
│   └── tmux.conf           # Tmux configurations
├── zsh/                    # Modern Frameworkless Zsh Configurations (2026 guidelines)
│   ├── aliases.zsh         # Navigation, modern tools (eza, bat), & RDP shortcuts
│   ├── bindings.zsh        # Keybindings and Vi-mode cursor shapes
│   ├── fzf.zsh             # Fuzzy finder options & bat previews
│   ├── plugins.zsh         # Lightweight, auto-installing plugin loader
│   ├── prompt.zsh          # Starship prompt initializer
│   └── starship.toml       # Sleek, customized Starship prompt theme
├── scripts/                # Automations and helper scripts
│   ├── os_packages.sh      # OS package installations (Ubuntu/Debian)
│   ├── setup_commitizen.sh # Conventional commit setup
│   ├── setup_dns.sh        # Fast local DNS switcher
│   ├── setup_fonts.sh      # Developer & Nerd fonts installation
│   ├── setup_git.sh        # Global Git settings & signature configuration
│   ├── setup_nvim.sh       # Neovim installation script
│   ├── setup_tmux.sh       # Tmux environment setup
│   └── setup_zsh.sh        # Zsh symlinking & automatic Starship installation
├── .czrc                   # Commitizen global configuration
├── .gitignore              # Files ignored by Git
├── .tmux.conf              # Master Tmux configuration symlink
├── .zshrc                  # Master Zsh bootstrap script
└── bootstrap.sh            # Main installation orchestrator
```

---

## ⚡ Modern CLI Stack Included

This setup replaces bloated legacy frameworks with a lightweight, lightning-fast Rust/C toolchain:

| Tool | Alternative For | Description |
|---|---|---|
| **[Starship](https://starship.rs/)** | Oh My Zsh Prompts | The minimal, blazing-fast, and infinitely customizable shell prompt |
| **[zoxide](https://github.com/ajeetdsouza/zoxide)** | `cd` | A smarter cd command that learns your habits |
| **[fzf](https://github.com/junegunn/fzf)** | `ctrl+r` / `find` | General-purpose command-line fuzzy finder with previews |
| **[eza](https://github.com/eza-community/eza)** | `ls` | Modern replacement for ls with color, icons, and Git integration |
| **[bat](https://github.com/sharkdp/bat)** | `cat` | A cat clone with syntax highlighting and Git integration |
| **[ripgrep](https://github.com/BurntSushi/ripgrep)** | `grep` | Line-oriented search tool that recursively searches directories |
| **[fd](https://github.com/sharkdp/fd)** | `find` | Simple, fast, and user-friendly alternative to find |

---

## 🚀 Installation & Bootstrapping

### 1. Clone the Repository
Clone this repository to your home directory under `.mydotfiles`:
```bash
git clone https://github.com/nharua/myDotfiles.git ~/.mydotfiles
cd ~/.mydotfiles
```

### 2. Run the Bootstrap Orchestrator
Running `bootstrap.sh` will configure APT preferences, install all required developer tools, download fonts, link dotfiles, and launch Neovim/Tmux configurations:
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

### 3. Sourcing Changes
To load the Zsh configurations in your active shell:
```bash
source ~/.zshrc
```

---

## 🛠️ Component Details

### 1. Zsh (Modular Setup)
Configured using the "The Perfect Zsh Setup For 2026" guidelines:
- **No plugin managers:** Plugins (`zsh-autosuggestions`, `fast-syntax-highlighting`, `zsh-history-substring-search`, `zsh-vi-mode`) are automatically downloaded to `~/.local/share/zsh/plugins/` on startup.
- **Update plugins:** Run `zplugin-update` to automatically fetch and update all loaded plugins.
- **Vi Mode integration:** Safe keybindings integrated directly into `zvm_after_init()` to prevent `zsh-vi-mode` from overwriting `Ctrl+R` (fzf history search) and `Ctrl+T` (fzf file search).

### 2. Neovim
A modern configuration featuring:
- **Lazy.nvim** plugin manager.
- Full LSP & Treesitter setup for multiple languages.
- **[mermaid.nvim](https://github.com/kevalin/mermaid.nvim)**: Inline rendering, formatting, and linting of Mermaid diagrams.
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)**: Browser-based preview of Markdown files with Mermaid support. Set up to support SSH port forwarding on port `8888` via `ssh -L 8888:127.0.0.1:8888 <user>@<host>`.

### 3. Git & Commits
- Includes **Commitizen** (`cz`) configured globally (`~/.czrc`) to prompt for conventional commit guidelines.
- Standardized aliases included (`cz` -> `git cz`, `glog` for quick git logs, etc.).

### 4. Custom DNS Switcher
- Fast DNS profiles configured dynamically via `setup_dns.sh` integrated into `.zshrc`.

---

## 📋 Requirements
- **OS**: Ubuntu / Debian-based Linux distribution.
- **Prerequisites**: `git`, `curl`, `wget`, `sudo` permissions.

---

## 📄 License
Personal Use Only. Created and maintained by Vinh Huynh.
