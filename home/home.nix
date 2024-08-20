{config, pkgs, inputs, ...}:
{
  imports = [
    inputs.nur.hmModules.nur
    ./programs
    ./gnome
    ./nvim
    ./im
  ];
  home = {
    username = "tang_";
    homeDirectory = "/home/tang_";    
  };
  xdg.enable = true;

  home.stateVersion = "24.05";
 
  programs.home-manager.enable = true;

}
