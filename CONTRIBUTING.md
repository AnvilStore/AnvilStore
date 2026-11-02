# Contributing to AnvilStore

Thanks for wanting to help. AnvilStore is in early development, so the most useful contributions right now are bug reports, testing on real devices, and small focused fixes.

By contributing, you agree to the Developer's Certificate of Origin in
[CERTIFICATE-OF-ORIGIN.md](CERTIFICATE-OF-ORIGIN.md), and that your contribution is licensed under
AGPL-3.0, the same license as the rest of the project. Sign off your commits with `git commit -s`.

## Ways to help

You don't need to write code to contribute:

- Test on a real device and report what worked and what didn't
- Write or fix documentation
- Report bugs with clear steps
- Suggest features by describing the problem you want solved

## Reporting bugs

Include your iOS version, device model, the AnvilStore version or commit, what you did, what you expected, and what happened. If it failed during signing or install, say which step.

**Never post** your Apple ID, password, pairing file, certificates, `.p12` files, or logs that contain them.

## Development setup

You need:

- A Mac with Xcode (Xcode 16.4 or later)
- Basic command line and Git knowledge
- Basic Swift and iOS development knowledge

Steps:

1. Fork the repo on GitHub.
2. Clone your fork: `git clone https://github.com/AnvilStore/AnvilStore.git`
3. Resolve dependencies: `swift package resolve`
4. Open the project in Xcode and build.
5. Make and test your changes, then push a branch and open a pull request.

Each feature is its own Swift package under `Packages/`. Keep your changes inside the package they belong to. You can build and test one package on its own:

    xcodebuild test -scheme AnvilTheme -destination 'platform=iOS Simulator,name=iPhone 16 Plus,OS=26.0'

## Pull requests

1. Branch from `main`.
2. Keep each pull request to one idea.
3. Add or update tests for what you changed.
4. Make sure CI passes. It builds every package with Swift 6 strict concurrency and warnings treated as errors.
5. Describe what changed, why, and how you tested it.

For large changes, open an issue first so we can agree on the approach.

## Code guidelines

- Swift 6 with strict concurrency, and no new warnings.
- iOS 15 is the minimum target. Gate newer APIs with `#available` and provide a fallback.
- Keep dependencies to a minimum. Check every new dependency's license first, and it must be compatible with AGPL-3.0.
- No analytics, no tracking, and no network calls to servers we don't control.
- Credentials go in the Keychain, never in logs or plain files.

## Testing on a device

Pairing, the loopback tunnel, signing, installing, JIT, the console, and backups can't be tested in a simulator. If your change touches them, say which device and iOS version you tested on. If you couldn't test on a device, say so in the pull request.

## Building an IPA

Releases are built by GitHub Actions, not on a personal machine. A local build can embed your username in file paths inside the binary.

## Security issues

Don't open a public issue for a vulnerability. Use **Report a vulnerability** under the repo's Security tab. See [SECURITY.md](SECURITY.md).

## Your responsibility for the code

You are responsible for everything you submit, however it was written. Read it, understand it, and be ready to explain it. If it includes code copied from another project, say where it came from and under what license.
