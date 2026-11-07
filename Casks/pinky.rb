cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1107.8"
  sha256 arm:   "6248e077ab222f8c0d810f74c52aaadacfd474ec7472f7bfe3389a4d5a37eccb",
         intel: "c2c22abafb0549ae503db40a8cd1dc12b8e14e3b08eac1b5871fbfd87c0ee6f0"

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
