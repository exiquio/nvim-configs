local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "lewis6991/gitsigns.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  })
end

return M
