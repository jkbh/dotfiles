return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'rafamadriz/friendly-snippets'
	},
	config = function()
		local cmp = require('cmp')
		require('luasnip.loaders.from_vscode').lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end
			},
			mapping = cmp.mapping.preset.insert({
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path' },
			}, {
				{ name = 'buffer' },
			})

		}) -- `/` cmdline setup.

		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
		})
	end
}