{ config, ... }:
{
  homebrew = {
    enable = true;

    brews = [
      "python@3.12"
      "opencode"
      "gromgit/fuse/ntfs-3g-mac"
    ];

    casks = [
      "visual-studio-code"
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
