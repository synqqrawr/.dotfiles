{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = ["zen.desktop"];
        "text/html" = ["zen.desktop"];
        "x-scheme-handler/http" = ["zen.desktop"];
        "x-scheme-handler/https" = ["zen.desktop"];
        "x-scheme-handler/about" = ["zen.desktop"];
        "x-scheme-handler/unknown" = ["zen.desktop"];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
  home.packages = [
    pkgs.xdg-utils
  ];
}
