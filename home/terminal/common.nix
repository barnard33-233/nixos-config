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
    alacritty
    tmux

    ripgrep
    jq
    file
    tree
    htop
    dust
    tealdeer
    inetutils
    ffmpeg
    yt-dlp


  ];
  home.sessionVariables.EDITOR = "nvim";
}
