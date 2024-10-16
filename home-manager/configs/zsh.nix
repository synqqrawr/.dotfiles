{ config, pkgs, ... }:
let
  lsd = "lsd --group-directories-first --git --hyperlink auto";
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    history = {
      share = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      extended = true;
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = [
        "rm *"
        "pkill *"
        "kill *"
        "killall *"
      ];
    };
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [
        "history"
        "completion"
      ];
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = "1";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "bg=default";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "bg=default";
      HISTORY_SUBSTRING_SEARCH_FUZZY = "";
      HISTORY_SUBSTRING_SEARCH_PREFIXED = "";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "p10k-config";
        src = ./zsh;
        file = "p10k.zsh";
      }
      {
        # Must be before plugins that wrap widgets
        # such as zsh-autosuggestions or fast-syntax-highlighting
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
        file = "zsh-history-substring-search.zsh";
      }
    ];

    initExtra =
      # bash
      ''
        # options
        unsetopt BEEP

        # Autosuggestions
        # https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
        ZSH_AUTOSUGGEST_MANUAL_REBIND=1

        # History substring
        bindkey '^[[a' history-substring-search-up
        bindkey '^[[b' history-substring-search-down
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down

        # set descriptions format to enable group support
        zstyle ':completion:*:descriptions'   format '[%d]'
        # set list-colors to enable filename colorizing
        zstyle ':completion:*'                list-colors ''${(s.:.)LS_COLORS}

        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*'                menu no
        # preview directory's content with lsd when completing cd
        zstyle ':fzf-tab:complete:cd:*'       fzf-preview 'lsd -1 --color=always $realpath'

        # appearance
        zstyle ':fzf-tab:complete:cd:*'       popup-pad 20 0
        zstyle ':completion:*'                file-sort modification
        zstyle ':completion:*:lsd'            sort false
        zstyle ':completion:files'            sort false

        chpwd() {
          if (( $(${pkgs.coreutils}/bin/ls -1 | wc -l) < 30 )); then
            ${config.programs.zsh.shellAliases.ls}
              fi
        }
      '';
    shellAliases = {
      ls = "${lsd}";
      l = "${lsd}";
      ll = "${lsd} -ll";
      lla = "${lsd} -la";
      la = "${lsd} -a";
      tree = "${lsd} --tree";
    };
  };

  programs.zoxide.enable = true;
}
