# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  config,
  inputs,
  pkgs,
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
    ./configs/shell.nix
    ./configs/kitty.nix
    ./configs/firefox.nix
    ./configs/hypr.nix
    ./configs/neovim.nix
    ./configs/fcitx5.nix
    ./configs/xdg.nix
    ./configs/git.nix
    ./configs/gtk.nix
    ./configs/ags.nix
    ./configs/foot.nix
    ../nixos/config/nix.nix
  ];

  # TODO: Set your username
  home = {
    username = "async";
    homeDirectory = "/home/${config.home.username}";
  };

  # home-manager.backupFileExtension = "bak";

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.packages = [
    inputs.shadower.packages.${pkgs.system}.shadower
  ];

  # home.packages = with pkgs; [
  #   (inputs.prismlauncher.packages.${system}.prismlauncher.override {
  #     jdks = [
  #       jdk17
  #       jdk8
  #       jdk21
  #     ];
  #   })
  # ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
