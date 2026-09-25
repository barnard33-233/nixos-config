{sld,...}:{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "ci.${sld}" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
    };
  };
}
