return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
      require("mason-lspconfig").setup {
        ensure_installed = {
          "pyright",
          "lua_ls",
          "clangd",
          "ts_ls",
          "jdtls",
        }
      }

      require("lspconfig").lua_ls.setup { capabilites = capabilities }
      require("lspconfig").clangd.setup { capabilites = capabilities }
      require("lspconfig").ts_ls.setup { capabilites = capabilities }
      require("lspconfig").pyright.setup { capabilites = capabilities }
      require 'lspconfig'.jdtls.setup {
        capabilities = capabilities,
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find({ 'build.xml', '.git', 'mvnw', 'gradlew' }, { upward = true })[1])
        end,
        settings = {
          java = {
            configuration = {
              sources = {
                sourcePaths = {
                  "src", -- Main source directory (your Java files live here)
                  -- "test" -- Uncomment if you have test sources
                }
              }
            },
            project = {
              referencedLibraries = {
                "lib/**/*.jar" -- If you have external libraries in a `lib` folder
              }
            }
          }
        }

      }




      --Save with Ctrl+K, Ctrl+D
      vim.keymap.set("n", "<C-K><C-D>", function() vim.lsp.buf.format() end)
      vim.keymap.set("n", "<F12>", function() vim.lsp.buf.definition() end)

      --Save with :w
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
