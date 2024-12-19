local M = {}

M.cmp = {
	nerd_font_variant = "normal",
	-- experimental auto-brackets support
	completion = {
		accept = { auto_brackets = { enabled = true } },
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
	},
	-- experimental signature help support
	signature = {
		enabled = true,
	},
	keymap = {
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-y>"] = { "select_and_accept", "fallback" },

		["Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	windows = {
		ghost_text = {
			enabled = true,
		},
	},
	sources = {
		default = { "lazydev" },
		providers = {
			lsp = { fallback_for = { "lazydev" } },
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100, -- show at a higher priority than lsp
			},
		},
	},
}

return M
