return {
	"nvim-lua/plenary.nvim",
	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},
	"nvzone/volt",
	{
		"nvzone/minty",
		cmd = { "Huefy", "Shades" },
	},
	"nvzone/menu",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return require("configs.gitsigns")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = function()
			require("configs.lspconfig").defaults()
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = function()
			return require("configs.conform")
		end,
	},
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = function()
			return require("configs.blink")
		end,
	},
	{
		"echasnovski/mini.files",
		opts = true,
		dependencies = {
			"folke/snacks.nvim",
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					require("snacks").rename.on_rename_file(event.data.from, event.data.to)
				end,
			})
		end,
	},
	{
		"folke/snacks.nvim",
    ---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = false },
			quickfile = { enabled = true },
			statuscolumn = { enabled = false },
      words = { enabled = false },
		},
    priority = 1000,
		lazy = false,
	},
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		tag = "v3.8.2",
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
				{ path = "ui/nvchad_types" },
			},
		},
	},
	"Bilal2453/luvit-meta",
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = true,
	},
}
