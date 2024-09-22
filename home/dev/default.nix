{pkgs, config, ...}:
{
  home.packages = with pkgs;[
    nodejs_22

    # default python env
    python311

    # default cpp env
    bear
    gcc
    gdb
  ];
  imports = [
    ./direnv.nix
  ];
}
