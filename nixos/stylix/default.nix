{pkgs, ...}: {
  imports = [
    ./themes/everblush.nix
    # ./themes/everforest.nix
    # ./themes/gruvbox.nix
    # ./themes/rosepine_dawn.nix
  ];
  stylix = {
    enable = true;
    fonts = {
      sansSerif = {
        package = pkgs.sn-pro;
        name = "SN Pro";
      };

      serif = {
        package = pkgs.sn-pro;
        name = "SN Pro";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes.popups = 16;
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
