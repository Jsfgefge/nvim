print("this works")

require('config.lazy')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- highlight text when we something
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.clipboard = 'unnamedplus'

vim.o.relativenumber = true

vim.cmd "colorscheme habamax"


--LSP Mappings
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")
