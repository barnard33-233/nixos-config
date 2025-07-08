{config, pkgs, lib, inputs, ...}:
let
  cfg = config.customHome.fcitx5;
  linyinfeng = import inputs.linyinfeng-717ab9baaaca4fe6ae7dfd037a480de9dfce51fb {inherit pkgs;};
  fcitx5-rime-override = pkgs.fcitx5-rime.override {
    rimeDataPkgs = with linyinfeng.rimePackages;
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
          pkgs.fcitx5-gtk
          pkgs.libsForQt5.fcitx5-qt
        ];
      };
    };
    home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
      source = ./rime/default.custom.yaml;
    };
  };

}
