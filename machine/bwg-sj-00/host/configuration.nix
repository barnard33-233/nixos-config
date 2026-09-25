{ config, lib, pkgs, modulesPath, inputs, ... } @args: {
  _module.args = {
    sld = "mossite.homes";
  };
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./caddy.nix
    # ./cloud-init.nix
    ./sops.nix
    ./ci.nix
    ../../../modules/nixos
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    efiSupport = false;
    configurationLimit = 3;
    # efiInstallAsRemovable = true;
  };

  # basic services
  services = {
    openssh = {
      enable = true;
      ports = [ 10022 ];
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
    firewall.allowedTCPPorts = [ 8443 ];
  };

  environment.systemPackages = map lib.lowPrio (with pkgs; [
    iperf3
    sing-box
  ]);
  
  swapDevices = [
    {
      device = "/swapfile";
      size = 512;
    }
  ];

  # own modules
  custom.sing-box = {
    enable = false;
    fakeServerName = "bin.mossite.homes";
  };

  system.stateVersion = "26.05";
}
