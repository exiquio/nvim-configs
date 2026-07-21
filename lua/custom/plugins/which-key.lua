local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "folke/which-key.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("which-key").setup()

  require("which-key").add({
    { "<leader>a", group = "[A]I" },
    { "<leader>e", group = "[E]xplore" },
    { "<leader>m", group = "[M]arkdown" },
    { "<leader>o", group = "[O]utline" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>t", group = "[T]oggle" },
  })
end

return M
