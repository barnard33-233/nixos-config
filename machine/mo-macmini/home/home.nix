{ pkgs, inputs, ...}:
{
  imports = [
    ../../../modules/home
  ];
  home = {
    username = "mohan";
    homeDirectory = "/User/mohan";
  };
  home.stateVersion = "24.05"
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
    fcitx5.enable = false;
    fish.enable = true;
    git.enable = true;
    gnome.enable = false;
    vscode.enable = false;
    zellij.enable = true;
  };
}
