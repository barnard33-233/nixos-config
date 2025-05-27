{lib, config, pkgs, ...}:
let
  cfg = config.customHome.alacritty;
in
{
  options.customHome.alacritty = {
    enable = lib.mkEnableOption "Alacritty Config.";
    defaultTerminal = lib.mkEnableOption "Set Alacritty as the default Terminal.";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."alacritty" = {
      enable = true;
      recursive = true;
      source = ./alacritty;
    };
    home.activation.setDefaultTerminal = lib.mkIf cfg.defaultTerminal (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.default-applications.terminal exec-arg -e
    '');
  };
}
