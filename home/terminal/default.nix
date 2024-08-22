{pkgs, config, ...}:
{
  imports = [
    ./common.nix
    ./git.nix
    ./shell.nix
    ./zellij.nix
    ./alacritty.nix
  ];
}
