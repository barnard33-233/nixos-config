{config, sld, ...}: {
  custom.forgejo-runner = {
    enable = true;

    connections.default = {
      url = "https://git.${sld}";
      uuid = "81c30669-8c36-4794-86c9-79e095fa377b";
      tokenFile = config.sops.secrets.ci-runner-default-token.path;
      labels = [ "native:host" ];
    };

    settings.runner.capacity = 1;
  };

  sops.secrets.ci-runner-default-token.restartUnits = [
    "forgejo-runner.service"
  ];
}
