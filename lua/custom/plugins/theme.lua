local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  { "dracula-pro/vim", url = "git@github.com:dracula-pro/vim.git", name = "dracula_pro" },
}

-- Configuration to run after packages are cloned
M.config = function()
  -- Must be set before colorscheme loads
  vim.g.dracula_colorterm = 0

  vim.cmd.colorscheme("dracula_pro")

  -- Use an underline for Normal/Visual mode, and a vertical bar for Insert mode
  vim.api.nvim_set_hl(0, "DraculaBrightCursor", { bg = "#50fa7b", fg = "#22212c" })
  vim.opt.guicursor =
    "n-v-c:hor20-DraculaBrightCursor-blinkwait300-blinkon300-blinkoff300,i-ci-ve:ver25-DraculaBrightCursor-blinkwait300-blinkon300-blinkoff300,r-cr:hor20-DraculaBrightCursor-blinkwait300-blinkon300-blinkoff300,o:hor50-DraculaBrightCursor"

  -- Override the default colorcolumn to a subtle Dracula Pro dark purple-gray
  vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#5c4ade" })
end

return M
