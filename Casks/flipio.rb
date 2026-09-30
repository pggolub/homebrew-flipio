cask "flipio" do
  version "1.0.4"
  sha256 "d6aeb6f9eddd5e61706f361575451dae0d878839633fbd9e0df4459911a249f1"

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
