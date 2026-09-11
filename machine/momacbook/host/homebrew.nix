{ ... }:
{
  homebrew = {
    enable = true;

    brews = [
      "python@3.12"
      "claude-code-router"
      "opencode"
    ];

    casks = [
      "visual-studio-code"
      "claude-code@latest"
      "squirrel-app"
      "tailscale-app"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "none";
    };

    # taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
