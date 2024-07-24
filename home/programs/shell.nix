{pkgs, ...}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = builtins.readFile ./fish/config.fish + "\n";
  };
  programs.bash = {
    enable = true;
  };
}
