{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["hyprland"];
      };
      hyprland = {
        default = [
          "gtk"
          "hyprland"
        ];
      };
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };
}
