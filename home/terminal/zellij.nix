{pkgs, ... }:
{
  home.packages = [ pkgs.zellij ];
  xdg.configFile."zellij" = {
    enable = true;
    recursive = true;
    source = ./zellij;

  };
}
