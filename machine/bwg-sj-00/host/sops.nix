{ config, lib, ...}:
{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      "proxy-vlr-private-key" = {};
      "proxy-vlr-shortid" = {};
    };
  };
}
