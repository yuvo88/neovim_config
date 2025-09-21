return {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    config = function()
        require("oil").setup({
            columns = { "icon" },
            watch_for_changes = true,
            lsp_file_methods = {
                autosave_changes = true
            }
        })
        vim.keymap.set("n", "-", require("oil").open)
    end,
}
