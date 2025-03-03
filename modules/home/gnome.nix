{lib, pkgs, config, ...}:
let
  cfg = config.customHome.gnome;
in
{
  options.customHome.gnome = {
    enable = lib.mkEnableOption "Gnome Config(Home)";
    enableExtensions = lib.mkEnableOption "Enable Gnome Plugins";
    favoriteApps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
  config = {

    home.packages = lib.mkMerge [
      (with pkgs;[
        gnome-tweaks
        # gnome.gnome-themes-extra
        dconf-editor
        bibata-cursors
      ])

      # extentions
      (lib.mkIf cfg.enableExtensions (with pkgs.gnomeExtensions;[
        appindicator
        user-themes
        # custom-accent-colors
        removable-drive-menu
        legacy-gtk3-theme-scheme-auto-switcher
        system-monitor
        # x11-gestures
        alttab-mod
        # blur-my-shell
        dash-to-dock
        gnome-40-ui-improvements
        space-bar
        tray-icons-reloaded
        kimpanel
      ]))
    ];

    dconf.enable = true;

    dconf.settings = {
      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = [ "<Alt>v" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-10 = [ "<Super><Shift>0" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-6 = [ "<Super><Shift>6" ];
        move-to-workspace-7 = [ "<Super><Shift>7" ];
        move-to-workspace-8 = [ "<Super><Shift>8" ];
        move-to-workspace-9 = [ "<Super><Shift>9" ];
        move-to-workspace-last = [];
        move-to-workspace-left = [];
        move-to-workspace-right = [];
        show-desktop = [ "<Super>d" ];
        switch-applications = [];
        switch-applications-backward = [];
        switch-input-source = [ "<Shift><Control>space" ];
        switch-input-source-backward = [ "<Control>space" ];
        switch-to-workspace-last = [];
        switch-to-workspace-left = [ "<Super>bracketright" ];
        switch-to-workspace-right = [ "<Super>bracketleft" ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        toggle-maximized = [ "<Super>Up" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
        search = [ "<Alt>space" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = lib.mkIf config.customHome.alacritty.enable {
        binding = "<Super>t";
        command = "alacritty";
        name = "terminal";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>e";
        command = "nautilus";
        name = "nautilus";
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = false;
        center-new-windows = true;
        dynamic-workspaces = false;
        experimental-features = [ "scale-monitor-framebuffer" ];
        workspaces-only-on-primary = false;
      };

      "org/gnome/shell" = {
        disable-extension-version-validation = false;
        disable-user-extensions = false;
        enabled-extensions = lib.mkIf cfg.enableExtensions [
          "legacyschemeautoswitcher@joshimukul29.gmail.com"
          # "x11gestures@joseexposito.github.io"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "alttab-mod@leleat-on-github"
          "gnome-ui-tune@itstime.tech"
          "gradienttopbar@pshow.org"
          "appindicatorsupport@rgcjonas.gmail.com"
          # "custom-accent-colors@demiskp"
          "dash-to-dock@micxgx.gmail.com"
          "space-bar@luchrioh"
          "trayIconsReloaded@selfmade.pl"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          # "blur-my-shell@aunetx" 
          "kimpanel@kde.org"
        ];
        favorite-apps = cfg.favoriteApps;
      };
    };
  };
}
