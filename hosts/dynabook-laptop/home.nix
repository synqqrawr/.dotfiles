{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../home-manager/configs/shell.nix
    ../../home-manager/configs/kitty.nix
    # ./configs/firefox.nix
    ../../home-manager/configs/hypr.nix
    ../../home-manager/configs/neovim.nix
    ../../home-manager/configs/fcitx5.nix
    ../../home-manager/configs/xdg.nix
    ../../home-manager/configs/git.nix
    ../../home-manager/configs/gtk.nix
    ../../home-manager/configs/ags.nix
    ../../home-manager/configs/foot.nix
    ../../home-manager/configs/swww.nix
    ../../home-manager/configs/spotify.nix
    ../../home-manager/configs/stylix.nix
    ../../home-manager/configs/discord.nix
    ../../home-manager/configs/browsers.nix
    ../../home-manager/configs/emote.nix
    ../../home-manager/configs/games.nix
    ../../home-manager/configs/obsidian.nix
    ../../nixos/config/nix.nix
  ];

  # TODO: Set your username
  home = {
    username = "async";
  };

  programs = {
    mpv.enable = true;
    lazygit.enable = true;
    feh.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    (inputs.prismlauncher.packages.${pkgs.system}.prismlauncher.override {
      jdks = [
        jdk17
        jdk8
        jdk21
      ];
    })
  ];

  home.activation.forceUpdateFontConfigCache = lib.hm.dag.entryAfter ["intallPackages"] ''
    echo "Rebuilding font cache"
    ${pkgs.fontconfig}/bin/fc-cache -rf
  '';
}
