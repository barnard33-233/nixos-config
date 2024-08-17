{pkgs, ...}:
{
  home.packages = with pkgs; [
    neofetch

    # --tools--
    zip
    unzip
    gzip
    xz

    neovim
    alacritty
    tmux

    ripgrep
    jq
    file
    tree
    htop

    firefox
    chromium

    # --desktop--
    # spotify # TODO: handle unfree
    vscode # TODO remove this line after configure vscode
    # obsidian
    # zotero

  ];

  home.sessionVariables.EDITOR = "nvim";
  
}
