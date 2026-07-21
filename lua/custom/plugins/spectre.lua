local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "windwp/nvim-spectre",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("spectre").setup({
    default = {
      find = {
        cmd = "rg",
        options = { "ignore-case", "hidden" },
      },
      replace = {
        cmd = "sd",
      },
    },
  })

vim.keymap.set("n", "<leader>r", function()
    require("spectre").open()
  end, { desc = "Search & [R]eplace" })
end

return M
