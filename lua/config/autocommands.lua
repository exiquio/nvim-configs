-- [[ AUTOCOMMANDS ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Highlight when 120 characers is exceeded.
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

-- Automatically start Treesitter highlighting and indentation when a parser is available
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype) or vim.bo[ev.buf].filetype
		local ok = pcall(vim.treesitter.start, ev.buf, lang)
		if ok then
			vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
		end
	end,
})

-- CodeCompanion indicator

-- Define Dracula Pro highlight colors
vim.api.nvim_set_hl(0, "DraculaPink", { fg = "#ff79c6", bold = true })
vim.api.nvim_set_hl(0, "DraculaCyan", { fg = "#8be9fd", bold = true })
vim.api.nvim_set_hl(0, "DraculaGreen", { fg = "#50fa7b", bold = true })

-- CodeCompanion spinner feedback
local spinner_timer = nil
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_idx = 1

local function start_spinner()
	if spinner_timer then
		return
	end
	spinner_timer = vim.uv.new_timer()
	spinner_timer:start(
		0,
		100,
		vim.schedule_wrap(function()
			vim.api.nvim_echo({
				{ "󰚩 ", "DraculaPink" },
				{ "CodeCompanion is thinking... ", "Normal" },
				{ spinner_frames[spinner_idx], "DraculaCyan" },
			}, false, {})
			spinner_idx = (spinner_idx % #spinner_frames) + 1
		end)
	)
end

local function stop_spinner()
	if spinner_timer then
		spinner_timer:stop()
		spinner_timer:close()
		spinner_timer = nil
		vim.api.nvim_echo({
			{ "󰚩 ", "DraculaGreen" },
			{ "CodeCompanion: Response finished", "DraculaGreen" },
		}, false, {})
		vim.defer_fn(function()
			vim.api.nvim_echo({ { "", "" } }, false, {})
		end, 2000)
	end
end

local cc_group = vim.api.nvim_create_augroup("CodeCompanionFeedback", { clear = true })

vim.api.nvim_create_autocmd("User", {
	pattern = "CodeCompanionRequestStarted",
	group = cc_group,
	callback = start_spinner,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "CodeCompanionRequestFinished",
	group = cc_group,
	callback = stop_spinner,
})
