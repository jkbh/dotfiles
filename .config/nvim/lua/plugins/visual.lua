return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = true,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme tokyonight]]
	-- 	end
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd [[colorscheme catppuccin]]
	-- 	end
	-- },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd [[colorscheme gruvbox]]
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
		opts = {
			icons_enabled = false,
			component_seperators = '|',
			section_seperators = '',
		}
	}
}
