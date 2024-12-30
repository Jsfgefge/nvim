return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
		},
		config = function()
			require('telescope').setup({
				defaults = { --idk if this actually do something
					layout_config = {
						vertical = { width = 1 }
					}
				},
				pickers = {
					find_files = { theme = "dropdown"
					}
				},
				extensions = {
					fzf = {}
				}
			})

			require('telescope').load_extension('fzf')

			vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
			vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)
			vim.keymap.set("n", "<space>en", function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)

			require "config.telescope.multigrep".setup()
		end
	}
}