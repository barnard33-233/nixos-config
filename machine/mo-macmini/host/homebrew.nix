{ ... }:
{
  homebrew = {
    enable = true;

    brews = [
      "python@3.12"
    ];

    casks = [
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
