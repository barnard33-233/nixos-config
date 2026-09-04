{lib, config, pkgs, ...}:
let
  cfg = config.customHome.alacritty;

  # Render a string as a TOML basic string (escapes backslash and double quote).
  toTomlStr = s: ''"${lib.replaceStrings [ "\\" "\"" ] [ "\\\\" "\\\"" ] s}"'';

  baseConfig = builtins.readFile ./alacritty/alacritty.toml;
  shellConfig = ''
    [terminal.shell]
    program = ${toTomlStr cfg.shell}
  '' + lib.optionalString (cfg.shellArgs != []) ''
    args = [ ${lib.concatMapStringsSep ", " toTomlStr cfg.shellArgs} ]
  '';
in
{
  options.customHome.alacritty = {
    enable = lib.mkEnableOption "Alacritty Config.";
    defaultTerminal = lib.mkEnableOption "Set Alacritty as the default Terminal.";
    shell = lib.mkOption {
      type = lib.types.str;
      default = "bash";
      description = "Shell program launched by Alacritty.";
    };
    shellArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Arguments passed to the shell program.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.alacritty ];
    xdg.configFile."alacritty/alacritty.toml".text = ''
      ${baseConfig}
      ${shellConfig}
    '';
    home.activation.setDefaultTerminal = lib.mkIf cfg.defaultTerminal (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.default-applications.terminal exec alacritty
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.default-applications.terminal exec-arg -e
    '');
  };
}
