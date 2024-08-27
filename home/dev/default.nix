{pkgs, config, ...}:
{
  home.packages = with pkgs;[
    nodejs_22
  ];
  imports = [
    ./direnv.nix
  ];
}
