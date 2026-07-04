local M = {}

M.plugins = {
  "folke/lazydev.nvim",
  "bilal2453/luvit-meta",
  "j-hui/fidget.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "hrsh7th/cmp-nvim-lsp", -- Required for require("cmp_nvim_lsp")
}

M.config = function()
  -- 1. Setup lazydev (Lua dev enhancements)
  require("lazydev").setup({
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  })

  -- 2. Setup fidget (LSP status updates)
  require("fidget").setup({})

  -- 3. LSP Attach autocommands and mappings
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end

      -- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      -- Find references for the word under your cursor.
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      -- Jump to the implementation of the word under your cursor.
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      -- Jump to the type of the word under your cursor.
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      -- Fuzzy find all the symbols in your current document.
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      -- Fuzzy find all the symbols in your current workspace.
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
      -- Rename the variable under your cursor.
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      --  Jump to declaration
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      -- Highlight references under cursor
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
          end,
        })
      end

      -- Toggle Inlay Hints
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        map("<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })

  -- 4. Capabilities setup
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  -- Enable language servers
  local servers = {
    expert = {},
    fish_lsp = {},
    vtsls = {},
    lua_ls = {
      capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    },
    basedpyright = {},
    solidity_ls = {},
    harper_ls = {},
  }

  -- 5. Install servers and tools with Mason
  require("mason").setup()

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    "eslint_d",
    "stylua",
    "mdformat",
    "ruff",
    "expert",
  })
  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  require("mason-lspconfig").setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  })
end

return M
