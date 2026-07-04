return {
	-- CodeCompanion.nvim AI
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = {
								api_key = "GEMINI_API_KEY",
							},
							schema = {
								model = {
									default = "gemini-3.5-flash",
								},
								temperature = {
									default = 0.1, -- Keeps logic precise and deterministic for auditing
								},
								max_output_tokens = {
									default = 4096, -- Ensures ample headroom for multi-file refactors
								},
							},
						})
					end,
				},
				strategies = {
					chat = { adapter = { name = "gemini", model = "gemini-3.5-flash" } },
					inline = { adapter = { name = "gemini", model = "gemini-3.5-flash" } },
					agent = { adapter = { name = "gemini", model = "gemini-3.5-flash" } },
				},
			})
		end,
	},
}
