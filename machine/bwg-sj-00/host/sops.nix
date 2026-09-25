{ config, ...}:
{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      "ci-runner-default-token" = {};
    };
    templates = {
      "ci-runner-default.env" = {
        content = ''
          TOKEN=${config.sops.placeholder.ci-runner-default-token}
        '';
      };
    };

  };
}
