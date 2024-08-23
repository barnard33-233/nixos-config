{pkgs, config, inputs, lib, ...}:
{
  home.packages = [pkgs.vscode];
  programs.vscode = {
    enable = true;
    extensions = lib.mkMerge ([
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
    ]);

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Latte";
      "files.autoSave" = "afterDelay";
      "git.autoFetch" = false;
    };
  };
}
