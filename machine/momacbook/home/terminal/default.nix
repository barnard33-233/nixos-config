{pkgs, config, inputs, ...}:
{
  imports = [
    ./common.nix
    ./shell.nix
    ./docker.nix
    ./pi.nix
  ];
}
