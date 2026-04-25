# Kernel Requirements

## Overview

ReDroid relies on Android kernel features that are **not enabled in the default Microsoft WSL2 kernel**.

To run ReDroid successfully inside WSL2, a **custom kernel build is required**.

---

## Why a Custom Kernel is Needed

The default WSL2 kernel does **not include**:

- Android Binder IPC
- Binder filesystem (binderfs)
- Required netfilter/iptables features for Docker networking

Without these:

- ReDroid will not start or will crash
- Docker networking may fail
- ADB connectivity may behave unpredictably

---

## Required Kernel Features

The following kernel options must be enabled:

### Android Binder

```text
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
```

---

### Docker / Networking

```text
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y

CONFIG_NF_CONNTRACK=y
CONFIG_NF_NAT=y

CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y

CONFIG_IP_NF_RAW=y
CONFIG_IP6_NF_RAW=m
```

---

### Bridging and Virtual Networking

```text
CONFIG_BRIDGE=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_VETH=y
```

---

### Filesystem

```text
CONFIG_OVERLAY_FS=y
```

---

## Kernel Config Source

This repository provides a working kernel configuration:

```text
kernel/config/wsl-redroid-docker.config
```

This config was derived from:

```text
Microsoft/config-wsl
```

and modified to support:

- BinderFS
- Docker networking compatibility
- ReDroid requirements

---

## Prebuilt Kernel

A known working kernel binary:

```text
bzImage-redroid-docker-v2
```

is expected to be placed at:

```text
C:\wsl-kernel\bzImage-redroid-docker-v2
```

This binary is **not committed to the repository** by default.

---

## Switching Kernels

To use the custom kernel:

```ini
[wsl2]
kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

To revert to the default Microsoft kernel:

```ini
[wsl2]
# kernel=C:\\wsl-kernel\\bzImage-redroid-docker-v2
```

Then:

```powershell
wsl --shutdown
```

---

## Safety Notes

- The default WSL2 kernel is **not overwritten**
- Switching kernels is **safe and reversible**
- No system-level Windows changes are made

---

## Recommendation

Use the custom kernel for:

- ReDroid
- Android emulation inside WSL

Fallback to default kernel if:

- Unexpected WSL instability occurs
- Non-Docker workloads behave incorrectly

---