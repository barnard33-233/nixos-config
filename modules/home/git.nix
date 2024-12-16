{lib, config, pkgs, ...}:
let
  cfg = config.customHome.git;
in
{
  options.customHome.git = {
    enable = lib.mkEnableOption "Git Config.";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      git-doc
    ];
    programs.git = {
      enable = true;
      userName = "barnard33-233";
      userEmail = "htang0203@gmail.com";
      delta = {
        enable = true;
        options = {
          navigate = true;
      light = true;
      side-by-side = true;
        };
      };
    };
  };
}
