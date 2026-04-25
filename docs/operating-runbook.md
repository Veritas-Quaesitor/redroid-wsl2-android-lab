# Operating Runbook

## Overview

This runbook covers the **daily usage workflow** for the ReDroid lab.

Use this after the initial setup is complete.

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

If not:

```bash
scripts/configure-iptables-legacy.sh
```

---

### 4. Start ReDroid

```bash
cd /mnt/c/Users/<your-user>/source/redroid-wsl2-gpay-lab
docker compose -f compose/redroid-gapps.compose.yaml up -d
```

---

## 🔌 Connect Device (Windows)

```powershell
scripts\adb-connect.ps1
```

---

## 🖥️ Open Android UI

```powershell
scripts\start-scrcpy.ps1
```

---

## 🧪 Run Google Pay Test

Inside Android:

1. Open Chrome
2. Navigate to test merchant page
3. Trigger Google Pay
4. Complete payment

---

## 🛑 Stop Environment

From WSL:

```bash
docker compose -f compose/redroid-gapps.compose.yaml down
```

---

## 🔄 Restart Flow

```text
1. mount-binderfs
2. ensure Docker running
3. start ReDroid
4. connect ADB
5. start scrcpy
```

---

## 🔍 Health Check

Run:

```bash
scripts/verify-host.sh
```

Then from Windows:

```powershell
scripts\verify-redroid.ps1
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
scripts\start-scrcpy.ps1
```

or fallback:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio --max-size=1024
```

---

## 🧠 Notes

- Always mount binderfs after WSL restart
- Always verify Docker before starting ReDroid
- Use `--no-audio` with scrcpy to avoid encoder issues