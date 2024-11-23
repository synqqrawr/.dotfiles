{pkgs, ...}: rec {
  qt = {
    enable = true;

    platformTheme.name = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };
    gtk3.extraConfig = {
      gtk-enable-animations = true;
      gtk-decoration-layout = "icon:close";
    };
    gtk4.extraConfig = {
      gtk-enable-animations = true;
    };
  };

  home.packages = with pkgs; [
    gtk.iconTheme.package
    adwaita-icon-theme
    papirus-icon-theme
  ];
}
