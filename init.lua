vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.opt.termguicolors = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- Customization

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- colorscheme
vim.cmd([[
	colorscheme unokai
	set clipboard^=unnamedplus
]])

-- Keybindings

vim.keymap.set({ "v", "i" }, "<C-c>", "<Esc>")
-- Surround buffer with "
vim.keymap.set("n", "<leader>iq", 'a""<C-c>P')
-- Surround buffer with (
vim.keymap.set("n", "<leader>ip", "a()<C-c>P")
-- Yank all line without newline
vim.keymap.set("n", "<leader>yy", "_y$")
-- Delete all line without yanking newline
vim.keymap.set("n", "<leader>dd", "_d$")
-- Start a new line in command mode
vim.keymap.set("n", "<leader>o", "o<C-c>")
-- Start a new line in command mode above current line
vim.keymap.set("n", "<leader>O", "O<C-c>")
-- Paste without overriding buffer
vim.keymap.set("v", "<leader>p", '"_dP')
-- Close Quickfix(lsp references window)
vim.keymap.set({ "n", "i", "v" }, "<C-q>", function()
	vim.cmd("ccl")
end)
-- Focus on Quickfix(lsp references window)
vim.keymap.set({ "n", "i", "v" }, "<C-j>", function()
	vim.cmd("cope")
end)

vim.api.nvim_create_user_command("LspWhoDiagnostics", function()
	local lnum = vim.fn.line(".") - 1
	for _, d in ipairs(vim.diagnostic.get(0, { lnum = lnum })) do
		local client = vim.lsp.get_client_by_id(d.source)
		print(string.format("From: %s\n  → %s", (client and client.name) or d.source or "unknown", d.message))
	end
end, {})

require("config.lazy")
