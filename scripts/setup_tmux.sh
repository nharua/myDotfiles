#!/usr/bin/env bash
set -e

echo ">>> Setting up tmux environment ..."

dotfilesDir="$(cd "$(dirname "$0")/.." && pwd)"

tmuxfile="${HOME}/.tmux.conf"
tmuxfolder="${HOME}/.tmux"

# Backup old .tmux.conf
if [ -f "$tmuxfile" ] || [ -L "$tmuxfile" ]; then
    echo ">>> Backing up existing .tmux.conf to ${tmuxfile}.bck"
    mv "$tmuxfile" "${tmuxfile}.bck_$(date +%Y%m%d_%H%M%S)"
fi

# Backup old .tmux folder
if [ -d "$tmuxfolder" ]; then
    echo ">>> Backing up existing .tmux folder to ${tmuxfolder}.bck"
    mv "$tmuxfolder" "${tmuxfolder}.bck_$(date +%Y%m%d_%H%M%S)"
fi

# Create symlinks
ln -sfn "${dotfilesDir}/tmux" "${HOME}/.tmux"
ln -sfn "${dotfilesDir}/.tmux.conf" "${HOME}/.tmux.conf"

echo ">>> Tmux setup complete!"

