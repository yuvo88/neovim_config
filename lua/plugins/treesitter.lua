return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "go", "c"},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    })
  end,
}

