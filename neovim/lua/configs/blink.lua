return {
	nerd_font_variant = "normal",
	-- experimental auto-brackets support
	accept = { auto_brackets = { enabled = true } },
	-- experimental signature help support
	trigger = { signature_help = { enabled = true } },
	keymap = {
		["<C-k>"] = { "select_prev" },
		["<C-j>"] = { "select_next" },
		["<C-y>"] = { "select_and_accept" },

		["Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	sources = {
		completion = {
			enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
		},
		providers = {
			lsp = { fallback_for = { "lazydev" } },
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
		},
	},
}
