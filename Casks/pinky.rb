cask "pinky" do
  arch arm: "arm64", intel: "amd64"

  version "2026.1108.11"
  sha256 arm:   "97ab4169159b688e64e3bcf883029584173599c38dd75c85fb610c1519476e4f",
         intel: "167f5baa144920db5bd6b7131c99485c97ea296b6a4e6d5cdaa251758645edba"

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
