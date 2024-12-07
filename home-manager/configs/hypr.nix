{
  pkgs,
  config,
  lib,
  ...
}:
with config.lib.stylix.colors; let
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
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
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs; [
      hyprlandPlugins.hyprbars
    ];
    settings = {
      plugin = {
        hyprbars = {
          bar_height = 35;
          bar_color = rgb base00;
          "col.text" = rgb base04;
          bar_text_font = config.stylix.fonts.sansSerif.name;
          bar_precedence_over_border = false;
          bar_part_of_window = true;
        };
      };
      windowrulev2 = [
        "plugin:hyprbars:bar_color ${rgb base01}, focus:1"
      ];
      exec-once = [
        "fcitx5 -d"
        "ags run"
      ];
      monitor = ",preferred,auto,1";
      general = {
        border_size = 10;
        gaps_in = 5;
        gaps_out = 30;
        workspace = [
          "w[tv1], gapsout:10, gapsin:0"
          "f[1], gapsout:10, gapsin:0"
        ];
        "col.active_border" = lib.mkForce (rgb base01);
        "col.inactive_border" = lib.mkForce (rgb base01);

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
