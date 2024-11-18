# https://github.com/Lykos153/nixos/blob/36467d6a5f0200d5d863f33f8a59783c90e9f4a8/modules/homeManager/nushell/completions.nix#L7
# https://github.com/n3oney/nixus/blob/4e0b71ee43e760734f0fd277d71b2eb7c7b3bdcc/modules/programs/nushell.nix#L10
{
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      environmentVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${pkgs.nushell}/bin/nu";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
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
          $env.TRANSIENT_PROMPT_COMMAND = {|| starship module character }

          def disown [...command: string] {
            sh -c '"$@" </dev/null >/dev/null 2>/dev/null & disown' $command.0 ...$command
          }
        '';
    };

    starship = {
      enable = true;
      enableTransience = true;
    };

    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    btop.enable = true;
  };
}
