# Android Chrome Testing

## Overview

This document describes how to validate browser-based testing inside Android Chrome using the ReDroid environment.

The goal is to confirm that Android, Play Store, Google account sign-in, Chrome installation, ADB, and scrcpy are all working end-to-end.

---

## Prerequisites

- ReDroid container running
- Device accessible through ADB
- scrcpy working
- Google account signed in
- Play Store available
- Chrome installed

---

## Setup

Inside Android:

1. Open **Play Store**
2. Sign in with a test Google account
3. Install **Google Chrome**
4. Open Chrome

---

## Basic Browser Validation

1. Open Chrome
2. Navigate to a public test page, for example:

```text
https://www.google.com
```

3. Navigate to your own local/test web application
4. Confirm keyboard input works
5. Confirm page rendering works
6. Confirm network access works

---

## Local Web App Testing

Use HTTPS whenever your application requires secure browser APIs.

Common approaches:

- Local application exposed through a tunnel
- Internal test environment URL
- Staging environment URL

Do not include private URLs in this repository.

---

## Expected Result

- Chrome launches correctly
- Web pages load
- Keyboard and pointer input work through scrcpy
- Browser sessions persist across container restarts when the ReDroid data volume is retained

---

## Troubleshooting

### Chrome is missing

Install Chrome from Play Store.

---

### Play Store is missing

Confirm the GApps-enabled ReDroid image is used:

```text
fahaddz/redroid:13
```

---

### Google sign-in fails

- Check network connectivity inside Android
- Restart the ReDroid container
- Confirm Play Services packages are installed

---

### Chrome crashes

- Restart ReDroid container
- Restart scrcpy
- Check available host memory
