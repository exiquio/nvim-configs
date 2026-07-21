-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Show colorcolumn when any line exceeds 120 chars
local limit = 120
local group = vim.api.nvim_create_augroup("DynamicColorColumn", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI" }, {
	group = group,
	pattern = "*",
	callback = function()
		local max_len = 0
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

		for _, line in ipairs(lines) do
			if #line > max_len then
				max_len = #line
			end
		end

		if max_len > limit then
			vim.opt_local.colorcolumn = tostring(limit)
		else
			vim.opt_local.colorcolumn = ""
		end
	end,
})

-- Start Treesitter highlighting/indentation when parser is available
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype) or vim.bo[ev.buf].filetype
		local ok = pcall(vim.treesitter.start, ev.buf, lang)
		if ok then
			if vim.bo[ev.buf].filetype == "solidity" then
				vim.bo[ev.buf].shiftwidth = 4
				vim.bo[ev.buf].tabstop = 4
				vim.bo[ev.buf].expandtab = true
				vim.bo[ev.buf].smartindent = true
			else
				vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end
		end
	end,
})
