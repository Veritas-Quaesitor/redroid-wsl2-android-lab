#!/usr/bin/env bash

set -e

echo "========== HOST VERIFICATION =========="

echo "[INFO] Kernel version:"
uname -a

echo
echo "[INFO] Checking Binder support..."
if grep -q binder /proc/filesystems; then
    echo "[OK] Binder filesystem available"
else
    echo "[FAIL] Binder filesystem NOT available"
fi

echo
echo "[INFO] Checking binderfs mount..."
if mountpoint -q /dev/binderfs; then
    echo "[OK] binderfs is mounted"
    ls -la /dev/binderfs
else
    echo "[WARN] binderfs not mounted"
fi

echo
echo "[INFO] Checking /dev/kvm..."
if [ -e /dev/kvm ]; then
    echo "[OK] /dev/kvm present"
else
    echo "[WARN] /dev/kvm NOT found"
fi

echo
echo "[INFO] Checking Docker..."
if command -v docker >/dev/null 2>&1; then
    echo "[OK] Docker installed"
    docker ps >/dev/null 2>&1 && echo "[OK] Docker daemon running" || echo "[FAIL] Docker daemon NOT running"
else
    echo "[FAIL] Docker not installed"
fi

echo
echo "[INFO] Checking iptables mode..."
iptables -V || true

echo
echo "[INFO] Checking ReDroid container..."
docker ps | grep -i redroid && echo "[OK] ReDroid running" || echo "[WARN] ReDroid not running"

echo
echo "========== VERIFICATION COMPLETE =========="