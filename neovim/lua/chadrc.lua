-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "yoru",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.ui = {
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
	},
	statusline = {
		enabled = true,
		theme = "default", -- default/vscode/vscode_colored/minimal
		-- default/round/block/arrow separators work only for default statusline theme
		-- round and block will work for minimal theme only
		separator_style = "default",
		order = nil,
		modules = {
			git = function()

				local git_status = vim.b.minidiff_summary

				if not git_status then
					return ""
				end

				local add = (git_status.add and git_status.add ~= 0) and ("  " .. git_status.add) or ""
				local change = (git_status.change and git_status.change ~= 0) and ("  " .. git_status.change)
					or ""
				local delete = (git_status.delete and git_status.delete ~= 0) and ("  " .. git_status.delete)
					or ""
				local branch_name = vim.b.minigit_summary_string and (" " .. vim.b.minigit_summary_string) or ""

				return " " .. branch_name .. add .. change .. delete
			end,
		},
	},
}

M.lsp = { signature = false }

return M
