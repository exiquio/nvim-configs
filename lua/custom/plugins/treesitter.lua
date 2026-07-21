local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "nvim-treesitter/nvim-treesitter",
}

-- Configuration to run after packages are cloned
M.config = function()
  local ts = require("nvim-treesitter")
  ts.setup()

  -- Safe automatic installation of missing parsers
  local parsers = {
    "diff",
    "eex", -- Required for Elixir
    "elixir",
    "fish",
    "heex", -- Required for Elixir
    "html",
    "javascript",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "solidity",
    "yaml",
  }

  local installed = ts.get_installed()
  local to_install = {}
  for _, p in ipairs(parsers) do
if not vim.tbl_contains(installed, p) then
      table.insert(to_install, p)
    end
  end

  if #to_install > 0 then
    ts.install(to_install)
  end
end

return M
