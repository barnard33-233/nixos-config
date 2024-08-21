{pkgs, ...}:
{
  home.packages = with pkgs; [
    neofetch

    # --tools--
    zip
    unzip
    gzip
    xz

    ## shell
    neovim
    alacritty
    tmux

    ripgrep
    jq
    file
    tree
    htop

    ## storage
    dust

    # --desktop--
    firefox
    chromium

    spotify 
    vscode # TODO remove this line after configure vscode
    obsidian
    zotero
    # wpsoffice
    thunderbird
    birdtray
    ticktick
    obs-studio

    ## tencent
    qq
    # wechat-uos
  ];

  home.sessionVariables.EDITOR = "nvim";
  
}
