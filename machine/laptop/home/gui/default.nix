{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    alacritty

    spotify 
    netease-cloud-music-gtk
    obsidian
    zotero

    thunderbird
    obs-studio

    libsForQt5.kdenlive
    vlc

    wireshark-qt
    dosbox

    # im
    qq
    telegram-desktop

    # wpsoffice

    # music
    musescore
    reaper
    metronome
    lingot

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

    guitarix
    qpwgraph

    vscode
  ];
}
