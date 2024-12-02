{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      # enableCompletion = false;
      completionInit = "autoload -Uz compinit && compinit && [[ -s \"~/.zcompdump\" && (! -s \"~/.zcompdump\".zwc || \"~/.zcompdump\" -nt \"~/.zcompdump\".zwc) ]] && zcompile \"~/.zcompdump\"";
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${lib.getExe pkgs.zsh}";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
      initExtraBeforeCompInit = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          . "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
        if [[ -f "''${ZDOTDIR}/plugins/fzf-tab/modules/config.h.in" ]]; then
          [[ ! -f "''${ZDOTDIR}/plugins/fzf-tab/modules/config.h" ]] && build-fzf-tab-module
        fi
      '';
      initExtra = let
        zshCompilePlugin = name: src:
          pkgs.runCommand name
          {
            name = "${name}-zwc";
            nativeBuildInputs = [pkgs.zsh];
          }
          ''
            mkdir $out
            cp -rT ${src} $out
            cd $out
            find -name '*.zsh' -execdir zsh -c 'zcompile {}' \;
          '';
      in ''
        setopt GLOB_COMPLETE HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS extended_glob autocd
        export KEYTIMEOUT=1

        source ${
          zshCompilePlugin "zsh-autosuggestions" inputs.zsh-autosuggestions
        }/zsh-autosuggestions.zsh
        source ${zshCompilePlugin "fast-syntax-highlighting" inputs.fast-syntax-highlighting}/fast-syntax-highlighting.plugin.zsh
        source ${zshCompilePlugin "zsh-history-substring-search" inputs.zsh-history-substring-search}/zsh-history-substring-search.zsh

        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./shell/p10k.zsh}

        source ${config.programs.fzf.package}/share/fzf/completion.zsh
        source ${config.programs.fzf.package}/share/fzf/key-bindings.zsh
        source ${
          pkgs.runCommand "zoxide-init-zsh" { buildInputs = [pkgs.zoxide]; } ''
            zoxide init zsh > $out
          ''
        }

        source ${zshCompilePlugin "zsh-fzf-tab" inputs.zsh-fzf-tab}/fzf-tab.plugin.zsh

        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=white,bold'
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false
        # set descriptions format to enable group support
        # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
        zstyle ':completion:*:descriptions' format '[%d]'
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no
        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      '';
    };

    zoxide.enable = true;
    fzf.enable = true;
    btop.enable = true;
    eza.enable = true;
    bat.enable = true;
  };

  home.packages = with pkgs; [
    tealdeer
  ];
}
