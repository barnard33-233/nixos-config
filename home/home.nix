{config, pkgs, ...}:
{
  home.username = "tang_";
  home.homeDirectory = "/home/tang_";  
  
  home.packages = with pkgs; [
    neofetch

    # archive
    zip
    unzip
    gzip
    xz

    neovim
    alacritty
    fish

    ripgrep
    jq
    file
    tree
    htop

    firefox
    chromium
  ];
  
  programs.git = {
    enable = true;
    userName = "barnard33-233";
    userEmail = "htang0203@gmail.com";
  };
  
  # alacritty
  
  # fish
  
  # nvim
  
  # vim

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

}
