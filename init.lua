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

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.clipboard = 'unnamedplus'

vim.opt.scrolloff = 8

vim.cmd "colorscheme habamax"
vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp


--LSP Mappings
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")
