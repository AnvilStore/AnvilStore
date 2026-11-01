<p align="center">
  <img src="app-icon.png" width="180" alt="AnvilStore">
</p>

<h1 align="center">AnvilStore</h1>

<p align="center">
  <b>Sign, patch, and install iOS apps from your iPhone. No computer needed.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS%2015%2B-lightgrey?style=for-the-badge&logo=apple" alt="Platform">
  <img src="https://img.shields.io/badge/version-0.1.0--dev-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/github/license/AnvilStore/AnvilStore?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/github/stars/AnvilStore/AnvilStore?style=for-the-badge" alt="Stars">
  <img src="https://img.shields.io/badge/status-early%20development-orange?style=for-the-badge" alt="Status">
</p>

---

## What it is

AnvilStore is a sideloading workstation for iOS. The goal is to handle the whole process on the phone: pairing, signing in, signing an IPA, patching it, installing it, and keeping it refreshed. It will also be able to read what's inside an IPA before you install it.

It is in early development. Only the app shell, UI, and source browsing exist so far. Nothing on this page that is listed as planned works yet.

## Status

| Part | State |
|---|---|
| App shell, UI, AltStore-style sources | Done, not yet tested on a device |
| Pairing, loopback tunnel, diagnostics | Next |
| Apple ID sign-in, certificates, anisette | Planned |
| Signing, install, auto-refresh | Planned |
| Patcher (entitlements, dylibs, .deb) | Planned |
| IPA inspector and differ | Planned |
| JIT, console, backups | Planned |

## Requirements

- iOS 15 or later is the target.
- Tested on an iPhone 16 Plus running iOS 26.0 only. Other versions are unverified.

## Privacy

No analytics, no tracking, no account, no server. Credentials are stored only in the Keychain.

## Building

The project is a set of local Swift packages, one per feature, plus a Rust core for the loopback tunnel (not added yet). It needs macOS and Xcode.
