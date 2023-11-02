return {
	'ellisonleao/gruvbox.nvim',
	priority = 1000,
	name = 'gruvbox',
	config = function()
		vim.o.background = "dark"
		-- require("gruvbox").setup()
		vim.cmd([[colorscheme gruvbox]])
	end
}
