cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1110.31"
  sha256 arm:   "7b5c8ee5f055d57587469d52d92c9eef0e75aa0374f71780fda50579021a69fd",
         intel: "a965bebc132eb60c0cc5d35f3ff8cb13ebfd55f48c45615c3272aeb525d51254"

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
