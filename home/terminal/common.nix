{pkgs, inputs, ...}:
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
    nix-output-monitor

    ranger

    inputs.mohan-nixvim.packages."x86_64-linux".default
  ];
  home.sessionVariables.EDITOR = "nvim";
}
