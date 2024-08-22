{config, pkgs, ...}:
{
  home.packages = [ pkgs.neovim ];
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink  "${config.home.homeDirectory}/nixos/home/nvim/nvim";
  # XXX: require npm
}
