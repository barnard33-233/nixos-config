{ self, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];

  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.mohan = {
    name = "mohan";
    home = "/User/mohan";
  };

  nix.settings = {
    trusted-users = [ "mohan" ];
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store?priority=20"
    ];
  };
}
