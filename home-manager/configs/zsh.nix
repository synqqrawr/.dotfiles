{ config, pkgs, ... }:
let
  lsd = "lsd --group-directories-first --git --hyperlink auto";
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      extended = true;
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
    initExtra = ''
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

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };

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
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      "blocks" = [
        {
          "alignment" = "right";
          "segments" = [
            {
              "type" = "status";
              "style" = "plain";
              "foreground" = "green";
              "foreground_templates" = [
                "{{ if gt .Code 0 }}red{{ end }}"
              ];
              "template" = " {{ reason .Code }}";
            }
            {
              "foreground" = "green";
              "foreground_templates" = [
                "{{ if gt .Code 0 }}red{{ end }}"
              ];
              "properties" = {
                "style" = "roundrock";
                "always_enabled" = true;
              };
              "style" = "diamond";
              "template" = " {{ .FormattedMs }} ";
              "type" = "executiontime";
            }
          ];
          "type" = "prompt";
        }
        {
          "alignment" = "left";
          "newline" = true;
          "segments" = [
            {
              "foreground" = "blue";
              "properties" = {
                "style" = "full";
              };
              "style" = "plain";
              "template" = " {{ .Path }}";
              "type" = "path";
            }
            {
              "foreground" = "242";
              "properties" = {
                "commit_icon" = "@";
                "branch_max_length" = 25;
                "fetch_stash_count" = true;
                "fetch_status" = true;
                "fetch_upstream_icon" = true;
              };
              "style" = "plain";
              "template" = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
              "type" = "git";
            }
          ];
          "type" = "prompt";
        }
        {
          "alignment" = "left";
          "newline" = true;
          "segments" = [
            {
              "foreground" = "magenta";
              "style" = "plain";
              "template" = "󰊠";
              "type" = "text";
            }
          ];
          "type" = "prompt";
        }
      ];
      "transient_prompt" = {
        "template" = "󰊠 ";
        "foreground" = "magenta";
        "background" = "transparent";
      };
      "secondary_prompt" = {
        "foreground" = "magenta";
        "background" = "transparent";
        "template" = "󰊠 ❯ ";
      };
      "final_space" = true;
      "version" = 2;
      "disable_notice" = true;
      "auto_upgrade" = false;
    };
  };

  programs.zoxide.enable = true;
}
