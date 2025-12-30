{lib, config, pkgs, ...}:
let
  cfg = config.customHome.git;
in
{
  options.customHome.git = {
    enable = lib.mkEnableOption "Git Config.";
    proxy = {
      enable = lib.mkEnableOption "Enable git proxy";
      
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      git-doc
    ];
    programs.git = {
      enable = true;
      settings.user = {
        name = "barnard33-233";
        email = "htang0203@gmail.com";
      };
    };

    programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          navigate = true;
          light = true;
          side-by-side = true;
        };
      };
  };
}
