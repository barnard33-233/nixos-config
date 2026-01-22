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

    spotify 
    netease-cloud-music-gtk
    obsidian
    zotero

    thunderbird
    obs-studio

    kdePackages.kdenlive
    vlc

    wireshark-qt
    dosbox
    localsend

    # im
    qq
    telegram-desktop
    feishu

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
    code-cursor
    codex
    claude-code

    gimp-with-plugins

    guitarix
    qpwgraph
  ];
}
