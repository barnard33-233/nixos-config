{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    spotify 
    vscode # TODO remove this line after configure vscode
    obsidian
    zotero
    # wpsoffice
    thunderbird
    birdtray
    obs-studio

    ## tencent
    qq
  ];
  imports = [
    ./chromium.nix
  ];
}
