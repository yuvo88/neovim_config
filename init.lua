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

-- Remove highlight
vim.keymap.set({ "n", "i", "v" }, "<C-h>", function()
    vim.cmd("noh")
end)

-- Git blame command
vim.keymap.set('n', '<leader>gb', function()
    vim.cmd("normal! zz")
    local line_number = vim.fn.line(".")
    local filename = vim.fn.expand('%:p')
    local result = vim.fn.systemlist("git blame -- " .. filename .. "| cut -d'(' -f 2 | cut -d ')' -f 1")
    vim.cmd('vnew')
    vim.cmd('vertical resize -45')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, result)
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'wipe'
    vim.bo.swapfile = false
    vim.bo.filetype = 'gitblame'
    vim.api.nvim_win_set_cursor(0, { line_number, 0 })
    vim.cmd("normal! zz")
end, { desc = '[G]it [B]lame' })
vim.keymap.set('n', '<leader>cr', function()
    vim.cmd(":%s/\r//g")
end, { desc = '[C]lear Carriage [R]eturn' }
)

vim.lsp.inlay_hint.enable(true)

require("config.lazy")
