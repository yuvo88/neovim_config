return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
	event = "VeryLazy",
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"build/**",
					"dist/**",
					".git",
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			},
		})
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "[S]earch [C]ommand History" })
		vim.keymap.set("n", "<leader>sl", builtin.live_grep, { desc = "[S]earch [L]ive Grep" })
		vim.keymap.set("n", "<leader>sr", builtin.buffers, { desc = "[S]earch [R]ecent Files" })
		vim.keymap.set("n", "<leader>ss", builtin.search_history, { desc = "[S]earch [S]earch History" })
		vim.keymap.set("n", "gu", builtin.lsp_references, { desc = "LSP [G]et [U]sages" })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP [G]et [D]efinitions" })
		vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP [G]et [I]mplementation" })
		vim.keymap.set("n", "ge", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = "LSP [G]et [E]rrors" })
	end,
}
