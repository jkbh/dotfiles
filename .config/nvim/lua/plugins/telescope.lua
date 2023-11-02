return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{"nvim-telescope/telescope-fzf-native.nvim", build = 'make'}
	},
	config = function()
		require('telescope').load_extension('fzf')

		local keymap = require('vim.keymap')
		local builtin = require('telescope.builtin')
		keymap.set('n', '<leader>ff', builtin.find_files)
		keymap.set('n', '<leader>fr', builtin.oldfiles)
		keymap.set('n', '<leader>fs', builtin.live_grep)
	end
}
