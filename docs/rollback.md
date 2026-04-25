# Rollback Guide

## Overview

This guide explains how to revert the system back to a clean/default state.

---

## 🔄 Revert to Default WSL Kernel

Edit:

```text
%USERPROFILE%\.wslconfig
```

Comment out the custom kernel:

```ini
[wsl2]
# kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Restart WSL:

```powershell
wsl --shutdown
```

Verify:

```bash
uname -a
```

You should now see the default Microsoft WSL kernel.

---

## 🐳 Stop and Remove ReDroid

```bash
cd /mnt/c/path/to/redroid-wsl2-android-lab

docker compose -f compose/redroid-gapps.compose.yaml down
docker rm -f redroid 2>/dev/null || true
docker volume rm compose_redroid-data 2>/dev/null || true
```

---

## 🔌 Reset ADB

```powershell
adb kill-server
adb start-server
```

---

## 🧹 Optional Cleanup

Remove binderfs mount:

```bash
sudo umount /dev/binderfs 2>/dev/null || true
```

---

## 🧠 Notes

- Default WSL kernel is never deleted
- Switching kernels is safe and reversible
- No Windows system files are modified