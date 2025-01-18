return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          python = { "black" }
        },

        format_on_save = {
          enabled = true,
          allow_filetypes = { 'python' }
        }
      })

      vim.keymap.set('n', '<leader>cf', function()
        conform.format({ async = true, lsp_fallback = true })
      end, { noremap = true, silent = true, desc = 'Format file using conform' })
    end
  }
}
