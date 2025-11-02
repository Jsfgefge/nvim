print("this works")

require('config.lazy')

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("n", "vw", "viw")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<CR>")

vim.keymap.set('n', '<space><Esc>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-CR>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

--Insert mode Mappings

vim.keymap.set("i", "<A-k>", "<C-o>m`<C-o>O<C-o>``", { noremap = true })
vim.keymap.set("i", "<A-j>", "<C-o>m`<C-o>o<C-o>``", { noremap = true })
-- vim.keymap.set("i", "<C-e>", "<C-o>l")
-- vim.keymap.set("i", "<C-q>", "<C-o>h")

vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-h>", "<Left>")

-- Tmux Navigation
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")

-- Oil.nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Toggle Inline Error
vim.keymap.set("n", "<leader>te", function()
    local current = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not current })
end, { desc = "Toggle inline diagnostics (virtual_lines)" })

vim.keymap.set("n", "<space>k", vim.lsp.buf.hover, { desc = "Hover Type Info" })
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

vim.o.winborder = 'rounded'

vim.opt.termguicolors = true


-- vim.cmd "colorscheme industry"
-- vim.cmd "colorscheme habamax"
-- vim.cmd "colorscheme poimandres"
-- vim.cmd "colorscheme gruvbox"
-- vim.cmd "colorscheme catppuccin-mocha"
-- vim.cmd "colorscheme carbonfox"
-- vim.cmd "colorscheme nightfox"

-- vim.cmd "colorscheme catppuccin-macchiato"
-- vim.cmd "colorscheme tokyonight"
vim.cmd "colorscheme tokyonight-storm"
-- vim.cmd "colorscheme catppuccin"
-- vim.cmd "colorscheme rose-pine"

-- vim.cmd "colorscheme murphy"

-- vim.cmd "colorscheme vscode_modern"
vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp


--LSP Mappings
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")


-- Enable autoread and set up checking triggers
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = "*",
})


-- vim.diagnostic.config({ virtual_lines = false })
-- vim.lsp.inlay_hint.enable(true)
