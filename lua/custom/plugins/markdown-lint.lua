local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "mfussenegger/nvim-lint",
}

-- Configuration to run after packages are cloned
M.config = function()
  local lint = require("lint")

  lint.linters_by_ft = {
    markdown = { "markdownlint-cli2" },
  }

  -- Lint on entering buffer, after write, and after leaving insert
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    desc = "Run linter on buffer",
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
