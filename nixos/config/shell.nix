{
  pkgs,
  lib,
  ...
}: let
  zconfig = pkgs.writeShellScriptBin ".zshrc" ''
    if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
      source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
    fi

    declare -A ZINIT
    ZINIT_HOME=$HOME/.local/share/zinit
    ZINIT[HOME_DIR]=''${ZINIT_HOME}
    ZINIT[BIN_DIR]=${pkgs.zinit}/share/zinit
    [[ -r ''${ZINIT_HOME} ]] || mkdir -p ''${ZINIT_HOME}
    source "${pkgs.zinit}/share/zinit/zinit.zsh"&>/dev/null
    ln -sf "${pkgs.zinit}/share/zsh/site-functions/_zinit" ''${ZINIT_HOME}/completions
    (( ''${+_comps} )) && _comps[zinit]="${pkgs.zinit}/share/zsh/site-functions/_zinit"

    ${builtins.readFile ./zsh/zinit.zsh}
    ${builtins.readFile ./zsh/options.zsh}
    ${builtins.readFile ./zsh/binds.zsh}
    ${builtins.readFile ./zsh/lazyload.zsh}
    source ${./zsh/p10k.zsh}

    eval "$(fzf --zsh)"

    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  '';
  zlogin =
    pkgs.writeShellScriptBin ".zlogin" ''
    '';
  zenv = pkgs.writeShellScriptBin ".zenv" ''
    skip_global_compinit=1
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
          paths = [pkgs.zsh pkgs.fzf pkgs.zoxide pkgs.zinit];
          buildInputs = [pkgs.makeWrapper];
          postBuild = ''
            mkdir -p $out/bin
            cp ${zconfig}/bin/.zshrc $out/bin/.zshrc
            ${pkgs.zsh}/bin/zsh -c "zcompile $out/bin/.zshrc"
            rm $out/bin/.zshrc
            cp ${zlogin}/bin/.zlogin $out/bin/.zlogin
            ${pkgs.zsh}/bin/zsh -c "zcompile $out/bin/.zlogin"
            rm $out/bin/.zlogin
            cp ${zenv}/bin/.zenv $out/bin/.zenv
            ${pkgs.zsh}/bin/zsh -c "zcompile $out/bin/.zenv"
            rm $out/bin/.zenv
            ${pkgs.zsh}/bin/zsh -c "source $out/bin/.zshrc; autoload -U compinit; compinit -d $out/bin/.zcompdump"
            ${pkgs.zsh}/bin/zsh -c "autoload -U zrecompile; zrecompile -p $out/bin/.zcompdump"
            rm $out/bin/.zcompdump
            wrapProgram $out/bin/zsh --set ZDOTDIR "$out/bin"
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
