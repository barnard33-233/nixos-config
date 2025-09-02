{ config, lib, pkgs, modulesPath, inputs, ... } @args: {
  _module.args = {
    sld = "mossite.homes";
  };
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk.nix
    ./hardware-configuration.nix
    ./caddy.nix
    ./cloud-init.nix
    ./paste-bin.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader.grub = {
    efiSupport = false;
    configurationLimit = 3;
    # efiInstallAsRemovable = true;
  };
  
  # basic services
  services = {
    openssh = {
      enable = true;
      permitRootLogin = "prohibit-password";
    };

    journald = {
      extraConfig = ''
        RuntimeMaxUse=10M
      '';
    };
  };

  users.groups.mo = {};
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2SL21V7FPVzxm/bgT8Jfz9iaMRE1D3YA4bm4Ukml6kj89hhWUHLnyr94zRZd//ZQ50MoO8VK5tF5UmBadyLACRqt+LK7l6yWmXokLC0B+NTJ2MEaHOl03BduUJK7cClsnpDNK55uXqggvZfitIxLUkn9FCVa3FH1qrY9TOokB3HQcxV/4S0FXRnn8Bu2s9koFjbEJvT6dnwXHjgDEShNqpMNMcf6DL9ck6I1WWS0/ZnDeVYgmzLEPbN7bZlPc/xGUTwZZ8l3WVrPQmR5FD4bR4vqLAMhNu8B27u5Kmr5Dkbw6X5RrPAlS3SBrmohtZ2z42sN4XKOfUYvrU/UfYS8r"
      ];
    };
    mo = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      group = "mo";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDqszaMPp24YWX6k3FnFPApbSV7q5+S/lwK/DtGgO4yA htang0203@gmail.com"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 8080 80 443 ];

  environment.systemPackages = map lib.lowPrio (with pkgs; [
    vim
    curl
    gitMinimal
    htop
    fastfetch
    iperf3
  ]);

  system.stateVersion = "23.05";
}
