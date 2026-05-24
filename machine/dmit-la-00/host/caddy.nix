{lib, pkgs, sld,...}:{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddyserver/forwardproxy@caddy2=github.com/klzgrad/forwardproxy@naive"
      ];
      hash = "sha256-fXIDf1kYEKPGjQZ4gtWWosdqCHIMHTs3rvXhEOjybfQ=";
      doInstallCheck = false;
    };
    virtualHosts = {
      "bin.${sld}" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
    };
  };
}
