# Screenshots Guide

## Purpose

Screenshots improve usability and adoption, but must be **sanitized** for compliance.

---

## ⚠️ Do NOT include

- Real payment data
- Tokens / payloads
- Merchant IDs
- Certificates
- Email addresses (unless test-only)
- PSP endpoints
- Internal URLs
- Browser dev tools showing sensitive data

---

## ✅ Safe to include

- ReDroid home screen
- Play Store (logged into test account)
- Chrome installed
- Google Pay button (before payment)
- scrcpy window
- Dockhand UI (without sensitive stacks)
- Terminal output with no secrets

---

## 📁 Folder Structure

```text
docs/images/safe/
docs/images/placeholders/
```

---

## 📸 Suggested Screenshots

1. ReDroid boot screen
2. Play Store logged in
3. Chrome installed
4. Google Pay button visible
5. scrcpy running
6. Dockhand stack view

---

## 🧠 Naming Convention

```text
01-redroid-home.png
02-playstore-login.png
03-chrome-installed.png
04-google-pay-button.png
05-scrcpy-ui.png
06-dockhand-stack.png
```

---

## 📌 Usage in README

Example:

```md
![ReDroid Home](docs/images/safe/01-redroid-home.png)
```

---

## Recommendation

Start with placeholders, then replace with sanitized screenshots.