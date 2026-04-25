#!/usr/bin/env bash

set -e

echo "[INFO] Switching iptables to legacy mode..."

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

echo "[INFO] Restarting Docker services..."

sudo systemctl reset-failed docker || true
sudo systemctl restart containerd
sudo systemctl restart docker

echo "[INFO] Verifying Docker..."

docker ps

echo "[SUCCESS] iptables configured and Docker restarted"