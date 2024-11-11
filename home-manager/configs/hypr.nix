{
  pkgs,
  inputs,
  config,
  ...
}:
with config.lib.stylix.colors; let
  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${alpha})";
in {
  imports = [
    ./hypr/hyprlock.nix
    ./hypr/xdg.nix
    ./hypr/hypridle.nix
    ./hypr/hyprland/binds.nix
  ];
  home.packages = [
    pkgs.grimblast
  ];
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    enable = true;
    settings = {
      plugin = {
        hyprbars = {
          bar_color = rgb base00;
          bar_height = 28;
          col_text = rgb base00;
          bar_text_size = 11;
          bar_text_font = config.stylix.fonts.monospace.name;

          hyprbars-button = [
            "${rgb base03}, 20, x, hyprctl dispatch killactive"
          ];
        };
      };
      exec-once = [
        "fcitx5 -d"
        "ags run"
      ];
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 12;
        "col.active_border" = rgb base00;
        "col.inactive_border" = rgb base00;
        snap.enabled = true;
        border_size = 3;
      };
      group = {
        "col.border_inactive" = rgb base02;
        "col.border_active" = rgb base02;
        "col.border_locked_active" = rgb base0C;

        groupbar = {
          text_color = rgb base05;
          "col.active" = rgb base0D;
          "col.inactive" = rgb base03;
        };
      };
      misc.background_color = rgb base00;
      decoration = {
        shadow = {
          color = rgba base00 "99";
          range = 15;
          render_power = 5;
        };
        rounding = 10;
        dim_inactive = true;
        dim_strength = 0.3;
        blur = {
          enabled = false;
        };
      };
      render = {
        direct_scanout = true;
      };
    };
  };
}
