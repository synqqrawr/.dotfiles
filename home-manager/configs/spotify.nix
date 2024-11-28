{
  pkgs,
  inputs,
  config,
  ...
}:
with config.lib.stylix.colors; {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
    theme = spicePkgs.themes.defaultDynamic;
    colorScheme = "base";
  };
}
