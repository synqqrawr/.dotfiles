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
    ./hypr/xdg.nix
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
        gaps_in = 5;
        gaps_out = 10;
        "col.active_border" = lib.mkForce (rgb base0E);
        snap.enabled = true;
      };
      workspace = [
        "w[tv1], gapsout:50, gapsin:0"
        "f[1], gapsout:50, gapsin:0"
      ];
      group = {
        groupbar = {
          text_color = lib.mkForce (rgb base00);
        };
      };
      misc.vfr = true;
      decoration = {
        shadow.enabled = false;
        rounding = 10;
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
