# homebrew-flipio

Homebrew tap for [Flipio](https://github.com/pavgol/flipio), a macOS menu bar app that instantly converts text between keyboard layouts.

## Install

```bash
brew tap pavgol/flipio
brew install --cask flipio
```

## Why a tap instead of the official cask

Flipio is ad-hoc signed because the author is not enrolled in the Apple Developer Program. [homebrew/homebrew-cask](https://github.com/Homebrew/homebrew-cask) rejects unsigned or non-notarized applications, so Flipio ships through this user-maintained tap.

The cask's `postflight` step removes macOS's quarantine attribute from the installed app so Gatekeeper lets it launch. If you prefer to keep quarantine in place, install with `--no-quarantine` and you can right-click → Open on first launch instead.

## Updating the cask

After each release of the main repo, update `Casks/flipio.rb`:

1. Bump `version`.
2. Copy the new SHA256 from the release workflow's job summary (or `shasum -a 256 Flipio-<version>.dmg`) into `sha256`.
3. Commit and push.
