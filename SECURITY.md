# Security Policy

## Purpose

This repository provides a local Android-in-Docker development lab using ReDroid, WSL2, Docker, ADB, and scrcpy.

It is intended for **development and testing only**.

---

## Supported Use

This project may be used for:

- Local Android browser testing
- Android app validation
- ReDroid experimentation
- WSL2 + Docker Android runtime testing
- Non-production development workflows

---

## Not Supported

Do **not** use this project for:

- Production payment processing
- Real customer data
- Real credentials or secrets
- Production certificates
- Sensitive screenshots
- Regulated production workloads
- Security bypassing or device integrity evasion

---

## Sensitive Data Rules

Do not commit or share:

- API keys
- Tokens
- Passwords
- Certificates
- Private keys
- `.env` files
- Payment payloads
- Customer data
- Internal endpoints
- Screenshots showing sensitive information

The `.gitignore` file excludes common sensitive artifacts, but developers are still responsible for checking their changes before committing.

---

## Google / Play Store Accounts

Use only test or approved development accounts.

Do not use personal accounts or production accounts unless explicitly approved by your organization.

---

## Kernel Binary Notice

The custom WSL2 kernel binary is treated as a build artifact.

Recommended handling:

- Do not commit the binary directly to Git history
- Store it as an internal release artifact if required
- Prefer rebuilding from `kernel/config/wsl-redroid-docker.config`

---

## Responsible Disclosure

If you find a security issue in this repository, do not open a public issue containing sensitive details.

Report it privately through the owning team’s approved internal security process.

---

## Compliance Note

This project does not make ReDroid, Docker, WSL2, or any Android image compliant by default.

Each organization must validate:

- Data handling
- Account usage
- Network exposure
- Logging
- Screenshot handling
- Third-party image usage
- Internal security policy alignment

before using this setup in regulated environments.

---

## Final Reminder

Assume everything inside the Android container, ADB session, logs, screenshots, and browser state may be sensitive.

Keep the repo clean, sanitized, and development-only.