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
      extensions = lib.mkMerge [
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
          vscodevim.vim
          gruntfuggly.todo-tree
        ]) 
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace-release; [
          ms-vscode-remote.remote-ssh
        ])
        (with pkgs; [
          vscode-extensions.catppuccin.catppuccin-vsc
        ])
      ];
  
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Latte";
        "files.autoSave" = "afterDelay";
        "git.autoFetch" = false;
      };
    };
  };
}
