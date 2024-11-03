{pkgs, lib, ...}:{
  programs = {
    nushell = {
      enable = true;
      extraConfig =
        # nu
        ''
          let carapace_completer = {|spans|
          ${lib.getExe pkgs.carapace} $spans.0 nushell $spans | from json
          }
          let zoxide_completer = {|spans|
            $spans | skip 1 | ${lib.getExe pkgs.zoxide} query -l ...$in | lines | where {|x| $x != $env.PWD}
          }
          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
            | $"value(char tab)description(char newline)" + $in
            | from tsv --flexible --no-infer
          }
          let external_completer = {|spans|
            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion
          
            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }
          
            match $spans.0 {
              # carapace completions are incorrect for nu
              nu => $fish_completer
              # fish completes commits and branch names in a nicer way
              git => $fish_completer
              # use zoxide completions for zoxide commands
              __zoxide_z | __zoxide_zi => $zoxide_completer
              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
           show_banner: false
           edit_mode: vi
          }
          $env.PATH = ($env.PATH | 
          split row (char esep) |
          prepend /home/myuser/.apps |
          append /usr/bin/env
          )
        '';
    };

    oh-my-posh = {
      enable = true;
      enableNushellIntegration = true;
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

    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    lsd = {
      enable = true;
      enableAliases = true;
    };
    btop.enable = true;
  };
}
