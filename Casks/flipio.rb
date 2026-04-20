cask "flipio" do
  version "0.1.0-beta"
  sha256 "6651c6d22a81d90a6d878d66dc26629df00bd712123d06dd4469c0d28c5f1cd9"

  url "https://github.com/pggolub/flipio/releases/download/v#{version}/Flipio-#{version}.dmg"
  name "Flipio"
  desc "Menu bar app that converts typed text between keyboard layouts"
  homepage "https://github.com/pggolub/flipio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Flipio.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Flipio.app"]
  end

  uninstall quit: "com.flipio.app"

  zap trash: [
    "~/Library/Preferences/com.flipio.app.plist",
    "~/Library/Caches/com.flipio.app",
    "~/Library/HTTPStorages/com.flipio.app",
  ]

  caveats <<~EOS
    Flipio is ad-hoc signed (not notarized — the author is not in the Apple
    Developer Program). The postflight step removes macOS Gatekeeper's
    quarantine attribute so the app can launch. Review the source at
    #{homepage} before installing if that concerns you.

    On first launch, grant Accessibility permission.
  EOS
end
