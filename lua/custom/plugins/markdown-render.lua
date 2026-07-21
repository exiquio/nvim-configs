local M = {}

-- Plugins/dependencies to clone
M.plugins = {
  "MeanderingProgrammer/render-markdown.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
  require("render-markdown").setup({
    -- Disable heading icons if you want a cleaner look (set true to enable)
    heading = {
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎰 ", "󰎳 " },
      sign = false,
    },
    -- Style code blocks with a background
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    -- Style inline code
    dash = { width = "full" },
    bullet = { right_pad = 1 },
    checkbox = {
      enabled = true,
      -- Render unchecked boxes as clickable in normal mode
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
    },
    link = { enabled = true },
    -- Not needed for prose documentation
    latex = { enabled = false },
  })

  -- Toggle render-markdown on/off
  vim.keymap.set("n", "<leader>mr", function()
    vim.cmd("RenderMarkdown toggle")
  end, { desc = "[M]arkdown [R]ender Toggle" })
end

return M
