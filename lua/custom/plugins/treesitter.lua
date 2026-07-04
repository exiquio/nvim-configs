return {
	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		--branch = "master",
		brach = "main",
		build = ":TSUpdate",
		config = function()
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
		end,
	},
}
