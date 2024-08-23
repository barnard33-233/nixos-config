{pkgs, ...}:
{
  home.packages = with pkgs;[
    gnome.gnome-tweaks
    # gnome.gnome-themes-extra
    gnome.dconf-editor
    bibata-cursors

    # extentions
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.custom-accent-colors
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
    gnomeExtensions.system-monitor
    gnomeExtensions.x11-gestures
    gnomeExtensions.alttab-mod
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.space-bar
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.kimpanel
  ];
  imports = [
    ./dconf.nix
  ];
}
