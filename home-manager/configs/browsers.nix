{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [inputs.zen.packages."${pkgs.system}".default];
}
