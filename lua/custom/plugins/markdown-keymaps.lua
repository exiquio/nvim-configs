local M = {}

-- No plugins to clone — just keymaps

-- Helper: wrap text in visual or normal mode
local function wrap(open, close)
  return function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "v" or mode == "V" or mode == "\22" then
      vim.cmd("normal! y") -- yank selection to unnamed register
      -- Feed: exit visual, reselect, change, type open, paste from register, type close, <Esc>
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
          "<Esc>gvc" .. open .. "<C-r>\"" .. close .. "<Esc>", true, false, true
        ),
        "n", false
      )
    else
      vim.cmd("normal! yiw") -- yank inner word
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
          "ciw" .. open .. "<C-r>\"" .. close .. "<Esc>", true, false, true
        ),
        "n", false
      )
    end
  end
end

-- Helper: set heading level on current line
local function set_heading(level)
  return function()
    local lnum = vim.fn.line(".")
    local text = vim.fn.getline(lnum)
    text = text:gsub("^#+%s*", "") -- strip existing heading markers
    if level > 0 then
      vim.fn.setline(lnum, string.rep("#", level) .. " " .. text)
    else
      vim.fn.setline(lnum, text) -- remove heading
    end
  end
end

M.config = function()
  local opts = { noremap = true, silent = true }

  -- Bold: **text**
  vim.keymap.set({ "n", "v" }, "<leader>mb", wrap("**", "**"), vim.tbl_extend("force", opts, { desc = "[B]old" }))

  -- Italic: *text*
  vim.keymap.set({ "n", "v" }, "<leader>mi", wrap("*", "*"), vim.tbl_extend("force", opts, { desc = "[I]talic" }))

  -- Code: `text`
  vim.keymap.set({ "n", "v" }, "<leader>mc", wrap("`", "`"), vim.tbl_extend("force", opts, { desc = "[C]ode" }))

  -- Strikethrough: ~~text~~
  vim.keymap.set({ "n", "v" }, "<leader>ms", wrap("~~", "~~"), vim.tbl_extend("force", opts, { desc = "[S]trikethrough" }))

  -- Link: inserts [text](url) and selects the url placeholder for you to type
  vim.keymap.set({ "n", "v" }, "<leader>ml", function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "v" or mode == "V" or mode == "\22" then
      vim.cmd("normal! y")
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
          "<Esc>gvc[<C-r>\"](url)<Esc>F(lviw", true, false, true
        ),
        "n", false
      )
    else
      vim.cmd("normal! yiw")
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
          "ciw[<C-r>\"](url)<Esc>F(lviw", true, false, true
        ),
        "n", false
      )
    end
  end, vim.tbl_extend("force", opts, { desc = "[L]ink" }))

  -- Headings: set heading level on current line
  vim.keymap.set("n", "<leader>mh1", set_heading(1), vim.tbl_extend("force", opts, { desc = "Heading 1" }))
  vim.keymap.set("n", "<leader>mh2", set_heading(2), vim.tbl_extend("force", opts, { desc = "Heading 2" }))
  vim.keymap.set("n", "<leader>mh3", set_heading(3), vim.tbl_extend("force", opts, { desc = "Heading 3" }))
  vim.keymap.set("n", "<leader>mh4", set_heading(4), vim.tbl_extend("force", opts, { desc = "Heading 4" }))
  vim.keymap.set("n", "<leader>mh5", set_heading(5), vim.tbl_extend("force", opts, { desc = "Heading 5" }))
  vim.keymap.set("n", "<leader>mh6", set_heading(6), vim.tbl_extend("force", opts, { desc = "Heading 6" }))
  vim.keymap.set("n", "<leader>mh0", set_heading(0), vim.tbl_extend("force", opts, { desc = "Remove Heading" }))
end

return M
