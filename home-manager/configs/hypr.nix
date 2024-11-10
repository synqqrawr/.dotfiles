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
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    enable = true;
    settings = {
      exec-once = [
        "fcitx5 -d"
        "ags run"
      ];
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 12;
        "col.active_border" = rgb base0D;
        "col.inactive_border" = rgb base03;
        snap.enabled = true;
      };
      group = {
        "col.border_inactive" = rgb base03;
        "col.border_active" = rgb base0D;
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
          range = 10;
          render_power = 2;
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
