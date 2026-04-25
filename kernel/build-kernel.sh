#!/usr/bin/env bash

set -euo pipefail

KERNEL_SOURCE_DIR="${KERNEL_SOURCE_DIR:-$HOME/git-repos/WSL2-Linux-Kernel}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
KERNEL_CONFIG="$REPO_ROOT/kernel/config/wsl-redroid-docker.config"
OUTPUT_DIR="/mnt/c/wsl-kernel"
OUTPUT_FILE="$OUTPUT_DIR/bzImage-redroid-docker-v2"

echo "[INFO] Repo root: $REPO_ROOT"
echo "[INFO] Kernel source: $KERNEL_SOURCE_DIR"
echo "[INFO] Kernel config: $KERNEL_CONFIG"
echo "[INFO] Output file: $OUTPUT_FILE"

if [ ! -d "$KERNEL_SOURCE_DIR" ]; then
    echo "[ERROR] Kernel source directory not found: $KERNEL_SOURCE_DIR"
    echo
    echo "Clone it first:"
    echo "  mkdir -p ~/git-repos"
    echo "  cd ~/git-repos"
    echo "  git clone --depth=1 https://github.com/microsoft/WSL2-Linux-Kernel.git"
    exit 1
fi

if [ ! -f "$KERNEL_CONFIG" ]; then
    echo "[ERROR] Kernel config not found: $KERNEL_CONFIG"
    exit 1
fi

echo "[INFO] Installing required build dependencies..."
sudo apt update
sudo apt install -y \
    build-essential \
    flex \
    bison \
    libssl-dev \
    libelf-dev \
    dwarves \
    bc \
    libncurses-dev \
    pkg-config

echo "[INFO] Applying repo kernel config..."
cd "$KERNEL_SOURCE_DIR"
cp "$KERNEL_CONFIG" .config

echo "[INFO] Normalizing config dependencies..."
make olddefconfig

echo "[INFO] Verifying critical config options..."
grep -E 'ANDROID_BINDER|BINDERFS|ADDRTYPE|IP_NF_RAW|IP6_NF_RAW|IP_NF_NAT|MASQUERADE|BRIDGE|VETH|OVERLAY_FS' .config || true

echo "[INFO] Building kernel..."
make -j"$(nproc)"

echo "[INFO] Copying bzImage..."
mkdir -p "$OUTPUT_DIR"
cp arch/x86/boot/bzImage "$OUTPUT_FILE"

echo "[SUCCESS] Kernel built:"
ls -lh "$OUTPUT_FILE"

echo
echo "Next step:"
echo "  Set %USERPROFILE%\\.wslconfig to:"
echo
echo "  [wsl2]"
echo "  kernel=C:\\\\wsl-kernel\\\\bzImage-redroid-docker-v2"
echo
echo "Then run from PowerShell:"
echo "  wsl --shutdown"