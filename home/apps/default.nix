{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    spotify 
    obsidian
    zotero

    thunderbird
    obs-studio

    # diagrams
    # yed

    libsForQt5.kdenlive
    vlc

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

    # i want to try:
    cosmic-files

    gimp-with-plugins

  ];
  imports = [
    ./chromium.nix
    ./vscode.nix
  ];
}
