{config, pkgs, lib, inputs, ...}:
let
  cfg = config.customHome.fcitx5;
  fcitx5-rime-override = pkgs.fcitx5-rime.override {
    rimeDataPkgs = with config.nur.repos.linyinfeng.rimePackages;
      withRimeDeps [
        rime-ice
      ];
  };
in
{
  options.customHome.fcitx5 = {
    enable = lib.mkEnableOption "Fcitx5 Config.";
  };

  config = lib.mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = [
          fcitx5-rime-override
          pkgs.fcitx5-chinese-addons
        ];
      };
    };
    home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
      source = ./rime/default.custom.yaml;
    };
  };

}
