#!/usr/bin/env bash
set -e

echo ">>> Installing user fonts ..."

dotfilesDir="$(cd "$(dirname "$0")" && pwd)"
fontSrc="${dotfilesDir}/fonts"
fontDst="${HOME}/.local/share/fonts"

# ensure ~/.local/share exists
mkdir -p "$(dirname "$fontDst")"

if [ -d "$fontDst" ] && [ ! -L "$fontDst" ]; then
    echo ">>> Backing up existing fonts to ${fontDst}.bck"
    mv "$fontDst" "${fontDst}.bck"
fi

# tạo symlink
ln -sfn "$fontSrc" "$fontDst"

fc-cache -fv > /dev/null
echo ">>> Font setup complete!"

