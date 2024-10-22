local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		scss = { "prettierd" },
		astro = { "prettierd" },
	},

	-- format_on_save = {
	--   -- These options will be passed to conform.format()
	--   timeout_ms = 500,
	--   lsp_fallback = true,
	-- },
}

return options
