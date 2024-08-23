{config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    firefox
    chromium

    spotify 
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
    ./vscode.nix
  ];
}
