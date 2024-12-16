{config, pkgs, lib, ...}:
let
  cfg = config.customHome.chromium;
in
{
  options.customHome.chromium = {
    enable = lib.mkEnableOption "Chromium Config.";
    enableExtensions = lib.mkEnableOption "Enable Extensions";
  };
  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = lib.mkIf cfg.enableExtensions [
        # "gighmmpiobklfepjocnamgkkbiglidom" # Adblock
        "mgpmgkhhbjgkpnanlmlhibjfgpdpgjec" # BibTeX entry from URL
        "ekmbchepcdggpcbdpjpijphjiiiimfga" # BiliScope
        "dapjbgnjinbpoindlpdmhochffioedbn" # BuiltWith
        "gphhapmejobijbbhgpjhcjognlahblep" # Gnome Shell Integration
        "aapbdbdomjkkjkaonfhkkikfgjllcleb" # Google Translate
        # "laookkfknpbbblfpciffpaejjkokdgca" # Momentum
        "bngmbednanpcfochchhgbkookpiaiaid" # Mue
        "hfjbmagddngcpeloejdejnfgbamkjaeg" # Vimium C
        "ekhagklcjbdpajgpjgmbionohlpdbjgc" # Zotero Connector
        "dhdgffkkebhmkfjojejmpbldmpobfkfo" # Script
      ];
    };
  };
}
