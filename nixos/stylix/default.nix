{ pkgs, ... }:
{
  imports = [ ./themes/pasteldark.nix ];
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
  home-manager.sharedModules = [
    {
      stylix.targets.kde.enable = false;
      stylix.targets.neovim.enable = false;
      stylix.targets.lazygit.enable = false;
      stylix.targets.btop.enable = true;
    }
  ];
}
