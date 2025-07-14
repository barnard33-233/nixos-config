{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.paste-bin.nixosModules.x86_64-linux.default
    {
      services.paste-bin = {
        enable = true;
        bindAddress = "[::]:8080";
      };
    }
  ];
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  
  users.groups.admin = {};
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "admin";
      group = "admin";
    };
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = false;
      forwardPorts = [
        { from = "host"; host.port = 2222; guest.port = 22; proto = "tcp"; }  # SSH
        { from = "host"; host.port = 8080; guest.port = 8080; proto = "tcp"; }  # Web server
    ];
    };
  };

  services.openssh = {
    enable = true;
    # remove this line before deploy
    settings.PasswordAuthentication = true;
  };

#  services.sing-box = 
#  let
#    TLSConf = {
#      enable = true;
#      server_name = "test";
#      key_path = "/"; # TODO
#      certificate_path = "/"; #TODO
#    };
#  in
#  {
#    enable = true;
#    settings = {
#      log = { level = "warn";};
#      inbounds = [
#        {
#          type = "hysteria2";
#          tag = "hys-1";
#          listen = "::";
#          listen_port = "8888";
#          tcp_multi_path = true;
#          tcp_fast_open = true;
#          users = [
#            {
#              name = "test";
#              password = "test@pass";
#            }
#          ];
#          # TODO: obfs
#          tls = TLSConf;
#          brutal_debug = false;
#        }
#      ];
#      outbounds = [
#        {
#          type = "direct";
#        }
#      ];
#      route = {};
#      experimental = {};
#    };
#  };
# 

  networking.firewall.allowedTCPPorts = [ 22 8080];
  environment.systemPackages = with pkgs; [
    htop
  ];

  system.stateVersion = "23.05";
}
