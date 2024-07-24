{config, pkgs, ...}:
{
  imports = [
    ./programs
  ];
  home = {
    username = "tang_";
    homeDirectory = "/home/tang_";    
  };

  home.stateVersion = "24.05";
 
 
  programs.home-manager.enable = true;

}
