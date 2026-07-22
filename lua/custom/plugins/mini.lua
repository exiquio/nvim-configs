local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "echasnovski/mini.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  -- Better Around/Inside textobjects
  require("mini.ai").setup({ n_lines = 500 })

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  require("mini.surround").setup()

  -- Visual indent guides and scope highlighting
  require("mini.indentscope").setup()

  -- Central icon provider for all plugins
  require("mini.icons").setup()

  -- Simple and easy statusline.
  local statusline = require("mini.statusline")
  -- set use_icons to true if you have a Nerd Font
  statusline.setup({ use_icons = vim.g.have_nerd_font })

  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return "%2l:%-2v"
  end
end

return M
