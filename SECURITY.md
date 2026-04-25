# Security Policy

## Scope

This repository provides a local development/test environment for running Android in Docker on Windows 11 + WSL2 using ReDroid.

It is intended for development, testing, and experimentation only.

---

## Do Not Commit Sensitive Data

Do not commit:

- Passwords
- API keys
- Access tokens
- Certificates or private keys
- Real account data
- Internal service URLs
- Production logs
- Sensitive screenshots
- Application payloads containing private or regulated data

The `.gitignore` file excludes common sensitive folders and file extensions, but it is not a substitute for manual review.

---

## Test Accounts Only

Use test accounts and non-production environments when validating Android, Play Store, Chrome, or target applications.

Do not use this repo to store or distribute real customer data or regulated production data.

---

## Kernel Binary Handling

The prebuilt WSL2 kernel binary is not committed by default.

Recommended handling:

- Store the known-good `bzImage-redroid-docker-v2` as a release artifact if required
- Keep the reproducible kernel config in Git
- Rebuild using `kernel/build-kernel.sh` when traceability is required

---

## Screenshots

Before adding screenshots, review `docs/screenshots.md`.

Screenshots must be sanitized and must not expose:

- Internal hostnames
- Credentials
- Personal account information
- Tokens
- Private application data

---

## Reporting Issues

For public repositories, use GitHub Issues for non-sensitive bugs and improvement requests.

For sensitive security issues, do not open a public issue. Use the maintainer's private disclosure process or your organization's internal security process.

---

## Supported Use

This project is suitable for:

- Local Android container experimentation
- Browser testing in Android Chrome
- Android app/UI validation through ADB and scrcpy
- ReDroid setup automation

This project is not a certified production Android device environment.
