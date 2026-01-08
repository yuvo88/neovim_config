vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.opt.termguicolors = false

vim.opt.number = true
vim.o.scrollbind = true
vim.o.scrolloff = 8
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.diffopt = vim.o.diffopt .. ",vertical"
vim.o.diffopt = vim.o.diffopt .. ",iwhite"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.o.textwidth = 80
    end,
})
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
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- Keybindings

vim.lsp.inlay_hint.enable(true)

require("config.keybinds")
require("config.terminal")
require("config.lazy")
