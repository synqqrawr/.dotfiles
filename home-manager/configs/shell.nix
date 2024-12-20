{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  ZCOMPDUMP_CACHE_DIR = "${config.xdg.cacheHome}/zsh";
  ZCOMPDUMP_CACHE_PATH = "${ZCOMPDUMP_CACHE_DIR}/zcompdump-${pkgs.zsh.version}";
in {
  home.activation = {
    refreshZcompdumpCache = config.lib.dag.entryAnywhere ''
      ${lib.getBin pkgs.coreutils}/bin/mkdir -p "${ZCOMPDUMP_CACHE_DIR}"
      if [[ -v oldGenPath && -f '${ZCOMPDUMP_CACHE_PATH}' ]]; then
        # Enforcing to clear old cache, because of just omitting -C kept the command names
        ${lib.getBin pkgs.coreutils}/bin/rm '${ZCOMPDUMP_CACHE_PATH}'
      fi
    '';
    compileZshrc = lib.hm.dag.entryAfter ["installPackages"] ''
      ${lib.getBin pkgs.coreutils}/bin/rm -f ".zshrc.zwc"
      ${lib.getExe pkgs.zsh} -c 'zcompile ".zshrc"'
      ${lib.getBin pkgs.coreutils}/bin/rm -f ".zshenv.zwc"
      ${lib.getExe pkgs.zsh} -c 'zcompile ".zshenv"'
    '';
  };
  programs = {
    zsh = rec {
      enable = true;
      # enableCompletion = false;
      completionInit = ''
        autoload -Uz compinit
        [[ -s "${ZCOMPDUMP_CACHE_PATH}" ]] && compinit -d "${ZCOMPDUMP_CACHE_PATH}" -C || compinit -d "${ZCOMPDUMP_CACHE_PATH}"; [[ -s "${ZCOMPDUMP_CACHE_PATH}" && (! -s "${ZCOMPDUMP_CACHE_PATH}".zwc || "${ZCOMPDUMP_CACHE_PATH}" -nt "${ZCOMPDUMP_CACHE_PATH}".zwc) ]] && zcompile "${ZCOMPDUMP_CACHE_PATH}"
      '';
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${lib.getExe pkgs.zsh}";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
      localVariables = {
        inherit ZCOMPDUMP_CACHE_DIR ZCOMPDUMP_CACHE_PATH;
        KEYTIMEOUT = 1;
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "fg=white,bold";
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "fg=red,bold";
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=8";
        # https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
        ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;
        ZSH_AUTOSUGGEST_USE_ASYNC = "true";
        ZSH_AUTOSUGGEST_STRATEGY = ["match_prev_cmd" "completion"];
      };
      history = {
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        share = true;
        append = true;
      };
      defaultKeymap = "viins";
      autocd = true;
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
            find . -name '*.zsh' -type f -execdir zsh -c 'zcompile "$1"' _ {} \;
          '';
      in ''
        setopt GLOB_COMPLETE extended_glob
        ${
          if history.ignoreDups
          then "
          setopt HIST_SAVE_NO_DUPS
          setopt HIST_FIND_NO_DUPS"
          else ""
        }
        export KEYTIMEOUT=1

        # Very slow chormas https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/27
        unset "FAST_HIGHLIGHT[chroma-whatis]" "FAST_HIGHLIGHT[chroma-man]"
        source ${zshCompilePlugin "fast-syntax-highlighting" inputs.fast-syntax-highlighting}/fast-syntax-highlighting.plugin.zsh
        source ${zshCompilePlugin "zsh-history-substring-search" inputs.zsh-history-substring-search}/zsh-history-substring-search.zsh
        source ${zshCompilePlugin "zsh-autosuggestions" inputs.zsh-autosuggestions}/zsh-autosuggestions.zsh

        source ${zshCompilePlugin "zsh-powerlevel10k" pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${pkgs.runCommand "zcompile-p10k" {
            nativeBuildInputs = [pkgs.zsh];
            name = "p10k-zwc";
          } ''
            cp ${./shell/p10k.zsh} ./p10k.zsh
            zsh -c 'zcompile p10k.zsh'
            mkdir -p $out
            cp p10k.zsh.zwc $out/
          ''}/p10k.zsh

        source ${zshCompilePlugin "fzf" config.programs.fzf.package}/share/fzf/completion.zsh
        source ${zshCompilePlugin "fzf" config.programs.fzf.package}/share/fzf/key-bindings.zsh
        source ${pkgs.runCommand "zoxide-init-zsh" {
            buildInputs = [pkgs.zoxide];
            nativeBuildInputs = [pkgs.zsh];
          } ''
            mkdir -p $out
            zoxide init zsh > $out/zoxide-init.zsh
            zsh -c "zcompile $out/zoxide-init.zsh"
          ''}/zoxide-init.zsh;

        source ${zshCompilePlugin "zsh-fzf-tab" inputs.zsh-fzf-tab}/fzf-tab.plugin.zsh

        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down

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
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
    };
    fzf = {
      enable = true;
      enableZshIntegration = false;
    };
    btop.enable = true;
    bat.enable = true;
  };

  home.packages = with pkgs; [
    tealdeer
  ];
}
