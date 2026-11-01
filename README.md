# AnvilStore

**An on-device iOS sideloading workstation — no computer required.**

> **Full SideStore parity plus extras.** Built with Swift 6 + Rust. AGPL-3.0 licensed. No analytics, no tracking.

## Architecture

One Swift package per feature (11 total):

| Package | Feature |
|---------|---------|
| `AnvilTheme` | Design tokens, accent/appearance/density/expert config |
| `AnvilUI` | 20+ components: rows, cards, badges, buttons, forms, navigation, tab bar, sidebar |
| `AnvilSources` | AltStore-compatible source management: add/refresh/remove, index.json parsing, app browser, version history |
| `AnvilSetup` | Guided onboarding, pairing file import, loopback tunnel, diagnostics |
| `AnvilAccounts` | Apple ID sign-in, anisette server picker, cert/App ID/profile handling, .p12/.mobileprovision import |
| `AnvilInstall` | Sign & install on-device, IPA import (Files/share/URL), install queue with per-step log, retry, install-over-existing |
| `AnvilRefresh` | Background auto-refresh, per-app toggles, failure notifications, Shortcuts actions, automation triggers |
| `AnvilPatcher` | Bundle ID/name/version/icon, entitlements, .dylib/.framework/.deb/.appex import, saveable presets, batch patching |
| `AnvilCutaway` | IPA inspector/differ: Info.plist, entitlements with notes, provisioning, Mach-O, diff, JSON/Markdown export |
| `AnvilJIT` | Per-app JIT enabler, backends per iOS version, auto-enable on launch |
| `AnvilDebug` | Live device console, crash logs, sandbox browser (hex + plist editor), backup/restore |

Plus: `AnvilShell` (app entry, tab navigation, onboarding)

## Requirements

- **iOS 15.0+** (tested on iPhone 16 Plus iOS 26.0 only)
- **Xcode 16.4** (iOS 15/17 SDKs) / **Xcode 26** (iOS 26 SDK)
- **Swift 6** (strict concurrency)
- **Rust** (for loopback tunnel — future module)

## Build & Test (CI)

Runs on every push/PR via GitHub Actions:

- **Runner:** `macos-15` (Xcode 16.4 + Xcode 26 RC)
- **Test matrix:** iOS 15.5, 17.5, 26.0 simulators
- **Strict concurrency:** `SWIFT_STRICT_CONCURRENCY=complete`, warnings as errors
- **Artifact:** Unsigned `.ipa` (iOS 26 build) uploaded for sideloading

### Local Development

```bash
# Resolve dependencies
swift package resolve

# Build all packages
swift build --configuration debug

# Run tests (requires macOS + Xcode)
xcodebuild test -scheme AnvilTheme -destination 'platform=iOS Simulator,name=iPhone 16 Plus,OS=26.0'
# ... repeat for each package
```

## Project Structure

```
AnvilStore/
├── .github/workflows/ci.yml       # CI pipeline
├── AnvilStore.xcworkspace/        # Xcode workspace
├── AnvilStore.xcodeproj/          # Xcode project (app target)
├── AnvilStore/                    # App target sources
│   ├── AnvilStoreApp.swift
│   ├── RootView.swift
│   └── Info.plist
├── ExportOptions.plist            # IPA export (unsigned)
├── Package.swift                  # Root SPM manifest (11 local packages)
└── Packages/
    ├── AnvilTheme/
    ├── AnvilUI/
    ├── AnvilSources/
    ├── AnvilSetup/
    ├── AnvilAccounts/
    ├── AnvilInstall/
    ├── AnvilRefresh/
    ├── AnvilPatcher/
    ├── AnvilCutaway/
    ├── AnvilJIT/
    ├── AnvilDebug/
    └── AnvilShell/
```

## License

**AGPL-3.0-only** — see `LICENSE` (to be added).

All dependencies verified AGPL-compatible:
- Alamofire 5.9 (MIT)
- KeychainAccess 4.2 (MIT)

## Status

| Module | State |
|--------|-------|
| Theme, UI, Sources, Shell | ✅ Implemented (Module 1) |
| Setup | 🔄 Placeholder (Module 2 — pairing, loopback, diagnostics) |
| Accounts, Install, Refresh, Patcher, Cutaway, JIT, Debug | 🔲 Placeholders (Modules 3–9) |
| Customization (accent, icon, density, iPad sidebar) | 🔲 Module 10 |
| Extras (widgets, Live Activity, biometric lock) | 🔲 Module 11 |

> **Honest about limits:** Only tested on **iPhone 16 Plus / iOS 26.0**. No claim for untested iOS versions. Memory entitlements (Increased Memory Limit, Increased Debugging Memory Limit, Extended Virtual Addressing) verified at runtime via profile inspection — never promised.

## Contributing

1. One module at a time; finish, test, summarize
2. Small commits; surface real failure reasons in UI
3. Write tests alongside each module
4. Device-only tests (pairing, loopback, signing, install, JIT, console, backups) marked with manual checklist
5. Check license of every dependency/repo before reuse