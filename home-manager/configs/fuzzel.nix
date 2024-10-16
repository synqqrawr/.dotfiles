{
  osConfig,
  lib,
  ...
}:
{
  programs.fuzzel.enable = true;

  programs.fuzzel.settings = {
    # main = {
    #   font = lib.mkForce "${osConfig.stylix.fonts.monospace.name}:size=12";
    # };
  };
}
