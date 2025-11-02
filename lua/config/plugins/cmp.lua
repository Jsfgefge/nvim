return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '*',
    opts = {
      -- sources = {
      --   default = {},
      -- },

      sources = {
        default = { 'lsp',
          'buffer',
          'snippets',
          'path',
          -- "emmet_language_server"
        },
      },
      keymap = {
        preset = 'enter',
        -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation', 'hide', 'fallback' },
        -- ['<C-e>'] = { 'hide', 'fallback' },
        -- ['<CR>'] = { 'accept', 'fallback' },
        --
        -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
        -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        --
        -- ['<Up>'] = { 'select_prev', 'fallback' },
        -- ['<Down>'] = { 'select_next', 'fallback' },
        -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        --
        -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        --
        -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true
          }
        },

        menu = {
          -- auto_show = false
          -- auto_show = function(_)
          --   if vim.bo.filetype == 'html' or vim.bo.filetype == 'htmlangular' then
          --     return false
          --   else
          --     return true
          --   end
          -- end,
          draw = {

            -- Aligns the keyword you've typed to a component in the menu
            align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
            -- Left and right padding, optionally { left, right } for different padding on each side
            padding = 1,
            -- Gap between columns
            gap = 1,
            -- Priority of the cursorline highlight, setting this to 0 will render it below other highlights
            cursorline_priority = 10000,
            -- Use treesitter to highlight the label text for the given list of sources
            treesitter = {},
            -- treesitter = { 'lsp' }

            -- Components to render, grouped by column
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

            -- Definitions for possible components to render. Each defines:
            --   ellipsis: whether to add an ellipsis when truncating the text
            --   width: control the min, max and fill behavior of the component
            --   text function: will be called for each item
            --   highlight function: will be called only when the line appears on screen
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
                highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
              },

              kind = {
                ellipsis = false,
                width = { fill = true },
                text = function(ctx) return ctx.kind end,
                highlight = function(ctx) return ctx.kind_hl end,
              },

              label = {
                width = { fill = true, max = 60 },
                text = function(ctx) return ctx.label .. ctx.label_detail end,
                highlight = function(ctx)
                  -- label and label details
                  local highlights = {
                    { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                  }
                  if ctx.label_detail then
                    table.insert(highlights,
                      { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                  end

                  -- characters matched on the label by the fuzzy matcher
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                  end

                  return highlights
                end,
              },

              label_description = {
                width = { max = 30 },
                text = function(ctx) return ctx.label_description end,
                highlight = 'BlinkCmpLabelDescription',
              },

              source_name = {
                width = { max = 30 },
                text = function(ctx) return ctx.source_name end,
                highlight = 'BlinkCmpSource',
              },

              source_id = {
                width = { max = 30 },
                text = function(ctx) return ctx.source_id end,
                highlight = 'BlinkCmpSource',
              },
            },

          }
          -- draw = {
          --   components = {
          --     source_name = {
          --       width = { max = 30 },
          --       text = function(ctx) return ctx.label_description end,
          --       highlight = 'BlinkCmpLabelDescription',
          --     }
          --   }
          -- }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = {
            min_width = 10,
            max_width = 80,
            max_height = 20,
            border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
            winblend = 0,
            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
            -- Note that the gutter will be disabled when border ~= 'none'
            scrollbar = true,
            -- Which directions to show the documentation window,
            -- for each of the possible menu window directions,
            -- falling back to the next direction when there's not enough space
            direction_priority = {
              menu_north = { 'e', 'w', 'n', 's' },
              menu_south = { 'e', 'w', 's', 'n' },
            },
          },
        },
      },



      signature = { enabled = true },
    },
  }
}
