{config, pkgs, lib, inputs,...}:
let
  xddxdd = import inputs.xddxdd {
    inherit pkgs;
  };
in
{
  home.packages = with pkgs; [
    raycast
    keycastr
    localsend

    firefox
    google-chrome

    spotify 
    obsidian

    thunderbird

    # im
    telegram-desktop

    # music
    reaper
    musescore

    gimp
  ];
}
