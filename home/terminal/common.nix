{pkgs, ...}:
{
  home.packages = with pkgs; [
    fastfetch

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

    cloc
  ];
  home.sessionVariables.EDITOR = "nvim";
}
