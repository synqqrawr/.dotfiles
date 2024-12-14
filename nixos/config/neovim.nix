{
  inputs,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimAlias = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    withNodeJs = false;
    defaultEditor = true;
  };
}
