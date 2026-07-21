local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "folke/todo-comments.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("todo-comments").setup({
    signs = true,
    keywords = {
      ["audit-info"] = { icon = " ", color = "hint" },
      ["audit-ok"] = { icon = " ", color = "test" },
      ["audit-warn"] = { icon = " ", color = "warning" },
      ["audit-fail"] = { icon = " ", color = "error" },
      ["audit-fix"] = { icon = " ", color = "error" },
      ["audit-todo"] = { icon = " ", color = "info" },
      ["audit-note"] = { icon = " ", color = "hint" },
      ["audit-question"] = { icon = " ", color = "hint" },
    },
  })
end

return M
