#!/usr/bin/env bash
# =========================================================
# test_ubuntu_install.sh - Verify dotfiles bootstrap in Docker
# =========================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "🐳 [1/3] Checking Docker daemon status..."
if ! docker info >/dev/null 2>&1; then
    echo "❌ Error: Docker is not running or you do not have permission."
    exit 1
fi

echo "🐳 [2/3] Pulling latest Ubuntu base image..."
docker pull ubuntu:latest

echo "🐳 [3/3] Launching container and running bootstrap.sh in test mode..."
echo "---------------------------------------------------------"

# Run the test container:
# - Mounts the local dotfiles repo to /root/.mydotfiles
# - Installs sudo, curl, git (prerequisites)
# - Runs bootstrap.sh non-interactively (no TTY)
docker run --rm \
    -v "${DOTFILES_DIR}:/root/.mydotfiles" \
    ubuntu:latest \
    bash -c "
        echo '>>> Pre-installing setup dependencies...' &&
        apt-get update -y &&
        apt-get install -y --no-install-recommends sudo curl git ca-certificates &&
        echo '>>> Running bootstrap.sh in non-interactive mode...' &&
        cd /root/.mydotfiles &&
        export DEBIAN_FRONTEND=noninteractive &&
        ./bootstrap.sh
    "

echo "---------------------------------------------------------"
echo "✅ [SUCCESS] Dotfiles installation completed cleanly on Ubuntu!"
