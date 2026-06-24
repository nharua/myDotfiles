#!/usr/bin/env bash
set -e

echo ">>> Installing user fonts ..."

dotfilesDir="$(cd "$(dirname "$0")/.." && pwd)"
fontSrc="${dotfilesDir}/fonts"
OS_TYPE="$(uname -s)"

if [ "$OS_TYPE" = "Darwin" ]; then
    fontDst="${HOME}/Library/Fonts"
    echo ">>> macOS detected: installing fonts to $fontDst"
    mkdir -p "$fontDst"
    # Create symlinks for individual font files in macOS Fonts folder
    find "$fontSrc" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec ln -sf {} "$fontDst/" \;
    echo ">>> Font setup complete!"
else
    fontDst="${HOME}/.local/share/fonts"

    # ensure ~/.local/share exists
    mkdir -p "$(dirname "$fontDst")"

    if [ -d "$fontDst" ] && [ ! -L "$fontDst" ]; then
        echo ">>> Backing up existing fonts to ${fontDst}.bck"
        mv "$fontDst" "${fontDst}.bck"
    fi

    # tạo symlink
    ln -sfn "$fontSrc" "$fontDst"

    if command -v fc-cache &>/dev/null; then
        fc-cache -fv > /dev/null
    fi
    echo ">>> Font setup complete!"
fi

