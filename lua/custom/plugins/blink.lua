local M = {}

M.plugins = {
  { "saghen/blink.cmp", tag = "v1.3.0" }, -- pinning a tag allows auto-downloading of pre-built binaries
  "l3mon4d3/luasnip",
}

M.config = function()
  require("luasnip").setup({})

  require("blink.cmp").setup({
    keymap = {
      preset = "default",
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "todo-keywords" },
      providers = {
        ["todo-keywords"] = {
          name = "todo-keywords",
          module = "custom.blink.todo-keywords",
        },
      },
    },

    snippets = { preset = "luasnip" },

    fuzzy = { implementation = "lua" },

    signature = { enabled = true },
  })
end

return M
