{ pkgs, inputs, ... }:

{
  programs.pi-coding-agent = {
    enable = true;

    package =
      inputs.pi.packages.${pkgs.stdenv.hostPlatform.system}.default;

    extraPackages = with pkgs; [
      nodejs
      bun
      git
    ];

    # do not generate settings.json
    settings = {};
  };
}
