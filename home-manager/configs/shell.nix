{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${lib.getExe pkgs.zsh}";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./shell/p10k.zsh}
      '';
    };

    zoxide.enable = true;
    fzf.enable = true;
    btop.enable = true;
  };

  home.packages = with pkgs; [
    tealdeer
  ];
}
