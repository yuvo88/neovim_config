vim.g.mapleader = " "
vim.opt_local.laststatus = 0
vim.opt.number = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.cmd ([[
	set clipboard^=unnamedplus
]])
vim.cmd ([[
	colorscheme unokai
]])

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.inlay_hint.enable(true)
require("config.lazy")
require("config.keybindings")
