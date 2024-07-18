{
  inputs,
  config,
  pkgs,
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

  home.packages = with pkgs; [
    matugen
    swww
    fd
    bun
    dart-sass
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
  ];

  home.file = {
    "${config.xdg.configHome}/ags" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ags";
      recursive = true;
    };
  };
}
