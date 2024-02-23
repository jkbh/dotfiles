return {
	"lervag/vimtex",
	init = function()
		vim.o.breakindent = false;
		vim.o.linebreak = true;
		vim.o.breakat = '.?!';
		vim.g.vimtex_quickfix_open_on_warning = 0;
	end
}
