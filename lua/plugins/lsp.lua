return {
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
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client then
					if client.name == "ruff" then
						client.server_capabilities.hoverProvider = false
						client.server_capabilities.codeActionProvider = false
						client.server_capabilities.renameProvider = false
						client.server_capabilities.documentFormattingProvider = true
						client.server_capabilities.documentRangeFormattingProvider = true
					end
					client.server_capabilities.semanticTokensProvider = nil
				end
			end,
		})
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				source = "if_many",
				header = "",
				prefix = "",
				scope = "cursor",
				severity_sort = true,
			},
		})
		local map = vim.keymap.set
		map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help)
		map("n", "K", vim.lsp.buf.hover)
		map("n", "<leader>e", vim.diagnostic.open_float)
		map("n", "<leader>.", vim.lsp.buf.code_action)
		map("n", "<leader>r", vim.lsp.buf.rename)
		map({ "n", "v" }, "<leader>f", vim.lsp.buf.format)
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			clangd = {},
			ty = {},
			gopls={},
			terraformls={},
			rust_analyzer = {
				cmd = { "rust-analyzer" },
				capabilities = capabilities,
				single_file_support = false,

				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							-- You can also use:
							-- features = "all",
						},
						checkOnSave = true,
						procMacro = {
							enable = true,
						},
						rustfmt = {
							enable = true,
						},
					},
				},
			},
			ruff = {
				on_attach = function(client)
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.codeActionProvider = false
				end,
			},
			lua_ls = {},
		}
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
