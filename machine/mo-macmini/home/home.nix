{ pkgs, inputs, ...}:
{
  imports = [
    ../../../modules/home
    ./terminal
    ./gui
  ];
  home = {
    username = "mohan";
    homeDirectory = "/Users/mohan";
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # my own modules
  customHome = {
    alacritty = {
      enable = true;
      defaultTerminal = false;
    };
    chromium.enable = false;
    direnv.enable = true;
    fcitx5.enable = false;
    fish.enable = true;
    git.enable = true;
    gnome.enable = false;
    vscode.enable = false;
    zellij.enable = true;
  };
}
