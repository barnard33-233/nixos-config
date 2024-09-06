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

    xclip

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

    httping
    gnumake
  ];
  home.sessionVariables.EDITOR = "nvim";
}
