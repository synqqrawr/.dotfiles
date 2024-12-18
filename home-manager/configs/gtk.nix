{pkgs, ...}: rec {
  qt = {
    enable = true;

    platformTheme.name = "gtk3";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };
  };

  home.packages = with pkgs; [
    gtk.iconTheme.package
    adwaita-icon-theme
    papirus-icon-theme
  ];
}
