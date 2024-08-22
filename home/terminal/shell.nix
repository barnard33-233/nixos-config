{pkgs, ...}:
{
  home.packages = [ pkgs.fish ];
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ./fish/config.fish + "\n";
    plugins = [
#      {
#        name = "af-magic-fish";
#        src = builtins.fetchGit {
#          url = "https://github.com/barnard33-233/af-magic-fish";
#          rev = "6376a26f7efe4afbfa8825a8feb4d07637941dd6";
#        };
#      }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }           
    ];            
  };              

  programs.bash = {
    enable = true;
  };
}
