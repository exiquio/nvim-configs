-- [[ GLOBALS ]]

-- Leader key
-- WARNING: Required before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd fonts - Must be installed on host
vim.g.have_nerd_font = true

-- [[ CONFIGURATIONS ]]

require("config.options")
require("config.keymaps")
require("config.autocommands")

-- [[ PLUGIN INSTALLATION]]
-- Using Lazy.nvim
-- Run `:Lazy` for plugin status

require("lazy").setup({
	{ import = "custom.plugins" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- [[ MISC. ]]

-- Override the default colorcolumn to a subtle Dracula Pro dark purple-gray
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#5c4ade" })
