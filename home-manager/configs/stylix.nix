{lib, ...}: {
  imports = [
    ../../nixos/stylix/default.nix
    ./obsidian/stylix.nix
  ];
  stylix.targets = {
    kde.enable = false;
    neovim.enable = false;
    lazygit.enable = false;
    hyprland.enable = false;
    spicetify.enable = false;
  };
}
