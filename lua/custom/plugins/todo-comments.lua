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
		keywords = {
			AUDIT = { icon = " ", color = "info" },
			AUDIT_INFO = { icon = " ", color = "hint" },
			AUDIT_OK = { icon = " ", color = "test" },
			AUDIT_WARN = { icon = " ", color = "warning" },
			AUDIT_FAIL = { icon = " ", color = "error" },
			AUDIT_FIX = { icon = " ", color = "error" },
			AUDIT_TODO = { icon = " ", color = "info" },
			AUDIT_NOTE = { icon = " ", color = "hint" },
			AUDIT_QUESTION = { icon = " ", color = "hint" },
		},
	})
end

return M
