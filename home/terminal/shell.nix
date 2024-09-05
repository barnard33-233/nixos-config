{pkgs, ...}:
{
  home.packages = [ pkgs.fish ];
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ./fish/config.fish + "\n";
    plugins = [
      {
        name = "af-magic-fish";
        src = builtins.fetchGit {
          url = "https://github.com/barnard33-233/af-magic-fish";
          rev = "ea5bf489e60e41f827716d72b56b9e51c9ece5d8";
        };
      }
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
