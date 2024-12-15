{
  pkgs,
  config,
  lib,
  ...
}:
with config.lib.stylix.colors; let
  rgb = color: "rgb(${color})";
in {
  imports = [
    ./hypr/hyprlock.nix
    # ./hypr/xdg.nix
    ./hypr/hypridle.nix
    ./hypr/hyprland/binds.nix
    # ./hypr/hyprland/animations.nix
  ];
  home.packages = [
    pkgs.grimblast
  ];
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "fcitx5 -d"
        "ags run"
      ];
      monitor = ",preferred,auto,1";
      general = {
        border_size = 0;
        gaps_in = 5;
        gaps_out = 30;
        workspace = [
          "w[tv1], gapsout:10, gapsin:0"
          "f[1], gapsout:10, gapsin:0"
        ];
        snap.enabled = true;
      };
      group = {
        groupbar = {
          text_color = lib.mkForce (rgb base00);
        };
      };
      misc = {
        force_default_wallpaper = 0;
        vfr = true;
      };
      windowrule = [
        "float, ^(org.gnome.Nautilus)$"
      ];
      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
        };
        dim_inactive = true;
        dim_strength = 0.1;
        blur = {
          enabled = false;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };
      render = {
        direct_scanout = true;
      };
    };
  };
}
