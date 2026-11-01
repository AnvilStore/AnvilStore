# Security Policy

AnvilStore handles Apple ID credentials, signing certificates, and device pairing files, so security reports matter.

## Reporting a vulnerability

Please don't open a public issue. Use **Report a vulnerability** under the Security tab of this repository. Include what you found, how to reproduce it, and the iOS and app versions affected.

## What to expect

Reports are read and answered as soon as possible. This is a small project, so there is no guaranteed response time.

## Official sources

AnvilStore is only distributed from github.com/AnvilStore/AnvilStore. Builds from anywhere else may be modified to steal credentials.

## How credentials are handled

Apple ID credentials are used only to talk to Apple and are stored in the Keychain. The app has no analytics and no server of its own.
