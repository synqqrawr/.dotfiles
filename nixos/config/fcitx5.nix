{ pkgs, ... }:
{
  environment.variables = {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      waylandFrontend = true;
    };
  };
}
