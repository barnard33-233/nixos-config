{lib, config, pkgs, ... }:
let
  cfg = config.customHome.zellij;
in
{
  options.customHome.zellij = {
    enable = lib.mkEnableOption "Zellij Config.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.zellij ];
    xdg.configFile."zellij" = {
      enable = true;
      recursive = true;
      source = ./zellij;
    };
  };
}
