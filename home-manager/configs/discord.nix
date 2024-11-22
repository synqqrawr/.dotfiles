{config, ...}: let
  themeFile = config.lib.stylix.colors {
    template = ./discord/template.mustache;
    extension = ".css";
  };
in {
  xdg.configFile."equibop/themes/stylix.theme.css".source = themeFile;
}
