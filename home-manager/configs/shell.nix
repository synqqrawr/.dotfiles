{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${lib.getExe pkgs.zsh}";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
    };

    zoxide.enable = true;
    carapace.enable = true;
    btop.enable = true;
  };

  home.packages = with pkgs; [
    tealdeer
  ];
}
