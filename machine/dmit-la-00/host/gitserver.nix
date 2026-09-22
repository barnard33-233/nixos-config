{sld, ...}: {
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.${sld}";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://git.${sld}/"; 
        HTTP_PORT = 8081;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer.ENABLED = false;
    };
  };
}
