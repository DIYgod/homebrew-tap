cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1108.18"
  sha256 arm:   "f139e59b7863f4d303d257db3bf41788113de30ae7f3bdc1cacf8f6e1796d3b0",
         intel: "ad43c9410c5a0988ea02b164657cd8342ed09d26f697a934e7b3878ab32de88a"

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
