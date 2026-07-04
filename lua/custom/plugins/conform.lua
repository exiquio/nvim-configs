local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"stevearc/conform.nvim",
}

-- Configuration to run after packages are cloned
M.config = function()
	-- Keymaps
	vim.keymap.set({ "n", "v" }, "<leader>f", function()
		require("conform").format({ async = true, lsp_fallback = true })
	end, { desc = "[F]ormat buffer" })

	-- Setup Conform
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
			local disable_filetypes = { c = true, cpp = true }
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			elixir = { "mix" },
			heex = { "mix" },
			javascript = { "eslint_d" },
			lua = { "stylua" },
			markdown = { "mdformat" },
			python = { "ruff" },
			solidity = { "forge_fmt" },
		},
	})
end

return M
