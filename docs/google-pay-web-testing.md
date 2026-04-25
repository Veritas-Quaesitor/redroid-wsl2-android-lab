# Google Pay Web Testing

## Overview

This document describes how to test **Google Pay Web flows inside Android Chrome** using the ReDroid environment.

---

## Prerequisites

- ReDroid container running
- Device accessible via ADB
- scrcpy working
- Google account signed in
- Play Store available
- Chrome installed

---

## Setup

Inside Android:

1. Open **Play Store**
2. Sign in with a **test Google account**
3. Install **Google Chrome**
4. Open Chrome

---

## Test Flow

1. Navigate to your **test merchant site**
2. Trigger **Google Pay button**
3. Select payment method
4. Complete authentication
5. Submit payment

---

## Expected Result

- Google Pay sheet opens correctly
- Payment method selection works
- Authentication completes
- Payment response returned to merchant

---

## Notes

- Use **TEST environment only**
- Do not use production credentials
- Ensure network connectivity inside container

---

## Troubleshooting

### Google Pay not appearing

- Verify Chrome is installed
- Verify Google account is signed in
- Verify GApps-enabled ReDroid image is used

---

### Payment sheet fails

- Check browser console logs
- Verify merchant configuration
- Verify test environment endpoints

---

### Chrome crashes

- Restart ReDroid container
- Restart scrcpy