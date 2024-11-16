# https://github.com/Lykos153/nixos/blob/36467d6a5f0200d5d863f33f8a59783c90e9f4a8/modules/homeManager/nushell/completions.nix#L7
# https://github.com/n3oney/nixus/blob/4e0b71ee43e760734f0fd277d71b2eb7c7b3bdcc/modules/programs/nushell.nix#L10

{
  pkgs,
  lib,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      extraConfig =
        # nu
        ''
          let carapace_completer = {|spans|
            ${lib.getExe pkgs.carapace} $spans.0 nushell ...$spans | from json
          }
          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
            | $"value(char tab)description(char newline)" + $in
            | from tsv --flexible --no-infer
          }
          let zoxide_completer = {|spans|
            $spans | skip 1 | ${lib.getExe pkgs.zoxide} query -l ...$in | lines | where {|x| $x != $env.PWD}
          }
          let external_completer = {|spans|
            # workaround for https://github.com/nushell/nushell/issues/8483
            let expanded_alias = (help aliases | where name == $spans.0 | get -i 0 | get -i expansion)
            let spans = (if $expanded_alias != null  {
              # put the first word of the expanded alias first in the span
              $spans | skip 1 | prepend ($expanded_alias | split row " ")
            } else { $spans })
            # end workaround

            match $spans.0 {
              nu => $fish_completer
              git => $fish_completer
              nix => $carapace_completer
              # use zoxide completions for zoxide commands
              __zoxide_z | __zoxide_zi => $zoxide_completer
              _ => $fish_completer
            } | do $in $spans
          }

          $env.config = {
           show_banner: false
           edit_mode: vi
           completions: {
             case_sensitive: false # case-sensitive completions
             quick: true    # set to false to prevent auto-selecting completions
             partial: true    # set to false to prevent partial filling of the prompt
             algorithm: "fuzzy"    # prefix or fuzzy
             external: {
               enable: true
               completer: $external_completer
             }
           }
          }
          $env.PATH = ($env.PATH |
          split row (char esep) |
          prepend /home/myuser/.apps |
          append /usr/bin/env
          )

          def disown [...command: string] {
            sh -c '"$@" </dev/null >/dev/null 2>/dev/null & disown' $command.0 ...$command
          }
        '';
    };

    oh-my-posh = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
        "blocks" = [
          {
            "alignment" = "left";
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
            "alignment" = "right";
            "type" = "rprompt";
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
                "foreground" = "yellow";
                "foreground_templates" = [
                  "{{ if gt .Code 0 }}red{{ end }}"
                ];
                "properties" = {
                  "style" = "austin";
                  "threshold" = 5000;
                };
                "style" = "diamond";
                "template" = " {{ .FormattedMs }} ";
                "type" = "executiontime";
              }
            ];
            "overflow" = "hidden";
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
    btop.enable = true;
  };
}
