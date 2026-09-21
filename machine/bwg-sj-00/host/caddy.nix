{sld,...}:{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "bin.${sld}" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
    };
  };
}
