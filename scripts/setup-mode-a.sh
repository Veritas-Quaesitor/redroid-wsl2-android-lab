#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="$REPO_ROOT/compose/redroid-gapps.compose.yaml"

echo "========== Mode A Setup: WSL-native Docker + Dockhand =========="

echo "[INFO] Repo root: $REPO_ROOT"

echo
echo "[STEP 1] Verifying binder support..."
if ! grep -q binder /proc/filesystems; then
    echo "[ERROR] Binder support not found. Custom WSL2 kernel is not active."
    exit 1
fi
echo "[OK] Binder support found"

echo
echo "[STEP 2] Mounting binderfs..."
"$REPO_ROOT/scripts/mount-binderfs.sh"

echo
echo "[STEP 3] Configuring iptables legacy + restarting Docker..."
"$REPO_ROOT/scripts/configure-iptables-legacy.sh"

echo
echo "[STEP 4] Starting Dockhand if container exists..."
if docker ps -a --format '{{.Names}}' | grep -qx "dockhand"; then
    docker start dockhand >/dev/null || true
    echo "[OK] Dockhand start attempted"
else
    echo "[WARN] Dockhand container not found. Skipping."
fi

echo
echo "[STEP 5] Starting ReDroid compose stack..."
docker compose -f "$COMPOSE_FILE" up -d

echo
echo "[STEP 6] Current containers:"
docker ps

echo
echo "========== COMPLETE =========="
echo
echo "Next from Windows PowerShell:"
echo "  scripts\\adb-connect.ps1"
echo "  scripts\\start-scrcpy.ps1"