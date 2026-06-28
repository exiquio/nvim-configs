-- ~/.config/nvim/after/ftplugin/move.lua

-- Capture the exact ID of the Move file being opened right now
local bufnr = vim.api.nvim_get_current_buf()

-- 1. Tab, Indentation, and Guardrail Rules
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.colorcolumn = "90"
vim.opt_local.commentstring = "// %s"

-- 2. Define the Custom Bracket Counter
-- (Must be global _G so Neovim's internal C-engine can see it)
if not _G.SuiMoveIndent then
	_G.SuiMoveIndent = function()
		local lnum = vim.v.lnum
		if lnum == 1 then
			return 0
		end
		local prev_lnum = vim.fn.prevnonblank(lnum - 1)
		if prev_lnum == 0 then
			return 0
		end

		local ind = vim.fn.indent(prev_lnum)
		local prev_line = vim.fn.getline(prev_lnum)
		local cur_line = vim.fn.getline(lnum)

		local opens = 0
		for _ in prev_line:gmatch("{") do
			opens = opens + 1
		end
		for _ in prev_line:gmatch("%(") do
			opens = opens + 1
		end
		for _ in prev_line:gmatch("%[") do
			opens = opens + 1
		end
		for _ in prev_line:gmatch("}") do
			opens = opens - 1
		end
		for _ in prev_line:gmatch("%)") do
			opens = opens - 1
		end
		for _ in prev_line:gmatch("%]") do
			opens = opens - 1
		end

		if opens > 0 then
			ind = ind + 4
		end
		if cur_line:match("^%s*}") or cur_line:match("^%s*%)") or cur_line:match("^%s*%]") then
			ind = ind - 4
		end
		return ind
	end
end

-- 3. Wire the custom engine locally and kill the legacy C-engine
vim.opt_local.indentexpr = "v:lua.SuiMoveIndent()"
vim.opt_local.smartindent = false
vim.opt_local.cindent = false
vim.opt_local.autoindent = true

-- 4. The Silent Formatter Execution
local format_move = function()
	-- Double check we are still actually inside the Move buffer before running
	if vim.api.nvim_get_current_buf() == bufnr then
		local view = vim.fn.winsaveview()
		vim.cmd("silent! normal! gg=G")
		vim.fn.winrestview(view)
	end
end

-- 5. Lock <leader>f strictly to this buffer
vim.keymap.set("n", "<leader>f", format_move, {
	buffer = bufnr,
	desc = "[F]ormat Move Buffer",
})

-- 6. Lock the Auto-Save hook strictly to this buffer
-- We append the bufnr to the group name so every Move file gets its own isolated save hook
local group = vim.api.nvim_create_augroup("SuiMoveFormat_" .. bufnr, { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	buffer = bufnr, -- CRITICAL: This guarantees the save hook never touches other files
	callback = format_move,
})
