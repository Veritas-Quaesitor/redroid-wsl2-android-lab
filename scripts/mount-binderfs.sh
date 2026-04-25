#!/usr/bin/env bash

set -e

echo "[INFO] Ensuring binderfs mount point exists..."
sudo mkdir -p /dev/binderfs

if mountpoint -q /dev/binderfs; then
    echo "[INFO] binderfs already mounted"
else
    echo "[INFO] Mounting binderfs..."
    sudo mount -t binder binder /dev/binderfs
fi

echo "[INFO] Verifying binder devices..."
ls -la /dev/binderfs

echo "[SUCCESS] binderfs ready"