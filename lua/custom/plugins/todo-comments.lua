local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"folke/todo-comments.nvim",
	"nvim-lua/plenary.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
	require("todo-comments").setup({
		signs = false,
	})
end

return M
