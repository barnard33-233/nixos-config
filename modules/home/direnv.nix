{pkgs, config, lib, ...}:
let
  cfg = config.customHome.direnv;
in
{
  options.customHome.direnv = {
    enable = lib.mkEnableOption "Direnv Config";
  };
  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
