{config, pkgs, lib, inputs, ...}: {
  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./direnv.nix
    ./fish.nix
    ./fcitx5.nix
    ./git.nix
    ./gnome.nix
    ./vscode.nix
    ./zellij.nix
  ];
}
