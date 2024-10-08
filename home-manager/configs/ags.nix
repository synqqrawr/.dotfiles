{
  inputs,
  pkgs,
  config,
  ...
}:
{

  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file."${config.xdg.configHome}/ags" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ags";
  };

  home.packages = with pkgs; [
    matugen
    swww
    bun
    dart-sass
    gvfs
    sassc
    fd
    brightnessctl
    swww
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3
    libnotify
  ];
}
