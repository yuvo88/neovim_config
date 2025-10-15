return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.workspace = capabilities.workspace or {}
            capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = true }
            local on_attach = function(client, bufnr)
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                local map = vim.keymap.set
                map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, bufopts)
                map("n", "K", vim.lsp.buf.hover, bufopts)
                map("n", "gD", vim.lsp.buf.declaration, bufopts)
                map("n", "<leader>e", vim.diagnostic.open_float, bufopts)
                map("n", "<leader>.", vim.lsp.buf.code_action, bufopts)
                map("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                map("n", "<leader>f", vim.lsp.buf.format, bufopts)
                client.server_capabilities.semanticTokensProvider = nil
            end

            local servers = { "lua_ls", "bashls", "clangd" }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
                vim.lsp.enable(server)
            end
            vim.lsp.config("ruff", {
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.codeActionProvider = false
                end,
            })
            vim.lsp.enable('ruff')
            vim.lsp.config("basedpyright", {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            autoImportCompletions = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                            autoSearchPath = true,
                            inlayHints = {
                                callArgumentNames = true,
                            },
                            typeCheckingMode = "basic",
                            ignore = { "/home/john/Tamnoon-Backend/tamnoon/*" },
                        },
                        python = {
                            -- venvPath = "/home/john/general_venv",
                            -- venv = "general_venv",
                            analysis = {
                                autoImportCompletions = true,
                            },
                        },
                    },
                },
            })
            vim.lsp.enable('basedpyright')
        end,
    },
}
