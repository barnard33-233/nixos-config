{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    alacritty

    spotify 
    obsidian
    zotero

    thunderbird
    obs-studio

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

    # config.nur.repos.novel2430.wemeet-bin-bwrap
  ];
}
