# Project Summary - Dotfiles Setup & Modernization

This document tracks the history of sessions, tasks completed, modifications made, and next steps for the personal development environment configuration repository.

---

## Session 1 - 2026-06-24

### Task
Modularize the Zsh configuration, integrate the Starship prompt, resolve FZF search overrides, and implement multi-platform (Linux/macOS) support with automated verification pipelines (Docker + GitHub Actions).

### What was done
- Modularized `.zshrc` by breaking settings into dedicated modules inside `zsh/` (`aliases.zsh`, `bindings.zsh`, `fzf.zsh`, `plugins.zsh`, `prompt.zsh`, `starship.toml`).
- Setup an automatic, framework-free Zsh plugin downloader for `zsh-autosuggestions`, `fast-syntax-highlighting`, `zsh-history-substring-search`, and `zsh-vi-mode`.
- Fixed the FZF keybinding conflict by explicitly binding `fzf-history-widget` and `fzf-file-widget` inside the `zvm_after_init()` hook.
- Added dynamic OS checks at runtime in all installation scripts (`bootstrap.sh`, `os_packages.sh`, `setup_zsh.sh`, `setup_nvim.sh`, `setup_fonts.sh`, `setup_git.sh`, `setup_dns.sh`) to support macOS (using Homebrew) and Linux (using APT/AppImages).
- Fixed the `fd-find` installation bug on Linux where it targeted the `ripgrep` package.
- Upgraded the `dns` toggle function to support macOS using the native `networksetup` commands.
- Created `scripts/test_ubuntu_install.sh` to run non-interactive test installations inside a clean local Docker container (`ubuntu:latest`).
- Integrated GitHub Actions CI (`.github/workflows/verify.yml`) to automatically test the bootstrap installation on a clean Ubuntu runner on every push.

### Files modified
- `.zshrc` - Entry point refactoring to load modular Zsh configurations dynamically.
- `zsh/aliases.zsh` - System navigation, modern tool aliases, and RDP shortcuts.
- `zsh/bindings.zsh` - Keybinds and Vi mode integration hooks.
- `zsh/fzf.zsh` - Fuzzy finder config.
- `zsh/plugins.zsh` - Framework-free plugin loader.
- `zsh/prompt.zsh` & `zsh/starship.toml` - Prompt themes.
- `bootstrap.sh` - Orchestration script with dynamic directory mapping and OS boundaries.
- `scripts/os_packages.sh` - macOS Homebrew branches and bug fix for fd-find installation.
- `scripts/setup_zsh.sh` - Default shell configurations and auto-install of Starship.
- `scripts/setup_nvim.sh` - macOS Brew vs Linux AppImage installation switch.
- `scripts/setup_fonts.sh` - Custom macOS font path logic.
- `scripts/setup_git.sh` - TTY check for non-blocking runs.
- `scripts/setup_dns.sh` - macOS compatibility using `networksetup`.
- `scripts/test_ubuntu_install.sh` - Docker test utility.
- `.github/workflows/verify.yml` - CI configuration.
- `README.md` - Complete document rewrite.

### TODO / Next Steps
- [ ] Verify the bootstrap script on a physical macOS device.
- [ ] Add more platform-specific aliases or utilities if needed.
- [ ] Customize Starship prompt style or Fastfetch welcome message.

### Notes
- Local verification using `test_ubuntu_install.sh` successfully passed.
- SSH Port forwarding (port `8888`) must be set up to enable Markdown/Mermaid previews on remote workspaces.

---

## Session 2 - 2026-06-29

### Task
Fix Neovim FUSE and Python provider issues in Docker/minimal environments, support NodeSource (Nsolid) 24.x installation for Commitizen, and purge the unused Oh My Zsh dependency to keep the dotfiles repository completely lightweight and framework-free.

### What was done
- **FUSE-less Neovim Setup**: Refactored the Linux Neovim installer (`scripts/setup_nvim.sh`) to extract the AppImage (`--appimage-extract`) into `/opt/nvim`, bypassing the lack of FUSE inside Docker containers and minimal environments.
- **NodeSource Nsolid 24.x**: Switched the Node.js setup in `scripts/os_packages.sh` to configure the NodeSource 24.x repository and install `nsolid` for explicit Node.js and NPM version control, resolving global Commitizen installation warnings.
- **Python 3 Provider Fix**: Installed `python3-pynvim` via APT and added `--break-system-packages` with a fallback to `pip3 install pynvim` to prevent PEP 668 blockages in Ubuntu 24.04/26.04.
- **Removed Oh My Zsh**: Purged the unused `oh-my-zsh` submodule/nested repository and all associated cloning, updating, and symlinking logic from `scripts/setup_zsh.sh` and `.gitignore`, transitioning fully to our lightweight, framework-free Zsh plugin loader.
- **Docker Verification**: Verified the entire bootstrap installation process end-to-end inside a clean Ubuntu Docker container, ensuring a 100% clean exit code (0) and error-free shell startup.

### Files modified
- `scripts/os_packages.sh` - Added NodeSource Nsolid 24.x setup, replaced deprecated `neofetch` with `fastfetch`, updated python3 provider package to `python3-pynvim`, and removed duplicate Node.js installation blocks.
- `scripts/setup_nvim.sh` - Refactored Linux AppImage extraction to run without FUSE dependencies.
- `scripts/setup_zsh.sh` - Removed all Oh My Zsh cloning, updating, and symlinking code.
- `.zshrc` - Added `/usr/local/bin` and `/usr/local/sbin` to the PATH, and added safety checks and fallbacks to the Welcome Banner.
- `.gitignore` - Cleaned up unused Oh My Zsh ignore rules.

### TODO / Next Steps
- [ ] Verify the bootstrap script on a physical macOS device.
- [ ] Add more platform-specific aliases or utilities if needed.
- [ ] Customize Starship prompt style or Fastfetch welcome message.

### Notes
- Local verification using `test_ubuntu_install.sh` successfully passed.
- Removing Oh My Zsh from Git tracking required a git push to purge the tracked files from the remote repository.

---

## Session 3 - 2026-07-02

### Task
Fix Python virtual environment (venv) display in Starship prompt when sourced.

### What was done
- Added the `$python` module to the Starship prompt layout `format` string.
- Configured the `[python]` module in Starship with a yellow color scheme and standard Python symbol ` ` to match existing language settings.
- Verified Starship configuration and prompt rendering under different virtualenv activation states.

### Files modified
- `zsh/starship.toml` - Added `$python` module to format string and defined `[python]` configuration layout.

### TODO / Next Steps
- [ ] Verify the bootstrap script on a physical macOS device.
- [ ] Add more platform-specific aliases or utilities if needed.
- [ ] Customize Starship prompt style or Fastfetch welcome message further if needed.

### Notes
- Sourcing `.venv` correctly activates and exports the `VIRTUAL_ENV` variable. The `VIRTUAL_ENV_DISABLE_PROMPT=1` flag in `zsh/prompt.zsh` ensures Starship is responsible for rendering the virtualenv name without interference.
