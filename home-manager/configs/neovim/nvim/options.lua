local o = vim.opt
local g = vim.g

g.mapleader = " "
g.toggle_theme_icon = "   "

-- Line numbers
o.number = true
o.relativenumber = true

-- Tabs
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true

o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undo//"

-- https://www.reddit.com/r/neovim/comments/wlkq0e/neovim_configuration_to_backup_files_with/
o.backup = true
o.backupdir = vim.fn.stdpath("data") .. "/backup//"

o.clipboard = "unnamedplus"

-- Statuscolumn

-- Set sign column to be 4.
-- So, if I have a new diff, It'll not feel weird, by the signcolumn expanding

o.signcolumn = "yes"
o.cursorline = true

o.laststatus = 3

-- Folds

o.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
o.foldlevel = 99

o.foldmethod = "expr"
vim.schedule(function()
  o.foldexpr = "v:lua.require'utils.ui'.foldexpr()"
end)
  o.statuscolumn = [[%!v:lua.require'utils.ui'.statuscolumn()]]
o.foldtext = ""
o.fillchars = "fold: "

-- Scrolloff

o.scrolloff = 15

-- Searching
o.ignorecase = true
o.smartcase = true

o.pumheight = 10 -- Maximum number of entries in a popup

-- Sessions
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
