# https://raw.githubusercontent.com/GnRlLeclerc/nixfiles/4447e3ef3156df3ec10d1ca787c662a07b49dac0/home-manager/modules/theme/extensions/obsidian.nix
# Obsidian theme configuration
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.stylix.targets.obsidian;
in {
  options.stylix.targets.obsidian = {
    enable = config.lib.stylix.mkEnableTarget "Obsidian" true;
    vaults = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Obsidian vault paths (relative to the user home) to be themed";
      example = "/Notes";
    };
  };

  config = mkIf cfg.enable {
    home.file =
      builtins.foldl' (
        acc: vault:
          acc
          // {
            "Documents/${vault}/.obsidian/snippets/base16.css".source = config.lib.stylix.colors {
              template = ./obsidian.mustache;
            };
            "Documents/${vault}/.obsidian/appearance.json".text = builtins.toJSON {
              enabledCssSnippets = ["base16"];
            };
          }
      ) {}
      cfg.vaults;
  };
}
