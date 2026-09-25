{ lib, pkgs, ... }:
{
  # common nix settings
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  # common services
  services = {
    openssh = {
      enable = lib.mkDefault true;
      openFirewall = true;

      settings = {
        PasswordAuthentication = lib.mkDefault false;
        KbdInteractiveAuthentication = lib.mkDefault false;
        PermitRootLogin = lib.mkDefault "prohibit-password";
      };
    };
    journald.settings.Journal.RuntimeMaxUse = lib.mkDefault "10M";
  };

  # common network config
  networking = {
    firewall.allowedTCPPorts = [ 80 443 ];
    # 24996 - 24999 are reserved for temporary services, such as iperf3. 
    firewall.allowedTCPPortRanges = [
      {from = 24996; to = 24999;}
    ];
    firewall.allowedUDPPortRanges = [
      {from = 24996; to = 24999;}
    ];
  };

  # common packages
  environment.systemPackages = with pkgs; [
    vim
    curl
    gitMinimal
    htop
    fastfetch
    tmux
  ];

  # common kernel settings
  boot.kernelParams = [
    "audit=0"
    "net.ifnames=0"
  ];
}
