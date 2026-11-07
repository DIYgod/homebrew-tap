cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1107.4"
  sha256 arm:   "bfa42fede934f125185227e1c37ae221c5193b62045c582017f8fa480f6377af",
         intel: "52c473384fc4a6390c9c9bcaaf244290595d2a5249bf41ff4a1a0dc7d0663ce5"

  url "https://github.com/DIYgod/pinky/releases/download/v#{version}/pinky-#{version}-darwin-#{arch}.zip"
  name "Pinky"
  desc "Let AI agents use your phone, with you in the loop"
  homepage "https://github.com/DIYgod/pinky"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :monterey"

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
