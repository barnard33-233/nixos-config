{pkgs, config, inputs, ...}:
{
  imports = [
    ./common.nix
    ./git.nix
    ./shell.nix
    ./zellij.nix
    ./alacritty.nix
  ];
}
