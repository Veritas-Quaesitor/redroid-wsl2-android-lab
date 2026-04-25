# Screenshots Guide

## Purpose

Screenshots improve usability and adoption, but they must be sanitized before committing.

---

## ⚠️ Do NOT include

- Credentials
- API keys
- Tokens
- Certificates
- Email addresses unless they are clearly test-only
- Internal URLs or hostnames
- Private application data
- Browser dev tools showing sensitive values

---

## ✅ Safe to include

- ReDroid home screen
- Play Store (logged into test account)
- Chrome installed
- Chrome loading a public website
- scrcpy window
- Dockhand UI with sensitive stack names hidden
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
4. Chrome loading a public page
5. scrcpy running
6. Dockhand stack view with no sensitive data

---

## 🧠 Naming Convention

```text
01-redroid-home.png
02-playstore-available.png
03-chrome-installed.png
04-chrome-public-page.png
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

Start with placeholders, then replace them with sanitized screenshots.
