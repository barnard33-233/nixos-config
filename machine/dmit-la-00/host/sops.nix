{ config, lib, ...}:
{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      "proxy-vlr-private-key" = {};
      "proxy-vlr-shortid" = {};
      "wastebin-password-salt" = {};
      "wastebin-signing-key" = {};
    };
    templates = {
      "wastebin.env" = {
        content = ''
          WASTEBIN_PASSWORD_SALT=${config.sops.placeholder.wastebin-password-salt}
          WASTEBIN_SIGNING_KEY=${config.sops.placeholder.wastebin-signing-key}
        '';
      };
    };
  };
}
