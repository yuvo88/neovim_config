return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	cmdline = { enabled = false },
	dependencies = {
		"folke/lazydev.nvim",
	},
	opts = {
		keymap = {
			preset = "default",
			["<Enter>"] = { "accept", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},

		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},

		fuzzy = { implementation = "lua" },
		signature = { enabled = true },
	},
}
