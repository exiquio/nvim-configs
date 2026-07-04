local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"nvim-treesitter/nvim-treesitter",
}

-- Configuration to run after packages are cloned
M.config = function()
	require("nvim-treesitter").setup()

	require("nvim-treesitter").install({
		"diff",
		"eex", -- Required for Elixir
		"elixir",
		"fish",
		"heex", -- Required for Elixir
		"html",
		"javascript",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"python",
		"solidity",
	})
end

return M
