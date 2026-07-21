local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "bullets-vim/bullets.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("bullets").setup({
    -- Enable for all built-in filetypes + your custom ones
    filetypes = {
      "markdown",
      "text",
      "gitcommit",
    },
    -- Renumber ordered lists when inserting/deleting items
    renumber_ordered = true,
    -- When hitting Enter on an empty bullet, delete it and exit list
    delete_empty_last_bullet = true,
    -- Nest checkboxes under parent checkbox when indenting
    nest_with_checkboxes = true,
  })
end

return M
