local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "stevearc/aerial.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("aerial").setup({
    -- Use treesitter (no LSP needed for markdown)
    backends = { "treesitter", "lsp", "markdown" },

    -- Show on the right side
    layout = {
      default_direction = "right",
      placement = "edge",
      min_width = 28,
    },

    -- Show line numbers alongside headings
    show_guides = true,

    -- Auto-open when entering a buffer with symbols
    attach_mode = "global",

    -- Filter to only show files where we actually have symbols
    filter_kind = false,

    -- Nerd Font icons for heading levels
    icons = {
      ["h1"] = { icon = "󰎤 ", hl = "AerialH1Icon" },
      ["h2"] = { icon = "󰎧 ", hl = "AerialH2Icon" },
      ["h3"] = { icon = "󰎪 ", hl = "AerialH3Icon" },
      ["h4"] = { icon = "󰎭 ", hl = "AerialH4Icon" },
      ["h5"] = { icon = "󰎰 ", hl = "AerialH5Icon" },
      ["h6"] = { icon = "󰎳 ", hl = "AerialH6Icon" },
    },
  })

  -- Toggle the outline sidebar
  vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<CR>", { desc = "[O]utline Toggle" })
end

return M
