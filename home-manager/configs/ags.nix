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
      gtk3
      libnotify
    ];
  };

  home.file."${config.xdg.configHome}/ags" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ags";
  };
}
