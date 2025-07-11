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
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				local map = vim.keymap.set
				map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, bufopts)
				map("n", "K", vim.lsp.buf.hover, bufopts)
				map("n", "gD", vim.lsp.buf.declaration, bufopts)
				map("n", "gd", function()
					vim.lsp.buf.definition()
				end, bufopts)
				map("n", "gi", vim.lsp.buf.implementation, bufopts)
				map("n", "go", vim.lsp.buf.type_definition, bufopts)
				map("n", "gu", vim.lsp.buf.references, bufopts)
				map("n", "<leader>e", vim.diagnostic.open_float, bufopts)
				map("n", "<leader>.", vim.lsp.buf.code_action, bufopts)
				map("n", "<leader>r", vim.lsp.buf.rename, bufopts)
				client.server_capabilities.semanticTokensProvider = nil
			end

			local servers = { "lua_ls", "ts_ls", "gopls", "bashls", "clangd" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
			lspconfig["ruff"].setup({
				on_attach = function(client)
					client.server_capabilities.hoverProvider = false
				end,
			})
			lspconfig["basedpyright"].setup({
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
							typeCheckingMode = "off",
						},
						python = {
							venvPath = "/home/john/general_venv",
							venv = "general_venv",
						},
					},
				},
			})
			lspconfig["pylsp"].setup({
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = true, strict = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
							pylint = { enabled = false },
							flake8 = { enabled = false },
							pydocstyle = { enabled = false },
							-- Keep navigation-related plugins enabled
							rope_completion = { enabled = false },
							jedi_completion = { enabled = false },
							jedi_definition = { enabled = false },
							jedi_hover = { enabled = false },
							jedi_references = { enabled = false },
							jedi_signature_help = { enabled = false },
							jedi_symbols = { enabled = false },
						},
						python = {
							venvPath = "/home/john/general_venv",
							venv = "general_venv",
						},
					},
				},
			})
		end,
	},
}
