cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1109.1"
  sha256 arm:   "bec49ec6ce6a82aa2661292d211629312925d837491c5a5aeadbe71345d3b5c3",
         intel: "f2eb3a8b0bf6eb8258413ca3cfde880ccc2c6b48dddffa089c9c52c09f0a3071"

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
