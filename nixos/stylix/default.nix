{pkgs, ...}: {
  imports = [
    ./themes/rxyhn.nix
    # ./themes/yoru.nix
    # ./themes/everblush.nix
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
        package = pkgs.maple-mono-NF.overrideAttrs {
          version = "7.0-beta32";
        };
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
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
