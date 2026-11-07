cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1107.9"
  sha256 arm:   "1540b46dbb59e4102a19ef32cefef18cc6c30ed7a6608b659aca6fb6ab3ee8fc",
         intel: "4ea42ffbba291d49bde8e227bb8c41acd1627da3b82a43a94745c169d1164786"

  url "https://github.com/DIYgod/pinky/releases/download/v#{version}/pinky-#{version}-darwin-#{arch}.zip"
  name "Pinky"
  desc "Let AI agents use your phone, with you in the loop"
  homepage "https://github.com/DIYgod/pinky"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :monterey

  app "Pinky.app"
  command_wrapper "pinky",
                  executable: "#{appdir}/Pinky.app/Contents/MacOS/Pinky"

  uninstall quit: "app.pinky.desktop"

  zap trash: [
    "~/Library/Application Support/Pinky",
    "~/Library/Caches/app.pinky.desktop",
    "~/Library/HTTPStorages/app.pinky.desktop",
    "~/Library/Logs/Pinky",
    "~/Library/Preferences/app.pinky.desktop.plist",
    "~/Library/Saved Application State/app.pinky.desktop.savedState",
  ]
end
