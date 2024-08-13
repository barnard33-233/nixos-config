{pkgs, ...}:
{
  home.packages = with pkgs; [
    delta
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
}
