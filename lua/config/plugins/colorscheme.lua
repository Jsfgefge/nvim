return {
  {
    "navarasu/onedark.nvim"
  },
  {
    "nyoom-engineering/oxocarbon.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config =
        function()
          require("catppuccin").setup({
            flavour = "auto", -- latte, frappe, macchiato, mocha
            background = {    -- :h background
              light = "latte",
              dark = "mocha",
            },
            transparent_background = true, -- disables setting the background color.
            float = {
              transparent = true,
              solid = true
            },
            show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            term_colors = true,         -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
              enabled = false,          -- dims the background color of inactive window
              shade = "dark",
              percentage = 0.15,        -- percentage of the shade to apply to the inactive window
            },
            no_italic = false,          -- Force no italic
            no_bold = false,            -- Force no bold
            no_underline = false,       -- Force no underline
            styles = {                  -- Handles the styles of general hi groups (see `:h highlight-args`):
              comments = { "italic" },  -- Change the style of comments
              conditionals = { "italic" },
              loops = {},
              functions = {},
              keywords = {},
              strings = {},
              variables = {},
              numbers = {},
              booleans = {},
              properties = {},
              types = {},
              operators = {},
              -- miscs = {}, -- Uncomment to turn off hard-coded styles
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              notify = false,
              mini = {
                enabled = true,
                indentscope_colo = "",
              },
              -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
          })
        end
  },

  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        bold_vert_split = false,         -- use bold vertical separators
        dim_nc_background = true,        -- dim 'non-current' window backgrounds
        disable_background = true,       -- disable background
        disable_float_background = true, -- disable background for floats
        disable_italics = false,         -- disable italics
      }
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      })
    end,
    opts = ...
  },
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
        nvim_tree_darker = true,
      })
      vim.cmd.colorscheme("vscode_modern")
    end,
  },
  { "rose-pine/neovim",      name = "rose-pine" },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",         -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      light_style = "day",    -- The theme is used when the background is set to light
      transparent = true,     -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "normal",    -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      day_brightness = 0.3,     -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      dim_inactive = false,     -- dims inactive windows
      lualine_bold = false,     -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors) end,

      cache = true, -- When set to true, the theme will be cached for better performance

      ---@type table<string, boolean|{enabled:boolean}>
      plugins = {
        -- enable all plugins when not using lazy.nvim
        -- set to false to manually enable/disable plugins
        all = package.loaded.lazy == nil,
        -- uses your plugin manager to automatically enable needed plugins
        -- currently only lazy.nvim is supported
        auto = true,
        -- add any plugins here that you want to enable
        -- for all possible plugins, see:
        --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
        -- telescope = true,
      },

    },
  }
}
