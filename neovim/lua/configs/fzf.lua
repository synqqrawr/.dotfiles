return {
	"default-title",
	hls = {
		normal = "TelescopeNormal",
		query = "TelescopeNormal",
		preview_normal = "TelescopeNormal",
		gutter = "TelescopeNormal",
		backdrop = "TelescopeNormal",
		border = "TelescopeBorder",
		preview_border = "TelescopeBorder",
		prompt = "TelescopePromptNormal",
		preview_title = "TelescopePreviewTitle",
		title = "TelescopePromptTitle",
	},
	fzf_colors = {
		["bg"] = { "bg", { "TelescopeNormal", "Normal" } },
		["bg+"] = { "bg", { "TelescopeNormal", "Normal" } },
		-- ["gutter"] = { "bg", hls.bg },
		-- ["bg"] = { "bg", hls.bg },
		-- ["bg+"] = { "bg", hls.sel },
		-- ["fg+"] = { "fg", hls.sel },
		-- ["fg+"]    = { "fg", "", "reverse:-1" },
	},
}
