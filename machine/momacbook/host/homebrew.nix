{ config, ... }:
{
  homebrew = {
    enable = true;

    brews = [
      "python@3.12"
      "claude-code-router"
      "opencode"
      "gromgit/fuse/ntfs-3g-mac"
    ];

    casks = [
      "visual-studio-code"
      "claude-code@latest"
      "squirrel-app"
      "tailscale-app"
      "reaper"
      "onlyoffice"
      "easydict"
      "drawio"
      "steam"
      "macfuse"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "none";
    };

    taps = builtins.attrNames config.nix-homebrew.taps;
  };
}
