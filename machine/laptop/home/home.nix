{config, pkgs, inputs, ...}:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./terminal # commandline
    ./gui
    ./flatpak.nix
    ../../../modules/home
  ];
  home = {
    username = "tang_";
    homeDirectory = "/home/tang_";    
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # my own modules
  customHome = {
    alacritty = {
      enable = true;
      defaultTerminal = true;
    };
    chromium = {
      enable = true;
      enableExtensions = true;
    };
    direnv.enable = true;
    fcitx5.enable = true;
    fish.enable = true;
    git.enable = true;
    gnome = {
      enable = true;
      enableExtensions = true;
      favoriteApps = [
        "chromium-browser.desktop"
        "spotify.desktop"
        "Alacritty.desktop"
        "code.desktop"
        "obsidian.desktop"
        "zotero.desktop"
      ];
    };
    vscode.enable = false;
    zellij.enable = true;
  };

  xdg.enable = true;
  home.sessionVariables = {
    # to fix weird behavior of moz apps with nvidia driver 555 
    MOZ_ENABLE_WAYLAND = "0";
  };
}
