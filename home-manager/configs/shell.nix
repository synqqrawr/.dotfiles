{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    zsh = {
      enable = false;
      # enableCompletion = false;
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
        source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

        zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
        zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
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
