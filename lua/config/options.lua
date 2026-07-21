-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = "a"
-- showmode is redundant with statusline
vim.opt.showmode = false
-- Sync OS and Neovim clipboards
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
-- Faster CursorHold and swapfile writes
vim.opt.updatetime = 250
-- Faster which-key popup
vim.opt.timeoutlen = 300
-- Open splits to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Live preview of substitutions
vim.opt.inccommand = "split"
vim.opt.cursorline = true
-- Keep 10 lines of context around cursor
vim.opt.scrolloff = 10
-- Use harper_ls instead of built-in spellcheck
vim.opt.spell = false
