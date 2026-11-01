<p align="center">
  <img src="app-icon.png" width="128" alt="AnvilStore">
</p>

# AnvilStore

**Sign, patch, and install iOS apps from your iPhone. No computer needed.**

![Platform](https://img.shields.io/badge/platform-iOS%2015%2B-lightgrey?style=for-the-badge&logo=apple)
![License](https://img.shields.io/github/license/AnvilStore/AnvilStore?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/AnvilStore/AnvilStore?style=for-the-badge)
![Status](https://img.shields.io/badge/status-early%20development-orange?style=for-the-badge)

> [!CAUTION]
> **Only get AnvilStore from this repository.** It's open source, so anyone can fork it, add code that steals your Apple ID, and reuse the name and icon. I don't publish builds anywhere else. If it didn't come from github.com/AnvilStore/AnvilStore, don't type your Apple ID into it.

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
