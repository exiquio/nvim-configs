local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"olimorris/codecompanion.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter",
}

-- Configuration to run after packages are cloned
M.config = function()
	require("codecompanion").setup({
		adapters = {
			deepseek = function()
				return require("codecompanion.adapters").extend("deepseek", {
					env = {
						api_key = "DEEPSEEK_API_KEY",
					},
					schema = {
						model = {
							default = "deepseek-v4-flash",
						},
						temperature = {
							default = 0.1, -- Keeps logic precise and deterministic for auditing
						},
					},
				})
			end,
		},
		strategies = {
			chat = { adapter = { name = "deepseek", model = "deepseek-v4-flash" } },
			inline = { adapter = { name = "deepseek", model = "deepseek-v4-flash" } },
			agent = { adapter = { name = "deepseek", model = "deepseek-v4-flash" } },
		},
	})
end

return M
