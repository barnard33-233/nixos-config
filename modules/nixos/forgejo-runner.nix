{ config, lib, pkgs, ... }:
let
  cfg = config.custom.forgejo-runner;
  yaml = pkgs.formats.yaml { };
  wantsDocker = cfg.containerRuntime == "docker";
  wantsPodman = cfg.containerRuntime == "podman";
  labels = lib.concatMap (connection: connection.labels) (lib.attrValues cfg.connections);
  schemes = map
    (label:
      let
        parts = lib.splitString ":" (lib.head (lib.splitString "?" label));
      in
      if builtins.length parts > 1 then builtins.elemAt parts 1 else "docker")
    labels;

  configFile = yaml.generate "forgejo-runner.yaml" (cfg.settings // {
    server = (cfg.settings.server or { }) // {
      connections = lib.mapAttrs
        (name: connection: {
          inherit (connection) url uuid labels;
          token_url = "file://$CREDENTIALS_DIRECTORY/token-${name}";
        })
        cfg.connections;
    };
  });
in
{
  options.custom.forgejo-runner = {
    enable = lib.mkEnableOption "Forgejo Runner with declarative server connections";

    package = lib.mkPackageOption pkgs "forgejo-runner" { };

    connections = lib.mkOption {
      default = { };
      description = ''
        Connections to runners already created in Forgejo. Connection keys are
        local identifiers containing only letters, digits, underscores and hyphens;
        they do not need to match the runner names in Forgejo.
      '';
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          url = lib.mkOption {
            type = lib.types.strMatching "https?://.+";
            example = "https://git.example.com";
            description = "Base URL of the Forgejo instance.";
          };

          uuid = lib.mkOption {
            type = lib.types.strMatching "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}";
            description = "UUID returned when creating the runner in Forgejo.";
          };

          tokenFile = lib.mkOption {
            type = lib.types.strMatching "/.+";
            example = "/run/secrets/forgejo-runner-token";
            description = ''
              Absolute runtime path to the runner's plain token, not a registration
              token or a TOKEN= environment file. Systemd loads it as a credential;
              the file can remain readable only by root. Do not use a Nix store path.
            '';
          };

          labels = lib.mkOption {
            type = lib.types.nonEmptyListOf lib.types.nonEmptyStr;
            example = [ "native:host" ];
            description = ''
              Explicit execution labels, such as native:host or
              debian:docker://node:22-bookworm. Host jobs execute as the service user.
            '';
          };
        };
      });
    };

    settings = lib.mkOption {
      type = lib.types.submodule { freeformType = yaml.type; };
      default = { };
      description = ''
        Additional non-secret Forgejo Runner YAML settings. server.connections is
        generated from connections; legacy runner.file configuration is not supported.
      '';
    };

    containerRuntime = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "docker" "podman" ]);
      default = null;
      description = ''
        Local container runtime for docker:// execution labels. Enable the selected
        runtime separately through virtualisation.docker or virtualisation.podman.
        Null is suitable for host-only runners.
      '';
    };

    hostPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ bash coreutils curl gawk gitMinimal gnused nodejs wget ];
      defaultText = lib.literalExpression ''
        with pkgs; [ bash coreutils curl gawk gitMinimal gnused nodejs wget ]
      '';
      description = "Packages available on PATH when any connection has a host execution label.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.connections != { };
        message = "custom.forgejo-runner requires at least one connection.";
      }
      {
        assertion = !(cfg.settings ? server.connections) && !(cfg.settings ? runner.file);
        message = "custom.forgejo-runner: use connections, not settings.server.connections or legacy settings.runner.file.";
      }
      {
        assertion = !(lib.elem "docker" schemes) || cfg.containerRuntime != null;
        message = "custom.forgejo-runner: Docker execution labels require containerRuntime to be docker or podman.";
      }
      {
        assertion = !wantsDocker || config.virtualisation.docker.enable;
        message = "custom.forgejo-runner: enable virtualisation.docker for containerRuntime = docker.";
      }
      {
        assertion = !wantsPodman || config.virtualisation.podman.enable;
        message = "custom.forgejo-runner: enable virtualisation.podman for containerRuntime = podman.";
      }
    ] ++ lib.concatLists (lib.mapAttrsToList
      (name: connection: [
        {
          assertion = builtins.match "[A-Za-z0-9_-]+" name != null;
          message = "custom.forgejo-runner: invalid connection key ${name}.";
        }
        {
          assertion = !(lib.hasPrefix "${builtins.storeDir}/" connection.tokenFile);
          message = "custom.forgejo-runner.connections.${name}.tokenFile must be a runtime secret, not a Nix store path.";
        }
      ])
      cfg.connections);

    systemd.services.forgejo-runner = {
      description = "Forgejo Actions Runner";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ]
        ++ lib.optional wantsDocker "docker.service"
        ++ lib.optional wantsPodman "podman.socket";
      requires = lib.optional wantsDocker "docker.service"
        ++ lib.optional wantsPodman "podman.socket";
      path = [ pkgs.gitMinimal ]
        ++ lib.optionals (lib.elem "host" schemes) cfg.hostPackages;
      environment = {
        HOME = "/var/lib/forgejo-runner";
      } // lib.optionalAttrs (wantsDocker || wantsPodman) {
        DOCKER_HOST = if wantsDocker then "unix:///run/docker.sock" else "unix:///run/podman/podman.sock";
      };

      serviceConfig = {
        ExecStart = "${lib.getExe cfg.package} daemon --config ${configFile}";
        DynamicUser = true;
        User = "forgejo-runner";
        StateDirectory = "forgejo-runner";
        StateDirectoryMode = "0700";
        WorkingDirectory = "/var/lib/forgejo-runner";
        LoadCredential = lib.mapAttrsToList (name: connection: "token-${name}:${connection.tokenFile}") cfg.connections;
        SupplementaryGroups = lib.optional wantsDocker "docker" ++ lib.optional wantsPodman "podman";
        Restart = "on-failure";
        RestartSec = 5;
        UMask = "0077";
        ProtectHome = true;
        PrivateTmp = true;
        NoNewPrivileges = true;
      };
    };
  };
}
