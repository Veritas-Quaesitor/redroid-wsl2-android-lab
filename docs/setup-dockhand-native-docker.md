# Setup: WSL2 Native Docker Engine + Dockhand

This is the proven setup path used to run ReDroid successfully on Windows 11 with Ubuntu WSL2 and Dockhand.

## Scope

This guide covers:

- Custom WSL2 kernel usage
- BinderFS mounting
- Docker daemon recovery/configuration
- Dockhand compatibility
- ReDroid stack deployment through Dockhand

## Prerequisites

- Windows 11
- Ubuntu WSL2
- Docker Engine installed inside Ubuntu WSL2
- Dockhand running as a Docker container
- Custom WSL2 kernel available at:

```text
C:\wsl-kernel\bzImage-redroid-docker-v2
```

- Repo checked out at:

```text
%USERPROFILE%\source\redroid-wsl2-gpay-lab
```

## 1. Configure WSL to use the custom kernel

Edit:

```text
%USERPROFILE%\.wslconfig
```

Use:

```ini
[wsl2]
kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Restart WSL:

```powershell
wsl --shutdown
```

Open Ubuntu again.

## 2. Verify kernel and Binder support

Inside WSL:

```bash
uname -a
grep binder /proc/filesystems
```

Expected:

```text
nodev binder
```

Mount BinderFS:

```bash
sudo mkdir -p /dev/binderfs
sudo mount -t binder binder /dev/binderfs
ls -la /dev/binderfs
```

Expected devices:

```text
binder
hwbinder
vndbinder
```

## 3. Configure iptables legacy mode

The custom kernel works with Docker in this setup when `iptables-legacy` is used.

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```

Verify:

```bash
sudo update-alternatives --display iptables
sudo update-alternatives --display ip6tables
```

## 4. Restart Docker services

```bash
sudo systemctl reset-failed docker
sudo systemctl restart containerd
sudo systemctl restart docker
docker ps
```

If Docker starts correctly, continue.

## 5. Start Dockhand

```bash
docker ps -a | grep -i dockhand
docker start dockhand
docker ps
```

Expected:

```text
dockhand   Up ... healthy
```

Dockhand UI should be available at:

```text
http://localhost:3010
```

## 6. Deploy ReDroid stack in Dockhand

Create a new Dockhand stack using:

```text
compose/redroid-gapps.compose.yaml
```

Current working image:

```text
fahaddz/redroid:13
```

This image includes Android 13 and GApps.

## 7. Validate ReDroid container

Inside WSL:

```bash
docker ps | grep -i redroid
docker logs redroid --tail=100
```

From Windows PowerShell:

```powershell
adb kill-server
adb start-server
adb connect 127.0.0.1:5555
adb devices -l
```

Expected:

```text
127.0.0.1:5555    device product:redroid_x86_64 model:redroid13_x86_64
```

## 8. Open Android UI

From Windows PowerShell:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio
```

`--no-audio` is required because this ReDroid image may not provide the default OPUS audio encoder expected by scrcpy.

## 9. Device setup

Inside the Android UI:

1. Open Play Store.
2. Sign into a Google account.
3. Install Chrome.
4. Open Chrome.
5. Navigate to the Google Pay Web test page.
6. Complete the payment flow.

## Known required fixes

### Docker fails with `addrtype revision 0 not supported`

Use legacy iptables:

```bash
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo systemctl restart containerd
sudo systemctl restart docker
```

### Docker container fails with `iptables table raw: Table does not exist`

The kernel is missing raw table support. Ensure the kernel config contains:

```text
CONFIG_IP_NF_RAW=y
CONFIG_IP6_NF_RAW=m
```

Use the provided config:

```text
kernel/config/wsl-redroid-docker.config
```

### scrcpy fails with OPUS audio encoder error

Use:

```powershell
scrcpy -s 127.0.0.1:5555 --no-audio
```

## Rollback

To return to the default Microsoft WSL2 kernel, edit:

```text
%USERPROFILE%\.wslconfig
```

Comment out the custom kernel line:

```ini
[wsl2]
# kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Then:

```powershell
wsl --shutdown
```