{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
      ];
      waylandFrontend = true;
    };
  };
}
