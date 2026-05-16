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
    chromium

    spotify 
    obsidian
    zotero

    thunderbird
    obs-studio

    kdePackages.kdenlive
    vlc

    wireshark
    localsend

    # im
    qq
    telegram-desktop
    feishu

    # music
    pkgs-musescore.musescore
    reaper

    # games
    # lutris

    # wine
    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    # winetricks

    gimp-with-plugins

    guitarix
    qpwgraph
  ];
}
