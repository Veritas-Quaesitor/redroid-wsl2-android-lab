# redroid-wsl2-gpay-lab

## 📚 Table of Contents

- [Purpose](#-purpose)
- [Problem Statement](#-problem-statement)
- [Final Working Solution](#-final-working-solution)
- [Architecture Overview](#-architecture-overview)
- [Key Requirements](#-key-requirements)
- [What This Repo Contains](#-what-this-repo-contains)
- [Supported Modes](#-supported-modes)
- [Quick Start](#-quick-start)
- [Security Notice](#-security-notice)

## 🎯 Purpose

Provide a reproducible local development setup to test **Google Pay Web flows inside Android Chrome** without:

- Physical Android devices (USB restricted environments)
- Android Studio (heavyweight tooling)
- Cloud-based emulators (compliance / security concerns)

---

## ❗ Problem Statement

In high-compliance environments (e.g. PSP / PCI DSS), developers often cannot:

- Plug in physical Android devices (USB restrictions)
- Use personal mobile devices
- Reliably test Google Pay Web flows from desktop browsers

Standard alternatives have limitations:

| Approach | Issue |
|---|---|
| Android Studio Emulator | Heavy, complex, unstable for this use case |
| docker-android (budtmo) | Unstable ADB/VNC issues |
| Google emulator containers | Poor stability in WSL |
| Base ReDroid | No Google Play, Chrome, or GMS |

---

## ✅ Final Working Solution

This lab provides a working setup using:

- **Windows 11 + WSL2 Ubuntu**
- **Custom WSL2 kernel** with BinderFS and Docker networking support
- **Docker**, either WSL-native with Dockhand or Docker Desktop
- **ReDroid Android 13 with GApps**
- **ADB over TCP**
- **scrcpy for UI control**
- **Chrome installed via Play Store**

Result:

- Full Android environment
- Google account sign-in
- Play Store access
- Chrome browser
- Google Pay Web TEST payment flow successfully completed

---

## 🧠 Architecture Overview

```text
Windows 11
  └── WSL2 Ubuntu
        ├── Custom Kernel
        │     ├── Binder / BinderFS
        │     └── Netfilter / iptables / Docker networking
        │
        ├── Docker Engine or Docker Desktop integration
        │     └── ReDroid container
        │           └── Android 13 + GApps + Play Store
        │
        ├── ADB tcp:5555
        └── scrcpy Windows UI
```

---

## ⚠️ Key Requirements

This setup depends on:

- Custom WSL2 kernel with BinderFS enabled
- Docker networking compatibility
- iptables legacy mode for the proven WSL-native Docker path
- GApps-enabled ReDroid image
- ADB installed on Windows
- scrcpy installed on Windows

Without these, the setup will fail.

---

## 📦 What This Repo Contains

- Preconfigured **ReDroid Docker Compose stack**
- Working WSL2 kernel config
- Optional prebuilt custom kernel binary as a release/manual artifact
- Scripts for:
  - BinderFS mounting
  - iptables legacy configuration
  - ADB connection
  - scrcpy startup
  - host verification
  - ReDroid verification
- Documentation for:
  - Dockhand users
  - Docker Desktop users
  - Kernel requirements
  - Google Pay Web testing
  - Rollback
  - Troubleshooting known failures

---

## 🚀 Supported Modes

| Mode | Description |
|---|---|
| A | WSL2 + native Docker Engine + Dockhand |
| B | WSL2 + Docker Desktop integration |

Both modes require the same custom WSL2 kernel.

---

## ⚠️ Security Notice

This repo intentionally excludes:

- Payment payloads
- Tokens
- Credentials
- Certificates
- Real merchant data
- Screenshots containing sensitive information
- Production PSP endpoints

Use only **test environments, test accounts, and non-production credentials**.

---

## ⚡ Quick Start

Choose your setup path:

- **Mode A** → WSL2 + native Docker Engine + Dockhand *(recommended / proven)*
- **Mode B** → WSL2 + Docker Desktop integration

---

### 🔧 Step 1 — Apply Custom WSL2 Kernel

Copy the prebuilt kernel to:

```text
C:\wsl-kernel\bzImage-redroid-docker-v2
```

Edit:

```text
%USERPROFILE%\.wslconfig
```

Add:

```ini
[wsl2]
kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Then restart WSL:

```powershell
wsl --shutdown
```

---

### 🔧 Step 2 — Verify Kernel + Binder

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

Expected:

```text
binder
hwbinder
vndbinder
```

---

### 🔧 Step 3 — Docker Setup

#### Mode A (WSL-native Docker + Dockhand)

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

sudo systemctl restart containerd
sudo systemctl restart docker
```

---

#### Mode B (Docker Desktop)

- Enable WSL2 backend
- Enable Ubuntu distro integration
- Ensure Docker Desktop is running

---

### 🔧 Step 4 — Start ReDroid

From WSL:

```bash
cd /mnt/c/Users/<your-user>/source/redroid-wsl2-gpay-lab
docker compose -f compose/redroid-gapps.compose.yaml up -d
```

---

### 🔧 Step 5 — Connect ADB (Windows)

```powershell
adb kill-server
adb start-server
adb connect 127.0.0.1:5555
adb devices -l
```

---

### 🔧 Step 6 — Launch Android UI

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio
```

---

### 🔧 Step 7 — Setup Device

Inside Android:

- Sign into Google account
- Open Play Store
- Install Chrome

---

### 🔧 Step 8 — Test Google Pay Web

- Open Chrome
- Navigate to test merchant page
- Complete Google Pay Web flow

---

## ✅ Expected Result

- Android device fully usable
- Play Store working
- Chrome installed
- Google account signed in
- Google Pay Web TEST flow completes successfully