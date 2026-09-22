{sld,...}:{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "bin.${sld}" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
      "git.${sld}" = {
        extraConfig = ''
          reverse_proxy localhost:8081
        '';
      };
    };
  };
}
