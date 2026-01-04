return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "lua", "c", "rust", "python", "bash", "markdown" },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = true,
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true, -- adds to jumplist
                    goto_next_start = {
                        ["<C-l>"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["<C-x>"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["<C-h>"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["<C-a>"] = "@function.outer",
                    },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                    }
                },
            },
        }
    end,
}
