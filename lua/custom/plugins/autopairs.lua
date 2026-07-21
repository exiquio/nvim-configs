local M = {}

M.plugins = {
  "windwp/nvim-autopairs",
}

M.config = function()
  require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim", "lspinfo" },
    check_ts = true, -- use Treesitter for smarter pair detection
    map_cr = true, -- <CR> auto-indents between pairs
    map_bs = true, -- <BS> deletes empty pairs
  })
end

return M
