{pkgs, lib, ...}: let
  zconfig = pkgs.writeShellScriptBin ".zshrc" ''
    typeset -U path cdpath fpath manpath
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_FIND_NO_DUPS
    setopt HIST_SAVE_NO_DUPS

    source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    source ${./zsh/p10k.zsh}
    source ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer.plugin.zsh

    eval "$(fzf --zsh)"
    source ${./zsh/lazyload.zsh}

    zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
    zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    zsh-defer source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
  '';
in {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };
  environment.systemPackages = [
    ((pkgs.symlinkJoin
        {
          name = "zsh-wrapped";
          paths = [pkgs.zsh pkgs.fzf pkgs.zoxide];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/zsh --set ZDOTDIR "${zconfig}/bin"
          '';
        })
      .overrideAttrs
      (_: {
        passthru = {
          shellPath = "/bin/zsh";
        };
      }))
  ];
}
