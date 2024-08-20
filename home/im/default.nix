{config, pkgs, lib, inputs, ...}:
let
  fcitx5-rime-override = pkgs.fcitx5-rime.override {
    rimeDataPkgs = with config.nur.repos.linyinfeng.rimePackages;
      withRimeDeps [
        # (rime-ice.override {schemaRegex = "^rime_ice$"; })
        rime-ice
      ];
  };
in
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = [
        fcitx5-rime-override
        # pkgs.fcitx5-rime
        pkgs.fcitx5-chinese-addons
        # config.nur.repos.xddxdd.rime-ice 
      ];
    };
  };
  home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
    source = ./rime/default.custom.yaml;
  };
}
