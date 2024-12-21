{config, ...}: {
  xdg.configFile."ghostty/config" = {
    text = with config.lib.stylix.colors; ''
      font-size = 12
      font-family = ${config.stylix.fonts.monospace.name}
      font-style = medium
      font-feature = "ss01"
      window-decoration = true
      window-padding-x = 20
      window-padding-y = 20
      confirm-close-surface = false

      # foreground
      foreground = ${base05}
      background = ${base00}
      # black
      palette = 0=${base00}
      palette = 8=${base01}
      # red
      palette = 1=${base08}
      palette = 9=${base09}
      # green
      palette = 2=${base0B}
      palette = 10=${base0F}
      # yellow
      palette = 3=${base0A}
      palette = 11=${base0E}
      # blue
      palette = 4=${base0C}
      palette = 12=${base0D}
      # purple
      palette = 5=${base0E}
      palette = 13=${base0C}
      # aqua
      palette = 6=${base0B}
      palette = 14=${base0F}
      # white
      palette = 7=${base05}
      palette = 15=${base06}

      gtk-single-instance = true
    '';
  };
}
