-- Options
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- Indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- Enable line numbers
vim.opt.number = true
-- Enable mouse mode
vim.opt.mouse = "a"
-- Disabled showmode because our status line makes it redundant
vim.opt.showmode = false
-- Sync OS and Neovim clipboads
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Enable sign column
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions
vim.opt.inccommand = "split"
-- Show cursor line
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
