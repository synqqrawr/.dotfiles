{ pkgs, ... }:
{
  imports = [ ./themes/everblush.nix ];
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
        package = pkgs.twitter-color-emoji;
        name = "TwitterColorEmoji";
      };
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
      stylix.targets.vim.enable = false;
      stylix.targets.lazygit.enable = false;
    }
  ];
}
