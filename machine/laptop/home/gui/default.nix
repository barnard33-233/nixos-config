{config, pkgs, lib, inputs,...}:
let
  pkgs-musescore = import inputs.nixpkgs-musescore444 {
    system = "x86_64-linux";
  };
  xddxdd = import inputs.xddxdd {
    inherit pkgs;
  };
in
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

    xddxdd.baidunetdisk

    # music
    pkgs-musescore.musescore
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

    guitarix
    qpwgraph

    vscode
  ];
}
