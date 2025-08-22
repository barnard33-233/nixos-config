{inputs, ...}:{
  imports = [
    inputs.paste-bin.nixosModules.x86_64-linux.default
    {
      services.paste-bin = {
        enable = true;
        bindAddress = "[::]:8080";
      };
    }
  ];
}
