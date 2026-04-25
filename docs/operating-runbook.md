# Operating Runbook

## Overview

This runbook covers the daily usage workflow for the ReDroid Android lab.

Use this after the initial setup is complete.

---

## Assumption

Commands in this document assume you are running them from the repository root unless stated otherwise.

From WSL, navigate to wherever you cloned the repo, for example:

```bash
cd /mnt/c/path/to/redroid-wsl2-android-lab
```

---

## 🚀 Start Environment

### 1. Open WSL

```powershell
wsl
```

---

### 2. Ensure BinderFS is mounted

```bash
scripts/mount-binderfs.sh
```

---

### 3. Ensure Docker is running

```bash
docker ps
```

If Docker is not running in Mode A:

```bash
scripts/configure-iptables-legacy.sh
```

---

### 4. Start ReDroid

```bash
docker compose -f compose/redroid-gapps.compose.yaml up -d
```

---

## 🔌 Connect Device from Windows

From Windows PowerShell, inside the repository root:

```powershell
.\scripts\adb-connect.ps1
```

---

## 🖥️ Open Android UI

From Windows PowerShell, inside the repository root:

```powershell
.\scripts\start-scrcpy.ps1
```

---

## 🧪 Run Browser/App Test

Inside Android:

1. Open Play Store
2. Install Chrome or another target Android app
3. Open Chrome or the target app
4. Navigate to a test web page or test environment
5. Validate input, rendering, network access, and required behavior

---

## 🛑 Stop Environment

From WSL, inside the repository root:

```bash
docker compose -f compose/redroid-gapps.compose.yaml down
```

---

## 🔄 Restart Flow

```text
1. Mount binderfs
2. Ensure Docker is running
3. Start ReDroid
4. Connect ADB
5. Start scrcpy
```

---

## 🔍 Health Check

From WSL:

```bash
scripts/verify-host.sh
```

From Windows PowerShell:

```powershell
.\scripts\verify-redroid.ps1
```

---

## ⚠️ Common Recovery Steps

### Docker not responding

```bash
scripts/configure-iptables-legacy.sh
```

---

### ReDroid not reachable

```powershell
adb disconnect 127.0.0.1:5555
adb connect 127.0.0.1:5555
```

---

### scrcpy fails

```powershell
.\scripts\start-scrcpy.ps1
```

or fallback:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio --max-size=1024
```

---

## 🧠 Notes

- Always mount binderfs after WSL restarts
- Always verify Docker before starting ReDroid
- Use `--no-audio` with scrcpy to avoid encoder issues
