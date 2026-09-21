{ config, lib, pkgs, modulesPath, inputs, ... } @args: {
  _module.args = {
    sld = "mossite.homes";
  };
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    # ./caddy.nix
    # ./cloud-init.nix
    # ./sops.nix
    # ../../../modules/nixos
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    efiSupport = false;
    configurationLimit = 3;
    # efiInstallAsRemovable = true;
  };

  boot.kernelParams = [
    "audit=0"
    "net.ifnames=0"
  ];

  # programs = {
  #   mosh = {
  #     enable = true;
  #     openFirewall = true;
  #   };
  # };
  
  # basic services
  services = {
    openssh = {
      enable = true;
      ports = [ 10022 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    journald = {
      settings.Journal = {
        RuntimeMaxUse="10M";
      };
    };
  };

  users.groups.mo = {};
  users.users = {
    root = {
      hashedPassword = "!";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIs85N96/ZOfoJFQ3nxMzWSbmC2IwQ51R64/+4FsRC8M htang0203@gmail.com"
      ];
    };
    mo = {
      isNormalUser = true;
      hashedPassword = "!";
      extraGroups = [ "wheel" ];
      group = "mo";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDqszaMPp24YWX6k3FnFPApbSV7q5+S/lwK/DtGgO4yA htang0203@gmail.com"
      ];
    };
  };

  networking = {
    firewall.allowedTCPPorts = [ 22 80 443 10022 8443 ];
  };

  environment.systemPackages = map lib.lowPrio (with pkgs; [
    vim
    curl
    gitMinimal
    htop
    fastfetch
    iperf3
    tmux
    sing-box
  ]);
  
  swapDevices = [
    {
      device = "/swapfile";
      size = 512;
    }
  ];

  # own modules
  # custom.sing-box = {
  #   enable = true;
  #   fakeServerName = "bin.mossite.homes";
  # };
  system.stateVersion = "26.05";
}
