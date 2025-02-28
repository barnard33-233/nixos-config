# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./font.nix
      ../../modules/nixos
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "mochine"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY= "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEOHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  # services.xserver.displayManager.gdm.wayland = false;
  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  #gpu
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.42.02";
      sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
      persistencedSha256 = lib.fakeSha256;
    };
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = true;
    modesetting.enable = true;
  };

  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplipWithPlugin
    ];
    logLevel = "debug";
  };

  services.avahi = {
    enable = false;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.logind.lidSwitch = "ignore";

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "04:00";
    options = "--delete-older-than 15d";
  };
  
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    clash-meta

    virtualbox
    virt-manager
    qemu
    lshw
    glxinfo
    nix-output-monitor
    nh

    # ?
    swtpm
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tang_ = {
    isNormalUser = true;
    home = "/home/tang_";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" "realtime"];
  };

  users.extraGroups.vboxusers.members = [ "tang_" ];

  nix.settings.trusted-users = [ "tang_" ];

  systemd.services.clash-meta = {
    enable = true;
    path = [ pkgs.clash-meta ];
    unitConfig = {
      Description = "clash meta.";
      After = "network.target";
    };
    serviceConfig = {
      ExecStart = "${pkgs.sudo}/bin/sudo clash-meta -d /home/tang_/.config/clash"; # XXX
      # Type = "exec";
      Restart = "on-abort";
    };
    wantedBy = [ "multi-user.target" ];
    
  }; 

  # TODO: idk why...
  systemd.services.NetworkManager-wait-online.enable = false;

  systemd.services.nix-daemon.environment = {
    http_proxy = "http://localhost:7890";
    https_proxy = "http://localhost:7890";
    all_proxy = "http://localhost:7890";
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  
  # virtualization
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };

    virtualbox = {
      host.enable = true;
    };

    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  # programs.virt-manager = true;

  # steam
  programs.steam = {
    enable = true;
  };

  system.copySystemConfiguration = false;

  nix.settings.substituters = [
    "https://mirrors.cernet.edu.cn/nix-channels/store?priority=20"
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

