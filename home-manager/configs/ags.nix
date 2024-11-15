{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    # additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.apps
    ];
  };

  home.file = {
    "${config.xdg.configHome}/ags" = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ags";
    };
  };

  home.packages = [
    inputs.ags.packages.${pkgs.system}.mpris
    inputs.ags.packages.${pkgs.system}.hyprland
    inputs.ags.packages.${pkgs.system}.tray
    inputs.ags.packages.${pkgs.system}.battery
    inputs.ags.packages.${pkgs.system}.wireplumber
    inputs.ags.packages.${pkgs.system}.network
    inputs.ags.packages.${pkgs.system}.notifd
    inputs.ags.packages.${pkgs.system}.apps
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.astal3

    pkgs.dart-sass
    pkgs.libnotify
  ];
}
