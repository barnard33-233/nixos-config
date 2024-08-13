{pkgs, ...}:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
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
      (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode"];})
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Ubuntu" "Noto Color Emoji"];
	sansSerif = [ "Noto Sans CJK SC" "Ubuntu" "Noto Color Emoji" ];
	monospace = [ "JetBrainsMono" "Noto Sans Mono CJK SC" "Ubuntu" "Noto Color Emoji" ];
	emoji = [ "Noto Color Emoji" ];
      };

    };
  };
}
