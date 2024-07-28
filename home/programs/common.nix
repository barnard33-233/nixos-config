{pkgs, ...}:
{
  home.packages = with pkgs; [
    neofetch

    zip
    unzip
    gzip
    xz

    neovim
    alacritty
#    fish
    tmux

    ripgrep
    jq
    file
    tree
    htop
    
    # clash-meta

    firefox
    chromium
  ];

  home.sessionVariables.EDITOR = "nvim";
  
}
