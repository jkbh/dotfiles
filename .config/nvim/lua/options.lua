vim.o.hlsearch = false                 -- No highlight on search
vim.wo.number = true                   -- Show line numbers
vim.wo.relativenumber = true           -- Use relative line numbers
vim.wo.signcolumn = "yes"              -- Always show sign column
vim.o.completeopt = 'menuone,noselect' -- One completion menu, dont autoselect first entry
vim.o.undofile = true                  -- Save undo history
-- vim.o.breakindent = true               -- Enable break indent
vim.o.clipboard = 'unnamedplus'        -- Sync os and nvim clipboard
vim.o.cursorline = true                -- Highlight full cursor line
vim.o.background = 'dark'              -- Use light mode
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.termguicolors = true

-- Filebrowser
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
