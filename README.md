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
  <img src="https://img.shields.io/badge/license-AGPL--3.0-blue?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/github/stars/AnvilStore/AnvilStore?style=for-the-badge" alt="Stars">
</p>

---

> [!CAUTION]
> **Only get AnvilStore from this repository.** It's open source, so anyone can fork it, add code that steals your Apple ID, and reuse the name and icon. I don't publish builds anywhere else than github.com/AnvilStore/AnvilStore. If it didn't come from github.com/AnvilStore/AnvilStore, don't type your Apple ID into it.

## What it is

AnvilStore is a sideloading workstation for iOS. The goal is to handle the whole process on the phone: pairing, signing in, signing an IPA, patching it, installing it, and keeping it refreshed. It will also be able to read what's inside an IPA before you install it.

It is in early development. Only the app shell, UI, and source browsing exist so far, and they haven't been tested on a device yet. Everything marked planned below does not work yet.

## Status

| Part | State |
|---|---|
| App shell, UI, AltStore-style sources | Built, untested on a device |
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

No analytics, no tracking, no account, and no server of its own. Credentials are stored only in the Keychain.

## Building

The project is a set of local Swift packages, one per feature, with a Rust core planned for the loopback tunnel. It needs macOS and Xcode.

```
swift package resolve
swift build
```

CI builds and tests the packages on iOS simulators for every push.

## Built on

- [Alamofire](https://github.com/Alamofire/Alamofire) (MIT)
- [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) (MIT)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

AGPL-3.0. See [LICENSE](LICENSE).
# CI trigger
