{config, pkgs, lib, ...}:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-configtool
      fcitx5-chinese-addons
    ];
  };
  environment.systemPackages = with pkgs; [ config.nur.repos.xddxdd.rime-ice ];
}
