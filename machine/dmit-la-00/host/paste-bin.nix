{config ,sld, ...}:{
  services.wastebin = {
    enable = true;
    secretFile = config.sops.templates."wastebin.env".path;
    settings = {
      WASTEBIN_TITLE = "@wastebin";
      WASTEBIN_ADDRESS_PORT = "[::]:8080";
      WASTEBIN_BASE_URL = "https://bin.${sld}";
      WASTEBIN_CACHE_SIZE = 64;
    };
  };
}
