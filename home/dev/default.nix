{pkgs, config, ...}:
{
  home.packages = with pkgs;[
    nodejs_22

    # default python env
    python311
  ];
  imports = [
    ./direnv.nix
  ];
}
