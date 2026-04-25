# Setup: Docker Desktop (WSL2 Integration)

## Overview

This setup uses:

- Windows 11
- Docker Desktop
- WSL2 (Ubuntu)
- Custom WSL2 kernel
- ReDroid container

This path is intended for developers already using Docker Desktop.

> ⚠️ Note: This mode is supported, but the **WSL-native Docker Engine + Dockhand path is the primary validated setup**.

---

## Prerequisites

- Docker Desktop installed
- WSL2 backend enabled
- Ubuntu distribution enabled in Docker Desktop
- Custom kernel available:

```text
C:\wsl-kernel\bzImage-redroid-docker-v2
```

---

## 1. Enable WSL2 Backend

Open Docker Desktop:

- Settings → General
- Enable:

```text
Use the WSL 2 based engine
```

---

## 2. Enable Ubuntu Integration

Docker Desktop → Settings → Resources → WSL Integration

Enable:

```text
Ubuntu-24.04 (or your distro)
```

---

## 3. Configure Custom Kernel

Edit:

```text
%USERPROFILE%\.wslconfig
```

Add:

```ini
[wsl2]
kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Restart WSL:

```powershell
wsl --shutdown
```

---

## 4. Verify Kernel + Binder

Inside WSL:

```bash
uname -a
grep binder /proc/filesystems
```

Expected:

```text
nodev binder
```

Mount binderfs:

```bash
sudo mkdir -p /dev/binderfs
sudo mount -t binder binder /dev/binderfs
ls /dev/binderfs
```

---

## 5. Start ReDroid

From WSL:

```bash
cd /mnt/c/path/to/redroid-wsl2-android-lab
docker compose -f compose/redroid-gapps.compose.yaml up -d
```

---

## 6. Verify Container

```bash
docker ps | grep redroid
```

---

## 7. Connect ADB (Windows)

```powershell
adb connect 127.0.0.1:5555
adb devices -l
```

---

## 8. Launch UI

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio
```

---

## Known Considerations

### iptables

Docker Desktop may handle networking differently than native Docker.

If networking issues occur:

- Try switching to WSL-native Docker Engine (Mode A)
- Or manually configure iptables inside WSL

---

### Privileged Containers

ReDroid requires:

```text
privileged: true
```

Ensure Docker Desktop allows privileged containers.

---

### Performance

Docker Desktop may introduce:

- Slightly higher overhead
- Slower container startup vs native WSL Docker

---

## Recommendation

Use Docker Desktop if:

- Already part of your workflow
- You do not want to manage Docker inside WSL

Use Mode A (Dockhand + native Docker) if:

- You encounter networking issues
- You need maximum stability for ReDroid