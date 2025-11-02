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
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition #leaderless')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition #leaderless')
        nmap('gD', vim.lsp.buf.type_definition, '[G]oto Type [D]efinition #leaderless')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences #leaderless')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation #leaderless')
        nmap('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation #leaderless')
        nmap('gs', vim.lsp.buf.signature_help, '[G]oto [S]ignature Documentation #leaderless')

        -- Lesser used LSP functionality
        nmap('<space>D', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
        nmap('<leader>fm', '<cmd>Format<CR>', '[F]or[M]at')


        -- Conjure buffer detach LSP
        -- https://www.reddit.com/r/neovim/comments/xqogsu/turning_off_treesitter_and_lsp_for_specific_files/
        local bufname = vim.fn.expand("%")
        local is_conjure = string.match(bufname, "^conjure%-log%-[0-9]+%.cljc$")
        if is_conjure then
          vim.lsp.buf_detach_client(bufnr, client.id)
        end
      end

      local servers = {
        pyright = {},
        lua_ls = {},
        clangd = {},
        omnisharp = {},
        ts_ls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        cssmodules_ls = {},
        -- emmet_ls = {},
        emmet_language_server = {},
        rust_analyzer = {}
        -- angularls = {},
      }

      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      for server, config in pairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach = on_attach
        })
      end


      --Provents emmet from showing outside return () in tsx files
      vim.lsp.config('emmet_language_server', {
        capabilities = capabilities,

        on_attach = function(client, bufnr)
          -- Get the filetype for the current buffer
          local filetype = vim.bo[bufnr].filetype


          -- Only attach Emmet for specific file types (e.g., JSX/TSX)
          if filetype == 'javascriptreact' or filetype == 'typescriptreact' then
            -- Only enable emmet in JSX return blocks
            vim.api.nvim_create_autocmd("CursorMovedI", {
              buffer = bufnr,
              callback = function()
                local ts_utils = require("nvim-treesitter.ts_utils")
                local node = ts_utils.get_node_at_cursor()

                if not node then return end

                local in_jsx = false
                while node do
                  local type = node:type()
                  if type == "jsx_element" or type == "jsx_self_closing_element" or type == "jsx_fragment" then
                    in_jsx = true
                    break
                  end
                  node = node:parent()
                end

                if in_jsx then
                  client.server_capabilities.completionProvider = { triggerCharacters = { ">", ".", ":" } }
                else
                  client.server_capabilities.completionProvider = nil
                end
              end,
            })
          end
        end,
      })

      -- vim.lsp.config('lua_ls', {
      --   capabilities = capabilities,
      --   on_attach = on_attach
      -- })
      -- mason_lspconfig.setup {
      -- }
      --

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        -- handlers = {
        --   function(server_name)
        --     print(server_name)
        --     require('lspconfig')[server_name].setup {
        --       capabilities = capabilities,
        --       on_attach = on_attach,
        --       autostart = (servers[server_name] or {}).autostart,
        --       root_dir = (servers[server_name] or {}).root_dir,
        --       settings = (servers[server_name] or {}).settings,
        --       filetypes = (servers[server_name] or {}).filetypes,
        --       single_file_support = (servers[server_name] or {}).single_file_support,
        --     }
        --   end
        -- }
      })
      -- require("lspconfig").lua_ls.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").clangd.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").ts_ls.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").pyright.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").omnisharp.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").angularls.setup { capabilities = capabilities, on_attach = on_attach }
      -- require("lspconfig").html.setup {
      --   capabilities = capabilities,
      --   filetypes = { "html", "htmlangular" },
      -- }
      -- require("lspconfig").emmet_language_server.setup { capabilites = capabilities, }


      --Save with Ctrl+K, Ctrl+D
      vim.keymap.set("n", "<C-K><C-D>", function() vim.lsp.buf.format() end)
      vim.keymap.set("n", "<F12>", function() vim.lsp.buf.definition() end)
      -- vim.keymap.set("n", "<F12>", function() vim.lsp.buf.type_definition() end)
      -- vim.keymap.set("n", "grt", function() vim.lsp.buf.type_definition() end)

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
