cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1112.6"
  sha256 arm:   "acc779f78980a0494768cebb98f04268d6ff065e2913b4859fa8ea59c0d2e585",
         intel: "cc013a1934c89c10c6021483a014c381d7cf8d319b155f7d9c16bf402f11754d"

  url "https://github.com/DIYgod/pinky/releases/download/v#{version}/pinky-#{version}-darwin-#{arch}.zip"
  name "Pinky"
  desc "Let AI agents use your phone, with you in the loop"
  homepage "https://github.com/DIYgod/pinky"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Pinky.app"
  command_wrapper "pinkyctl",
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

  caveats <<~EOS
    Agents start Pinky with: pinkyctl mcp
      claude mcp add pinky -- pinkyctl mcp
    The command was named pinky before, a name coreutils has too: change
    agents that run "pinky mcp" to run "pinkyctl mcp".
  EOS
end
