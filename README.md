# Dotfiles

My personal configuration files for Linux development environment.

## Structure

```
.
├── nvim/              # Neovim configuration
│   ├── UltiSnips/     # Code snippets
│   ├── lsp/           # LSP configurations
│   └── lua/           # Lua configurations
├── oh-my-zsh/         # Zsh customizations
├── scripts/           # Setup and utility scripts
│   ├── os_packages.sh
│   ├── setup_fonts.sh
│   ├── setup_git.sh
│   ├── setup_nvim.sh
│   ├── setup_tmux.sh
│   └── setup_zsh.sh
├── tmux/              # Tmux configurations
├── .gitignore
├── .tmux.conf
├── .zshrc
└── bootstrap.sh       # Main installation script
```

## Installation

1. Clone this repository:
```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

2. Run the bootstrap script:
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

Or install components individually:
```bash
chmod +x scripts/*.sh
./scripts/setup_git.sh
./scripts/setup_zsh.sh
./scripts/setup_nvim.sh
./scripts/setup_tmux.sh
```

## Components

- **Neovim**: Modern text editor configuration with LSP support
- **Zsh**: Shell configuration with Oh My Zsh
- **Tmux**: Terminal multiplexer setup
- **Git**: Version control aliases and settings

## Requirements

- Ubuntu/Debian-based Linux distribution
- Git
- Curl

## Notes

- Backup your existing configurations before running the installation
- The scripts will create symbolic links from this repo to your home directory
- SSH service will be enabled and started during installation

## License

Personal use only.
