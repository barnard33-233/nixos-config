{config, pkgs, sld, ...}: {
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = "ci-sj";
      url = "https://git.${sld}";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = config.sops.templates."ci-runner-default.env".path; 
      labels = [
        "native:host"
      ];
      settings = {
        runner.capacity = 1;
      };
    };
  };
}
