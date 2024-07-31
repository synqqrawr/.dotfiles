{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/norm.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          Normal = { bg = colors.base00, fg = colors.base05 },
          ColorColumn = { bg = colors.base01 },
          Conceal = { bg = "", fg = colors.base0D },
          CurSearch = { bg = colors.base09, fg = colors.base01 },
          Cursor = { fg = colors.base00, bg = colors.base00 },
          CursorColumn = { fg = "", bg = colors.base01 },
          CursorIM = { fg = colors.base00, bg = colors.base05 },
          CusorLine = { fg = "", bg = colors.base01 },
          CursorLineFold = { fg = colors.base0C, bg = colors.base01 },
          CursorLineNR = { fg = colors.base04, bg = colors.base01 },
          CursorLineSign = { fg = colors.base03, bg = colors.base01 },
          NormalFloat = { bg = themes.blend(colors.base00, colors.base01, 1.3), fg = colors.base05 },
          Comment = { bg = "", fg = colors.base04 },
          Darker = { bg = themes.blend(colors.base00, colors.base01, 1.3), fg = themes.blend(colors.base00, colors.base01, 1.3) },
          Directory = { bg = "", fg = colors.base0D },
          WarningMsg = { fg = colors.base08, bg = "" },
          ModeMsg = { fg = colors.base0B, bg = "" },
          MoreMsg = { fg = colors.base0B, bg = "" },
          MsgArea = { fg = colors.base05, bg = colors.base00 },
          MsgSeparator = { fg = colors.base04, bg = colors.base02 },
          ErrorMsg = { fg = colors.base08, bg = colors.base00 },
          FoldColumn = { fg = colors.base0C, bg = colors.base01 },
          Folded = { fg = colors.base03, bg = colors.base01 },

          BufflineBufOnActive = { fg = colors.base05, bg = colors.base00 },
          BufflineBufOnInactive = { fg = themes.blend(colors.base05, colors.base00, 0.45), bg = themes.blend(colors.base00, colors.base05, 0.95) },
          BufflineBufOnModified = { fg = colors.base04, bg = colors.base00 },
          BuffLineBufOffModified = { fg = colors.base04, bg = themes.blend(colors.base00, colors.base05, 0.95) },
          BufflineBufOnClose = { fg = colors.base08, bg = colors.base00 },
          BuffLineBufOffClose = { fg = colors.base04, bg = themes.blend(colors.base00, colors.base05, 0.95) },
          BuffLineTree = { bg = themes.blend(colors.base00, colors.base01, 0.93), fg = themes.blend(colors.base00, colors.base01, 1.3), fg = colors.base05 },
          BuffLineEmpty = { bg = colors.base00, fg = colors.base05 },
          BuffLineEmptyColor = { bg = colors.base01, fg = colors.base05 },
          BuffLineButton = { bg = themes.blend(colors.base00, colors.base05, 0.95), fg = colors.base07 },
          BuffLineCloseButton = { bg = colors.base08, fg = colors.base00 },

          DiffAdd = { fg = colors.base0B },
          DiffChange = { fg = colors.base0E },
          DiffDelete = { fg = colors.base08 },

          IncSearch = { fg = colors.base01, bg = colors.base09 },
          Search = { fg = colors.base01, bg = colors.base0A },
          MatchParen = { fg = colors.base09, bg = "NONE" },

          CmpGhostText = { link = "Comment", default = true },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/ibl.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          IblChar = { fg = colors.base02 },
          IblScopeChar = { fg = colors.base0F },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/lsp.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          DiagnosticError = { fg = colors.base08 },
          DiagnosticHint = { fg = colors.base0D },
          DiagnosticInfo = { fg = colors.base0C },
          DiagnosticWarn = { fg = colors.base0E },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/statusbar.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          StatusLine = { fg = colors.base05, bg = colors.base00 };
          StatuslineModeNormal = { fg = colors.base00, bg = colors.base0D };
          StatuslineModePending = { fg = colors.base00, bg = colors.base09 };
          StatuslineModeVisual = { fg = colors.base00, bg = colors.base0C };
          StatuslineModeInsert = { fg = colors.base00, bg = colors.base0E };
          StatuslineModeCommand = { fg = colors.base00, bg = colors.base0B };
          StatuslineModeOther = { fg = colors.base00, bg = colors.base08 };

          StatuslineModeSeparatorNormal = { bg = colors.base02, fg = colors.base0D };
          StatuslineModeSeparatorPending = { bg = colors.base02, fg = colors.base09 };
          StatuslineModeSeparatorVisual = { bg = colors.base02, fg = colors.base0C };
          StatuslineModeSeparatorInsert = { bg = colors.base02, fg = colors.base0E };
          StatuslineModeSeparatorCommand = { bg = colors.base02, fg = colors.base0B };
          StatuslineModeSeparatorOther = { bg = colors.base00, fg = colors.base08 };
          StatuslineModeSeperatorTwo = { bg = colors.base00, fg = colors.base02 };

          StatuslineItalic = { bg = colors.base00, fg = colors.base04 };
          StatuslineSpinner = { bg = colors.base00, fg = colors.base0B };
          StatuslineTitle = { bg = colors.base00, fg = colors.base04 };

          MsgSeparator = { fg = colors.base04, bg = colors.base00 },
          WinSeparator = { fg = colors.base00, bg = colors.base00 },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/mini.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          MiniFilesBorder = { link = "Darker" },
          MiniFilesBorderModified = { link = "Darker" },
          MiniFilesCursorLine = { fg = "", bg = colors.base02 },
          MiniFilesDirectory = { link = "Directory" },
          MiniFilesFile = { fg = colors.base05, bg = "" },
          MiniFilesNormal = { link = "NormalFloat" },
          MiniFilesTitle = { fg = colors.base0D, bg = themes.blend(colors.base00, colors.base01, 1.3) },
          MiniFilesTitleFocused = { fg = colors.base0D, bg = themes.blend(colors.base00, colors.base01, 1.3) },

          MiniPickBorder = { link = "Darker" },
          MiniPickBorderBusy = { link = "Darker" },
          -- MiniPickBorderText = { bg = themes.blend(colors.base00, colors.base01, 1.3), fg = colors.base05 },
          MiniPickPrompt = { bg = themes.blend(colors.base00, colors.base01, 1.3), fg = colors.base0D },
          -- MiniPickHeader = { bg = themes.blend(colors.base00, colors.base01, 1.3), fg = colors.base05 },
          MiniPickNormal = { link = "NormalFloat" },

          MiniDiffSignAdd = { link = "DiffAdd" },
          MiniDiffSignChange = { link = "DiffChange" },
          MiniDiffSignDelete = { link = "DiffDelete" },
          MiniDiffOverAdd = { link = "DiffAdd" },
          MiniDiffOverChange = { link = "DiffChange" },
          MiniDiffOverDelete = { link = "DiffDelete" },

          MiniIconsAzure = { fg = colors.base0D, bg = "NONE" },
          MiniIconsBlue = { fg = colors.base0F, bg = "NONE" },
          MiniIconsCyan = { fg = colors.base0C, bg = "NONE" },
          MiniIconsGreen = { fg = colors.base0B, bg = "NONE" },
          MiniIconsGrey = { fg = colors.base07, bg = "NONE" },
          MiniIconsOrange = { fg = colors.base09, bg = "NONE" },
          MiniIconsPurple = { fg = colors.base0E, bg = "NONE" },
          MiniIconsRed = { fg = colors.base08, bg = "NONE" },
          MiniIconsYellow = { fg = colors.base0A, bg = "NONE" },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/treesitter.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          ["@variable"] = { fg = colors.base05 },
          ["@variable.builtin"] = { fg = colors.base09 },
          ["@variable.parameter"] = { fg = colors.base08 },
          ["@variable.member"] = { fg = colors.base08 },
          ["@variable.member.key"] = { fg = colors.base08 },

          ["@module"] = { fg = colors.base08 },
          -- ["@module.builtin"] = { fg = colors.base08 },

          ["@constant"] = { fg = colors.base08 },
          ["@constant.builtin"] = { fg = colors.base09 },
          ["@constant.macro"] = { fg = colors.base08 },

          ["@string"] = { fg = colors.base0B },
          ["@string.regex"] = { fg = colors.base0C },
          ["@string.escape"] = { fg = colors.base0C },
          ["@character"] = { fg = colors.base08 },
          -- ["@character.special"] = { fg = colors.base08 },
          ["@number"] = { fg = colors.base09 },
          ["@number.float"] = { fg = colors.base09 },

          ["@annotation"] = { fg = colors.base0F },
          ["@attribute"] = { fg = colors.base0A },
          ["@error"] = { fg = colors.base08 },

          ["@keyword.exception"] = { fg = colors.base08 },
          ["@keyword"] = { fg = colors.base0E },
          ["@keyword.function"] = { fg = colors.base0E },
          ["@keyword.return"] = { fg = colors.base0E },
          ["@keyword.operator"] = { fg = colors.base0E },
          ["@keyword.import"] = { link = "Include" },
          ["@keyword.conditional"] = { fg = colors.base0E },
          ["@keyword.conditional.ternary"] = { fg = colors.base0E },
          ["@keyword.repeat"] = { fg = colors.base0A },
          ["@keyword.storage"] = { fg = colors.base0A },
          ["@keyword.directive.define"] = { fg = colors.base0E },
          ["@keyword.directive"] = { fg = colors.base0A },

          ["@function"] = { fg = colors.base0D },
          ["@function.builtin"] = { fg = colors.base0D },
          ["@function.macro"] = { fg = colors.base08 },
          ["@function.call"] = { fg = colors.base0D },
          ["@function.method"] = { fg = colors.base0D },
          ["@function.method.call"] = { fg = colors.base0D },
          ["@constructor"] = { fg = colors.base0C },

          ["@operator"] = { fg = colors.base05 },
          ["@reference"] = { fg = colors.base05 },
          ["@punctuation.bracket"] = { fg = colors.base0F },
          ["@punctuation.delimiter"] = { fg = colors.base0F },
          ["@symbol"] = { fg = colors.base0B },
          ["@tag"] = { fg = colors.base0A },
          ["@tag.attribute"] = { fg = colors.base08 },
          ["@tag.delimiter"] = { fg = colors.base0F },
          ["@text"] = { fg = colors.base05 },
          ["@text.emphasis"] = { fg = colors.base09 },
          ["@text.strike"] = { fg = colors.base0F, strikethrough = true },
          ["@type.builtin"] = { fg = colors.base0A },
          ["@definition"] = { sp = colors.base04, underline = true },
          ["@scope"] = { bold = true },
          ["@property"] = { fg = colors.base08 },
        }
      '';
  };
  home.file."${config.xdg.configHome}/nvim/lua/hls/themes/syntax.lua" = {
    text =
      # lua
      ''
        local themes = require("hls")
        local colors = themes.getCurrentTheme()

        return {
          Boolean = { fg = colors.base09 },
          Character = { fg = colors.base08 },
          Conditional = { fg = colors.base0E },
          Constant = { fg = colors.base08 },
          Define = { fg = colors.base0E, sp = "none" },
          Delimiter = { fg = colors.base0F },
          Float = { fg = colors.base09 },
          Variable = { fg = colors.base05 },
          Function = { fg = colors.base0D },
          Identifier = { fg = colors.base08, sp = "none" },
          Include = { fg = colors.base0D },
          Keyword = { fg = colors.base0E },
          Label = { fg = colors.base0A },
          Number = { fg = colors.base09 },
          Operator = { fg = colors.base05, sp = "none" },
          PreProc = { fg = colors.base0A },
          Repeat = { fg = colors.base0A },
          Special = { fg = colors.base0C },
          SpecialChar = { fg = colors.base0F },
          Statement = { fg = colors.base08 },
          StorageClass = { fg = colors.base0A },
          String = { fg = colors.base0B },
          Structure = { fg = colors.base0E },
          Tag = { fg = colors.base0A },
          Todo = { fg = colors.base0A, bg = colors.base01 },
          Type = { fg = colors.base0A, sp = "none" },
          Typedef = { fg = colors.base0A },
        }
      '';
  };

  home.file."${config.xdg.configHome}/nvim/lua/hls/init.lua" = {
    text =
      # lua
      ''
        local M = {}

        local function hexToRgb(c)
          c = string.lower(c)
          return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
        end

        -- some functions to make light and dark colors

        M.blend = function(foreground, background, alpha)
          alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
          local bg = hexToRgb(background)
          local fg = hexToRgb(foreground)

          local blendChannel = function(i)
            local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
            return math.floor(math.min(math.max(0, ret), 255) + 0.5)
          end

          return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
        end

        M.darken = function(hex, bg, amount)
          return M.blend(hex, bg, amount)
        end

        M.lighten = function(hex, fg, amount)
          return M.blend(hex, fg, amount)
        end

        -- Get current theme colors
        M.getCurrentTheme = function()
          return {
            base00 = "${osConfig.lib.stylix.colors.withHashtag.base00}",
            base01 = "${osConfig.lib.stylix.colors.withHashtag.base01}",
            base02 = "${osConfig.lib.stylix.colors.withHashtag.base02}",
            base03 = "${osConfig.lib.stylix.colors.withHashtag.base03}",
            base04 = "${osConfig.lib.stylix.colors.withHashtag.base04}",
            base05 = "${osConfig.lib.stylix.colors.withHashtag.base05}",
            base06 = "${osConfig.lib.stylix.colors.withHashtag.base06}",
            base07 = "${osConfig.lib.stylix.colors.withHashtag.base07}",
            base08 = "${osConfig.lib.stylix.colors.withHashtag.base08}",
            base09 = "${osConfig.lib.stylix.colors.withHashtag.base09}",
            base0A = "${osConfig.lib.stylix.colors.withHashtag.base0A}",
            base0B = "${osConfig.lib.stylix.colors.withHashtag.base0B}",
            base0C = "${osConfig.lib.stylix.colors.withHashtag.base0C}",
            base0D = "${osConfig.lib.stylix.colors.withHashtag.base0D}",
            base0E = "${osConfig.lib.stylix.colors.withHashtag.base0E}",
            base0F = "${osConfig.lib.stylix.colors.withHashtag.base0F}",
          }
        end

        -- simple helper functions
        M.mergeTb         = function(...)
          return vim.tbl_deep_extend("force", ...)
        end

        M.loadTb          = function(g)
          g = require("hls.themes." .. g)
          return g
        end

        vim.g.theme_cache = vim.fn.stdpath "data" .. "/colors_data/"

        M.tableToStr      = function(tb)
          local result = ""

          for hlgroupName, hlgroup_vals in pairs(tb) do
            local hlname = "'" .. hlgroupName .. "',"
            local opts = ""

            for optName, optVal in pairs(hlgroup_vals) do
              local valueInStr = ((type(optVal)) == "boolean" or type(optVal) == "number") and tostring(optVal)
                  or '"' .. optVal .. '"'
              opts = opts .. optName .. "=" .. valueInStr .. ","
            end

            result = result .. "vim.api.nvim_set_hl(0," .. hlname .. "{" .. opts .. "})"
          end

          return result
        end

        M.toCache         = function(filename, tb)
          local lines = "return string.dump(function()" .. M.tableToStr(tb) .. "end, true)"
          local file = io.open(vim.g.theme_cache .. filename, "wb")

          if file then
            ---@diagnostic disable-next-line: deprecated
            file:write(loadstring(lines)())
            file:close()
          end
        end

        local hl_files = vim.fn.stdpath "config" .. "/lua/hls/themes"

        M.compile         = function()
          if not vim.loop.fs_stat(vim.g.theme_cache) then
            vim.fn.mkdir(vim.g.theme_cache, "p")
          end

          for _, file in ipairs(vim.fn.readdir(hl_files)) do
            local filename = vim.fn.fnamemodify(file, ":r")
            M.toCache(filename, M.loadTb(filename))
          end
        end

        M.load            = function()
          M.compile()
          for _, file in ipairs(vim.fn.readdir(vim.g.theme_cache)) do
            dofile(vim.g.theme_cache .. file)
          end
        end

        return M
      '';
  };
}
