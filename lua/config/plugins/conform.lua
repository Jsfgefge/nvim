return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          python = { "isort", "black" },
          htmlangular = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier", "rustywind" },
          javascriptreact = { "prettier", "rustywind" },
          typescriptreact = { "prettier", "rustywind" },
          javascript = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
          rust = { "rustfmt", lsp_format = "fallback" },
        },

        formatters = {
          prettier = {
            command = "prettier",
            args = { "--stdin-filepath", "$FILENAME" },
            stdin = true,
          },
          rustywind = {
            command = "rustywind",
            args = { "--stdin" },
            stdin = true,
          },
        },
        format_on_save = {
          enabled = true,
          allow_filetypes = { 'python' }
        }
      })

      vim.keymap.set('n', '<leader>cf', function()
        print("format")
        conform.format({ lsp_format = 'fallback' })
      end, { noremap = true, silent = true, desc = 'Format file using conform' })
    end
  }
}
