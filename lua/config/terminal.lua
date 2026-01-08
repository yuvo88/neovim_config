-- For terminal mode

--   Exit terminal mode
vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.laststatus = 0
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.opt_local.laststatus = 2
  end,
})
