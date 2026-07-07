local M = {}

M.plugins = {
	"windwp/nvim-autopairs",
}

M.config = function()
	-- https://github.com/windwp/nvim-autopairs
	require("nvim-autopairs").setup({
		-- Disable autopairs in certain filetypes
		disable_filetype = { "TelescopePrompt", "vim", "lspinfo" },
		-- Enable check for rule trees (better handling with treesitter)
		check_ts = true,
		-- Map of pairs to activate
		-- (default is all standard pairs: (), [], {}, '', "")
		-- You can add custom pairs or disable specific ones
		map_cr = true, -- Map <CR> to smart auto-indent after pairs
		map_bs = true, -- Map <BS> to delete the pair if empty
	})
end

return M
