local M = {}

M.plugins = {
	"folke/lazydev.nvim",
	"bilal2453/luvit-meta",
	"j-hui/fidget.nvim",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
			map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			-- Find references for the word under your cursor.
			map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			-- Jump to the implementation of the word under your cursor.
			map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			-- Jump to the type of the word under your cursor.
			map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
			-- Fuzzy find all the symbols in your current document.
			map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
			-- Fuzzy find all the symbols in your current workspace.
			map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
			-- Rename the variable under your cursor.
			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
			-- Execute a code action, usually your cursor needs to be on top of an error
			-- or a suggestion from your LSP for this to activate.
			map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
			--  Jump to declaration
			map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

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
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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
		solidity_ls_nomicfoundation = {
			includePath = "lib",
		},
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

	require("mason-lspconfig").setup()

	for name, server in pairs(servers) do
		server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end
end

return M
