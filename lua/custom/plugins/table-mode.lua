local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "dhruvasagar/vim-table-mode",
}

-- Configuration to run after packages are cloned
M.config = function()
  vim.g.table_mode_corner = "|"

  -- Auto-enable table-mode in markdown files
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TableModeMarkdown", { clear = true }),
    pattern = "markdown",
    callback = function()
      vim.cmd("TableModeEnable")
    end,
  })
end

return M
