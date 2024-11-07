{config, pkgs, lib, ...}:
{
  programs.chromium = {
    enable = true;
    extensions = [
      # "gighmmpiobklfepjocnamgkkbiglidom" # Adblock
      "mgpmgkhhbjgkpnanlmlhibjfgpdpgjec" # BibTeX entry from URL
      "ekmbchepcdggpcbdpjpijphjiiiimfga" # BiliScope
      "dapjbgnjinbpoindlpdmhochffioedbn" # BuiltWith
      "gphhapmejobijbbhgpjhcjognlahblep" # Gnome Shell Integration
      "aapbdbdomjkkjkaonfhkkikfgjllcleb" # Google Translate
      "laookkfknpbbblfpciffpaejjkokdgca" # Momentum
      "hfjbmagddngcpeloejdejnfgbamkjaeg" # Vimium C
      "ekhagklcjbdpajgpjgmbionohlpdbjgc" # Zotero Connector
      "dhdgffkkebhmkfjojejmpbldmpobfkfo" # Script
    ];
  };
}
