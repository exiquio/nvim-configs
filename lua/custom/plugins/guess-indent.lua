local M = {}

M.plugins = {
	"NMAC427/guess-indent.nvim",
}

M.config = function()
	require("guess-indent").setup({})
end

return M
