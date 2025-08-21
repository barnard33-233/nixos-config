{lib, ...}: {
  disko.devices = {
    disk.vda = {
      device = "/dev/vda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          mbr = {
            type = "EF02";
            size = "1M";
            priority = 1;
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "errors=remount-ro" ];
            };
          };
        };
      };
    };
  };
}
