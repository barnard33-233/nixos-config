{ self, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];

  nix.settings.experimental-features = "nix-command flakes";
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users.mohan = {
    name = "mohan";
    home = "/Users/mohan";
  };

  fonts.packages = with pkgs; [
    source-sans
    source-serif
    noto-fonts
    ubuntu_font_family
    # Chinese
    source-han-sans
    source-han-serif
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    wqy_microhei
    wqy_zenhei
    # emoji
    noto-fonts-emoji

    #nerdfonts
    #(nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];})
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];


  nix.settings = {
    trusted-users = [ "mohan" ];
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store?priority=20"
    ];
  };
}
