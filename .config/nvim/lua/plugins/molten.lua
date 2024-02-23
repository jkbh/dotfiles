return {
	{
		"benlubas/molten-nvim",
		-- dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- vim.g.molten_image_provider = "image.nvim"
			vim.keymap.set("n", "<localleader>R", ":MoltenEvaluateOperator<CR>",
				{ silent = true, noremap = true, desc = "run operator selection" })
			vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
				{ silent = true, noremap = true, desc = "evaluate line" })
			vim.keymap.set("n", "<localleader>rc", ":MoltenReevaluateCell<CR>",
				{ silent = true, noremap = true, desc = "re-evaluate cell" })
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, noremap = true, desc = "evaluate visual selection" })
			vim.g.molten_output_win_max_height = 20
		end
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	opts = {
	-- 		backend = "kitty", -- whatever backend you would like to use
	-- 		max_width = 100,
	-- 		max_height = 12,
	-- 		max_height_window_percentage = math.huge,
	-- 		max_width_window_percentage = math.huge,
	-- 		window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	-- 		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 	},
	-- }
}
