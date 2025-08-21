{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    fastfetch
    cmd-wrapped

    zip
    unzip
    gzip
    xz

    mosh
    tmux
    ranger

    gnumake
    gdb
    gef

    jq
    ripgrep
    tree
    file
    cloc

    pdftk
    librsvg

    xclip

    htop
    dust

    tealdeer

    inetutils
    dnsutils
    mailutils
    pciutils
    iperf3

    tpm2-tools

    ffmpeg
    yt-dlp

    trash-cli

    yazi

    inputs.mohan-nixvim.packages."x86_64-linux".default

    nodejs_22
    python311
    
    appimage-run
    stress-ng
  ];
  home.sessionVariables.EDITOR = "nvim";
}
