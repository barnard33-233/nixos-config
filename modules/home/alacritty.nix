{lib, config, ...}:
let
  cfg = config.customHome.alacritty;
in
{
  options.customHome.alacritty = {
    enable = lib.mkEnableOption "Alacritty Config.";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."alacritty" = {
      enable = true;
      recursive = true;
      source = ./alacritty;
    };
  };
}
