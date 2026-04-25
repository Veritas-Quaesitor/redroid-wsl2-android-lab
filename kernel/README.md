# Kernel

## Overview

This folder contains artifacts related to the custom WSL2 kernel required for ReDroid.

---

## Contents

- `config/wsl-redroid-docker.config`  
  Known working kernel configuration

---

## Prebuilt Kernel

A prebuilt kernel is expected at:

```text
C:\wsl-kernel\bzImage-redroid-docker-v2
```

This binary is **not stored in the repository**.

---

## Why Custom Kernel is Required

The default WSL2 kernel does not include:

- Android Binder IPC
- Binder filesystem (binderfs)
- Required Docker netfilter features

Without these, ReDroid will not function correctly.

---

## Rebuilding

Refer to:

```text
docs/kernel-requirements.md
```

for required configuration.