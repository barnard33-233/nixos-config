{lib, config, pkgs, ...}: 
let
  cfg = config.custom.sing-box;

  # user list
  users = [
    "mo"
  ];

  # real configurations
  mkSettings = users: {
    log = {
      timestamp = true;
      level = "info";
    };

    inbounds = [
      # VL-R
      {
        tag = "vlr";
        type = "vless";
        listen = "::";
        listen_port = 8443;
        tls = {
          enabled = true;
          server_name = cfg.fakeServerName;
          reality = {
            enabled = true;
            handshake = {
              server = cfg.fakeServerName;
              server_port = cfg.fakeServerPort;
            };
            private_key = {
              _secret = config.sops.secrets."proxy-vlr-private-key".path;
            };
            short_id = [
              {_secret = config.sops.secrets."proxy-vlr-shortid".path;}
            ];
          };
        };
        users = map(user: {
          uuid = {_secret = user.uuidFile;};
        }) users;
      } # VL-R end
    ];

    outbounds = [
      {
        tag = "direct";
        type = "direct";
      }
    ];

    route = {
      rules = [
        {
          inbound = ["vlr"];
          outbound = "direct";
        }
      ];
    };
  };
  # mkSettings end
in
{
  options.custom.sing-box = {
    enable = lib.mkEnableOption "sing-box server";
    fakeServerName = lib.mkOption {
      type = lib.types.str;
      default = "www.google.com";
    };
    fakeServerPort = lib.mkOption {
      type = lib.types.port;
      default = 443;
    };
  };

  config = lib.mkIf cfg.enable {
    # Sops configurations
    sops.secrets = builtins.listToAttrs (
      map (name: {
      name = "${name}-uuid";
      value = {
        sopsFile = ./secrets.yaml;
        key = "${name}-uuid";
      };
    }) users);

    # sing-box configurations
    services.sing-box = {
      enable = true;
      settings = mkSettings (map ( name: {
        uuidFile = config.sops.secrets."${name}-uuid".path;
      }
      ) users);
    };
  };
}
