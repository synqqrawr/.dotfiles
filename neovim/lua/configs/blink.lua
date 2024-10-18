return {
	nerd_font_variant = "normal",
	-- experimental auto-brackets support
	accept = { auto_brackets = { enabled = true } },
	-- experimental signature help support
	trigger = { signature_help = { enabled = true } },
	keymap = {
		accept = "<C-y>",
		select_prev = { "<C-k>" },
		select_next = { "<C-j>" },
	},
}
