# Troubleshooting

This section documents real issues encountered while setting up ReDroid on WSL2 and how to resolve them.

---

## ❌ Docker: Cannot connect to daemon

### Error

```text
Cannot connect to the Docker daemon at unix:///var/run/docker.sock
```

### Fix

```bash
sudo systemctl reset-failed docker
sudo systemctl restart containerd
sudo systemctl restart docker
```

---

## ❌ Docker networking fails: addrtype revision not supported

### Error

```text
iptables: addrtype revision 0 not supported
```

### Cause

Mismatch between kernel netfilter support and iptables backend.

### Fix

Switch to legacy iptables:

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

sudo systemctl restart containerd
sudo systemctl restart docker
```

---

## ❌ Docker fails: raw table does not exist

### Error

```text
iptables: can't initialize iptables table `raw': Table does not exist
```

### Cause

Kernel missing raw table support.

### Fix

Ensure kernel config includes:

```text
CONFIG_IP_NF_RAW=y
CONFIG_IP6_NF_RAW=m
```

Rebuild kernel using:

```text
kernel/config/wsl-redroid-docker.config
```

---

## ❌ Dockhand container fails to start

### Error

```text
failed to create endpoint ... Unable to enable DIRECT ACCESS FILTERING
```

### Cause

iptables / netfilter mismatch.

### Fix

```bash
scripts/configure-iptables-legacy.sh
```

---

## ❌ Binder not available

### Error

```text
CONFIG_ANDROID_BINDER_IPC is not set
```

or

```text
grep binder /proc/filesystems → no output
```

### Fix

Use custom WSL2 kernel with:

```text
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
```

---

## ❌ binderfs not mounted

### Error

ReDroid fails silently or crashes.

### Fix

```bash
scripts/mount-binderfs.sh
```

---

## ❌ ReDroid has no Play Store / Chrome

### Cause

Using base ReDroid image without GApps.

### Fix

Use GApps-enabled image:

```text
fahaddz/redroid:13
```

---

## ❌ Wrong Docker image tag

### Error

```text
manifest not found
```

### Fix

Verify image exists on Docker Hub.

---

## ❌ scrcpy fails with audio encoder error

### Error

```text
Could not create default audio encoder for opus
```

### Fix

Disable audio:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio
```

---

## ❌ scrcpy command not found

### Cause

scrcpy not installed or not in PATH.

### Fix

Download from:

```text
https://github.com/Genymobile/scrcpy/releases
```

Run using full path or add to PATH.

---

## ❌ ADB shows multiple devices

### Example

```text
127.0.0.1:5555
emulator-5554
```

### Fix

Disconnect unwanted device:

```powershell
adb disconnect emulator-5554
```

---

## ❌ Browser opens then closes immediately

### Cause

scrcpy instability or rendering issue.

### Fix

Run with lower load:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio --max-size=1024
```

---

## ❌ Cannot sign into Google account

### Cause

No GApps installed.

### Fix

Use GApps-enabled ReDroid image.

---

## 🧠 General Advice

- Always verify kernel first
- Always verify binderfs mount
- Always verify Docker before ReDroid
- Prefer Mode A (Dockhand) if instability occurs

---