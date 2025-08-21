{...}:{
  services.cloud-init = {
    enable = true;
    network.enable = true;
    settings = {
      datasource_list = [
        "NoCloud"
        "ConfigDrive"
        "None"
      ];
      datasource = {
        NoCloud = {};
        ConfigDrive = {};
        None = {};
      };
    };
    # use default cloud_{init, config, final}_modules now to have a try...
  };
}
