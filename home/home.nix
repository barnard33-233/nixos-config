{config, pkgs, inputs, ...}:
{
  imports = [
    inputs.nur.hmModules.nur
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./programs
    ./gnome
    ./nvim
    ./im
    ./flatpak
  ];
  home = {
    username = "tang_";
    homeDirectory = "/home/tang_";    
  };
  xdg.enable = true;

  home.stateVersion = "24.05";
 
  programs.home-manager.enable = true;

}
