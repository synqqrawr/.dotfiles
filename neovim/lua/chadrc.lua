---@type ChadrcConfig
local M = {}
local utils = require("nvchad.stl.utils")

M.nvdash = {
  load_on_startup = true,
  buttons = {
    { txt = "  Find File", keys = "Spc f f", cmd = [[lua require("mini.pick").builtin.files({ tool = "rg" })]] },
    {
      txt = "󰈚  Recent Files",
      keys = "Spc f o",
      cmd = [[lua require("mini.extra").pickers.oldfiles({ tool = "rg" })]],
    },
    {
      txt = "󰈭  Find Word",
      keys = "Spc f g",
      cmd = [[lua require("mini.pick").builtin.grep_live({ tool = "rg" })]],
    },
    { txt = "󱥚  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "diagnostics",
      "cwd",
      "cursor",
    },
    modules = {
      git = function()
        local git_status = vim.b[utils.stbufnr()].minigit_summary_string or ""

        local summary = vim.b[utils.stbufnr()].minigit_summary
        local branch_name = (summary ~= nil and summary.head_name) and (" " .. git_status) or ""

        summary = vim.b.minidiff_summary
        return "%#St_gitIcons# "
          .. branch_name
          .. (
            summary ~= nil
              and " " .. ((summary.add ~= nil and summary.add > 0) and dots.UI.icons.Git.added .. summary.add or "") .. ((summary.change ~= nil and summary.change > 0) and dots.UI.icons.Git.changed .. summary.change or "") .. ((summary.delete ~= nil and summary.delete > 0) and dots.UI.icons.Git.remove .. summary.delete or "")
            or ""
          )
      end,
    },
  },
}

M.base46 = {
  theme = "yoru",
  hl_override = {
    DiffAdd = { fg = "green" },
    DiffModified = { fg = "yellow" },

    FloatBorder = { fg = "darker_black", bg = "darker_black" },
    NormalFloat = { bg = "darker_black" },

    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  hl_add = {
    MiniDiffSignAdd = { fg = "green" },
    MiniDiffSignChange = { fg = "yellow" },
    MiniDiffSignDelete = { fg = "red" },

    MiniNotifyNormal = { link = "Normal" },

    MiniPickBorderText = { bg = "darker_black", fg = "green" },
    MiniPickPrompt = { bg = "darker_black", fg = "green" },
    MiniPickHeader = { bg = "darker_black" },
    MiniPickBorderBusy = { bg = "darker_black", fg = "darker_black" },
    MiniPickMatchRanges = { fg = "purple" },

    MiniFilesTitle = { bg = "darker_black", fg = "grey" },
    MiniFilesTitleFocused = { bg = "darker_black", fg = "white" },
  },
}

M.lsp = {
  signature = false,
}

return M
