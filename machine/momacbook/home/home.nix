{ pkgs, inputs, ...}:
{
  imports = [
    ../../../modules/home
    ./terminal
    ./gui
  ];
  home = {
    username = "mo";
    homeDirectory = "/Users/mo";
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # my own modules
  customHome = {
    alacritty = {
      enable = true;
      defaultTerminal = false;
      shell = "zsh";
      shellArgs = [ "-l" "-c" "exec fish" ];
    };
    chromium.enable = false;
    direnv.enable = true;
    fcitx5.enable = false;
    fish = {
      enable = true;
      appendInteractiveShellInit = ''
        /opt/homebrew/bin/brew shellenv | source
      '';
    };
    git.enable = true;
    gnome.enable = false;
    vscode.enable = false;
    zellij.enable = true;
  };
}
