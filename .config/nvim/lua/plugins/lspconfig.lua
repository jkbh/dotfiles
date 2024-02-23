return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local telescope = require('telescope.builtin')
		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr }
			local keymap = require('vim.keymap')

			-- Edit Actions
			keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
			keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

			-- Analysis
			keymap.set('n', 'gd', telescope.lsp_definitions, opts)
			keymap.set('n', 'gr', telescope.lsp_references, opts)
			keymap.set('n', 'gI', telescope.lsp_implementations, opts)

			-- Hover
			keymap.set('n', 'K', vim.lsp.buf.hover, opts)

			-- Create :Format command
			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format buffer with LSP' })
		end

		require('mason').setup()
		require('mason-lspconfig').setup()

		local servers = {
			ruff_lsp = {},
			jedi_language_server = {},
			rust_analyzer = {
				['rust-analyzer'] = {
					check = {
						command = "clippy"
					},
					imports = {
						granularity = {
							group = "module"
						}
					}
				}
			},
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
					diagnostics = { disable = { 'missing-fields' } },
				},
			}
		}

		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		require('mason-lspconfig').setup {
			ensure_installed = vim.tbl_keys(servers)
		}

		require('mason-lspconfig').setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					file_types = (servers[server_name] or {}).filetypes,
				}
			end
		}
		-- Create an augroup that is used for managing our formatting autocmds.
		--      We need one augroup per client to make sure that multiple clients
		--      can attach to the same buffer without interfering with each other.
		local _augroups = {}
		local get_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = 'kickstart-lsp-format-' .. client.name
				local id = vim.api.nvim_create_augroup(group_name, { clear = true })
				_augroups[client.id] = id
			end

			return _augroups[client.id]
		end

		-- Whenever an LSP attaches to a buffer, we will run this function.
		--
		-- See `:help LspAttach` for more information about this autocmd event.
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
			-- This is where we attach the autoformatting for reasonable clients
			callback = function(args)
				local client_id = args.data.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local bufnr = args.buf

				-- Only attach to clients that support document formatting
				if not client.server_capabilities.documentFormattingProvider then
					return
				end

				-- Tsserver usually works poorly. Sorry you work with bad languages
				-- You can remove this line if you know what you're doing :)
				if client.name == 'tsserver' then
					return
				end

				-- Create an autocmd that will run *before* we save the buffer.
				--  Run the formatting command for the LSP that has just attached.
				vim.api.nvim_create_autocmd('BufWritePre', {
					group = get_augroup(client),
					buffer = bufnr,
					callback = function()
						-- if not format_is_enabled then
						-- 	return
						-- end

						vim.lsp.buf.format {
							async = false,
							filter = function(c)
								return c.id == client.id
							end,
						}
					end,
				})
			end,
		})
	end
}
