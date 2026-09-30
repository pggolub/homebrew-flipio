cask "flipio" do
  version "1.0.5"
  sha256 "ec88cdc3a8220b27a0b598a8952ce2fa2df18ac9a3a1f1a320f7bf3a6a75310e"

  url "https://github.com/pggolub/flipio/releases/download/v#{version}/Flipio-#{version}.dmg"
  name "Flipio"
  desc "Menu bar app that converts typed text between keyboard layouts"
  homepage "https://github.com/pggolub/flipio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Flipio.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Flipio.app"]
  end

  uninstall quit: "com.flipio.app"

  zap trash: [
    "~/Library/Caches/com.flipio.app",
    "~/Library/HTTPStorages/com.flipio.app",
    "~/Library/Preferences/com.flipio.app.plist",
  ]

  caveats <<~EOS
    Flipio is ad-hoc signed (not notarized — the author is not in the Apple
    Developer Program). The postflight step removes macOS Gatekeeper's
    quarantine attribute so the app can launch. Review the source at
    #{homepage} before installing if that concerns you.

    On first launch, grant Accessibility permission.
  EOS
end
