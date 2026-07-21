local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"folke/which-key.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
	require("which-key").setup()

	require("which-key").add({
		{ "<leader>m", group = "[M]arkdown" },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	})
end

return M
