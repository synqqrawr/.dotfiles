{ pkgs, ... }:
{
  imports = [ ./themes/yoru.nix ];
  stylix = {
    enable = true;
    fonts = {
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };

      serif = {
        package = pkgs.source-serif-pro;
        name = "Source Serif Pro";
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetbrainsMonoNerdFont";
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
