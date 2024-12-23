{pkgs, config, input, lib, ...}:
{
  home.packages = [ pkgs.flatpak ];
  services.flatpak.enable = true;
  services.flatpak.remotes = lib.mkOptionDefault [
    {name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
  ];
  services.flatpak.packages = [
    "com.wps.Office"
    "com.tencent.WeChat"
    "com.tencent.wemeet"
  ];
  # home.sessionVariables.XDG_DATA_DIRS = "$HOME/.local/share/flatpak/exports/share/:$XDG_DATA_DIRS";
}
