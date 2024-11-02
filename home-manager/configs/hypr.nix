{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hypr/hyprlock.nix
    ./hypr/xdg.nix
    ./hypr/hypridle.nix
    ./hypr/hyprland/binds.nix
  ];
  home.packages = [
    pkgs.grimblast
    pkgs.pyprland
  ];
  home.file."${config.xdg.configHome}/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
        "magnify",
    ]
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "fcitx5 -d"
        "ags"
        "${pkgs.pyprland}/bin/pypr &"
      ];
      monitor = ",preferred,auto,1";
      general = {
        border_size = 0;
        gaps_in = 5;
        gaps_out = 12;
      };
      decoration = {
        rounding = 10;
        shadow_range = 10;
        shadow_render_power = 2;
        dim_inactive = true;
        dim_strength = 0.3;
      };
      render = {
        direct_scanout = true;
      };
    };
  };
}
