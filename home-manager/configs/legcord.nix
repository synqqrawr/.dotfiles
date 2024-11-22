{config, ...}: let
  themeFile = config.lib.stylix.colors {
    template = ./legcord/template.mustache;
    extension = ".css";
  };
in {
  xdg.configFile."legcord/themes/stylix.theme.css".source = themeFile;
}
