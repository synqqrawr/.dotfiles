{
  pkgs,
  config,
  osConfig,
  inputs,
  ...
}:
let
  colorizer = inputs.colorizer;
  darken = hex: percent: colorizer.oklchToHex (colorizer.darken (colorizer.hexToOklch hex) percent);
  lighten = hex: percent: colorizer.oklchToHex (colorizer.lighten (colorizer.hexToOklch hex) percent);

  darker_black = darken "#${config.lib.stylix.colors.base01-hex}" 0;
in
{
  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
  };

  home.file.".config/nvim/lua/themes/stylix.lua".text = ''
    local M = {}

    M.base_30 = {
      white = "#${config.lib.stylix.colors.base07-hex}",
      darker_black = "${darker_black}",
      black = "#${config.lib.stylix.colors.base00-hex}", --  nvim bg
      black2 = "#${config.lib.stylix.colors.base01-hex}",
      one_bg = "#${config.lib.stylix.colors.base01-hex}",
      one_bg2 = "#${config.lib.stylix.colors.base02-hex}",
      one_bg3 = "#${config.lib.stylix.colors.base03-hex}",
      grey = "#${config.lib.stylix.colors.base04-hex}",
      grey_fg = "#${config.lib.stylix.colors.base04-hex}",
      grey_fg2 = "#${config.lib.stylix.colors.base05-hex}",
      light_grey = "#${config.lib.stylix.colors.base06-hex}",
      red = "#${config.lib.stylix.colors.base08-hex}",
      baby_pink = "#${config.lib.stylix.colors.base08-hex}",
      pink = "#${config.lib.stylix.colors.base08-hex}",
      line = "#${config.lib.stylix.colors.base02-hex}", -- for lines like vertsplit
      green = "#${config.lib.stylix.colors.base0B-hex}",
      vibrant_green = "#${config.lib.stylix.colors.base0B-hex}",
      blue = "#${config.lib.stylix.colors.base0D-hex}",
      nord_blue = "#${config.lib.stylix.colors.base0D-hex}",
      yellow = "#${config.lib.stylix.colors.base0A-hex}",
      sun = "#${config.lib.stylix.colors.base0A-hex}",
      purple = "#${config.lib.stylix.colors.base0E-hex}",
      dark_purple = "#${config.lib.stylix.colors.base0E-hex}",
      teal = "#${config.lib.stylix.colors.base0C-hex}",
      orange = "#${config.lib.stylix.colors.base09-hex}",
      cyan = "#${config.lib.stylix.colors.base0C-hex}",
      statusline_bg = "#${config.lib.stylix.colors.base02-hex}",
      lightbg = "#${config.lib.stylix.colors.base03-hex}",
      pmenu_bg = "#${config.lib.stylix.colors.base0D-hex}",
      folder_bg = "#${config.lib.stylix.colors.base05-hex}",
    }

    M.base_16 = {
      base00 = "#${config.lib.stylix.colors.base00-hex}",
      base01 = "#${config.lib.stylix.colors.base01-hex}",
      base02 = "#${config.lib.stylix.colors.base02-hex}",
      base03 = "#${config.lib.stylix.colors.base03-hex}",
      base04 = "#${config.lib.stylix.colors.base04-hex}",
      base05 = "#${config.lib.stylix.colors.base05-hex}",
      base06 = "#${config.lib.stylix.colors.base06-hex}",
      base07 = "#${config.lib.stylix.colors.base07-hex}",
      base08 = "#${config.lib.stylix.colors.base08-hex}",
      base09 = "#${config.lib.stylix.colors.base09-hex}",
      base0A = "#${config.lib.stylix.colors.base0A-hex}",
      base0B = "#${config.lib.stylix.colors.base0B-hex}",
      base0C = "#${config.lib.stylix.colors.base0C-hex}",
      base0D = "#${config.lib.stylix.colors.base0D-hex}",
      base0E = "#${config.lib.stylix.colors.base0E-hex}",
      base0F = "#${config.lib.stylix.colors.base0F-hex}",
    }

    M.polish_hl = {
      treesitter = {
        luaTSField = { fg = M.base_16.base0D },
        ["@tag.delimiter"] = { fg = M.base_30.cyan },
        ["@function"] = { fg = M.base_30.orange },
        ["@variable.parameter"] = { fg = M.base_16.base0F },
        ["@constructor"] = { fg = M.base_16.base0A },
        ["@tag.attribute"] = { fg = M.base_30.orange },
      },
    }

    M = require("base46").override_theme(M, "stylix")

    M.type = "${osConfig.stylix.polarity}"

    return M
  '';

  programs.neovim = {
    package = pkgs.neovim;
    enable = true;
    defaultEditor = true;
  };
}
