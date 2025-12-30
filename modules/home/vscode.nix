{pkgs, config, inputs, lib, ...}:
let
  cfg = config.customHome.vscode;
in
{
  options.customHome.vscode = {
    enable = lib.mkEnableOption "VSCode Config.";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = lib.mkMerge [
          (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace; [
            gruntfuggly.todo-tree
          ])
          # (with inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace-release; [
          #   ms-vscode-remote.remote-ssh
          # ])
          (with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
            tecosaur.latex-utilities
          ])
        ];

        userSettings = {
          "workbench.colorTheme" = "Catppuccin Latte";
          "files.autoSave" = "afterDelay";
          "git.autoFetch" = false;
        };
      };
    };
  };
}
