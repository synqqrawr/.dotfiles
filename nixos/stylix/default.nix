{ pkgs, ... }:
{
  imports = [ ./themes/yoru.nix ];
  stylix = {
    enable = true;
    fonts = {
      serif = {
        package = pkgs.custom-fonts;
        name = "SF Pro";
      };

      sansSerif = {
        package = pkgs.custom-fonts;
        name = "SF Pro";
      };

      monospace = {
        package = pkgs.maple-mono;
        name = "Maple Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes.popups = 16;
    };
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };
  };
}
