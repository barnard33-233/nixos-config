{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    fastfetch
    cmd-wrapped

    zip
    unzip
    gzip
    xz

    tmux
    ranger

    jq
    ripgrep
    tree
    file
    cloc

    pdftk
    librsvg

    htop
    dust

    tealdeer

    ffmpeg
    yt-dlp

    trash-cli

    inputs.mohan-nixvim.packages."aarch64-darwin".default
  ];
  home.sessionVariables.EDITOR = "nvim";
}
