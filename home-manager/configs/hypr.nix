{
  pkgs,
  config,
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
  ];
  home.packages = [
    pkgs.grimblast
  ];
  services.hyprpaper.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprbars
    ];
    settings = {
      exec-once = [
        "fcitx5 -d"
        "ags run"
      ];
      plugin = {
        hyprbars = {
          bar_color = rgb base00;
          "col.text" = rgb base05;
          bar_text_font = config.stylix.fonts.monospace.name;
          bar_height = 50;
        };
      };
      monitor = ",preferred,auto,1";
      general = {
        gaps_in = 5;
        gaps_out = 20;
        "col.active_border" = rgb base03;
        "col.inactive_border" = rgb base03;
        snap.enabled = true;
        border_size = 0;
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
