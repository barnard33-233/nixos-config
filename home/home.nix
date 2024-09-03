{config, pkgs, inputs, ...}:
{
  imports = [
    inputs.nur.hmModules.nur
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./terminal # commandline
    ./apps # gui apps
    ./gnome
    ./nvim
    ./im
    ./flatpak
    ./dev
  ];
  home = {
    username = "tang_";
    homeDirectory = "/home/tang_";    
  };
  xdg.enable = true;
  home.sessionVariables = rec {
    # to fix weird behavior of moz apps with nvidia driver 555 
    MOZ_ENABLE_WAYLAND = "0";
  };


  home.stateVersion = "24.05";
 
  programs.home-manager.enable = true;

}
