{config, pkgs, lib, ...}:
let
  cfg = config.customHome.neovide;
in
{
  options.customHome.neovide = {
    enable = lib.mkEnableOption "Neovide Config.";
    bin = lib.mkOption {
      type = lib.types.package;
      default = pkgs.neovim;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.neovide];
    home.file.".config/neovide/config.toml" =
    let
      tomlFormat = pkgs.formats.toml { };
    in
    {
      source = tomlFormat.generate "neovide-config" {
        neovim-bin = lib.getExe cfg.bin;
        frame = "none";
        font = {
          normal = [
            "JetbrainsMono Nerd Font"
            "Noto Sans Mono CJK SC"
            "Ubuntu"
          ];
          size = 16.0;
        };
      };
    };
  };
}
