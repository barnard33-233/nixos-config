{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    spotify 
    obsidian
    zotero

    thunderbird
    birdtray
    obs-studio

    # im
    qq
    telegram-desktop

    # music
    musescore
    reaper

    # games
    lutris

    # wine
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    winetricks

  ];
  imports = [
    ./chromium.nix
    ./vscode.nix
  ];
}
