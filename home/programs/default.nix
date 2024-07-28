{pkgs, config, ...}:
{
  imports = [
    ./common.nix
    ./git.nix
    # ./clash.nix
    ./shell.nix
    # ./nvim.nix
    ./zellij.nix
  ];
}
