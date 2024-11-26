{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  home.packages = [pkgs.spotify];
}
