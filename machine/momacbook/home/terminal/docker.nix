{ pkgs, ... }:
{
  home.packages = with pkgs; [
    docker
    docker-compose
  ];

  services.colima = {
    enable = true;
    profiles.default = {
      isActive = true;
      isService = true;
      setDockerHost = true;

      settings = {
        cpu = 4;
        memory = 6;
        disk = 150;

        arch = "host";
        runtime = "docker";

        autoActivate = true;

        rosetta = false;
      };
    };
  };
}
