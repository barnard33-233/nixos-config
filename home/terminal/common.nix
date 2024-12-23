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

    gnumake

    jq
    ripgrep
    tree
    file
    cloc

    xclip

    htop
    dust

    tealdeer

    httping
    inetutils
    pciutils

    tpm2-tools

    ffmpeg
    yt-dlp

    trash-cli

    yazi

    inputs.mohan-nixvim.packages."x86_64-linux".default

    nodejs_22
    python311
    
    appimage-run
  ];
  home.sessionVariables.EDITOR = "nvim";
}
