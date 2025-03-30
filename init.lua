print("this works")

require('config.lazy')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<CR>")

-- Tmux Navigation
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")


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

vim.opt.colorcolumn = "80"

-- vim.cmd "colorscheme habamax"
vim.cmd "colorscheme poimandres"
-- vim.cmd "colorscheme gruvbox"
-- vim.cmd "colorscheme catppuccin-mocha"
vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp


--LSP Mappings
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")


-- Enable autoread and set up checking triggers
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})

vim.cmd [[highlight Normal guibg=none]]
vim.cmd [[highlight NonText guibg=none]]
