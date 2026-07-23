-- A custom blink.cmp source that provides todo-comment keywords
-- as completion items. Built-in keywords (TODO, FIXME, etc.) stay
-- as-is; custom audit keywords use the @audit-* prefix.
--
-- Keep the audit-* list in sync with the keywords in todo-comments.lua
local keywords = {
  -- Built-in todo-comments (primary + common aliases)
  { label = "TODO", insertText = "TODO", kind = 14 },
  { label = "FIX", insertText = "FIX", kind = 14 },
  { label = "FIXME", insertText = "FIXME", kind = 14 },
  { label = "BUG", insertText = "BUG", kind = 14 },
  { label = "ISSUE", insertText = "ISSUE", kind = 14 },
  { label = "HACK", insertText = "HACK", kind = 14 },
  { label = "WARN", insertText = "WARN", kind = 14 },
  { label = "WARNING", insertText = "WARNING", kind = 14 },
  { label = "XXX", insertText = "XXX", kind = 14 },
  { label = "PERF", insertText = "PERF", kind = 14 },
  { label = "NOTE", insertText = "NOTE", kind = 14 },
  { label = "INFO", insertText = "INFO", kind = 14 },
  { label = "TEST", insertText = "TEST", kind = 14 },
  -- Custom audit keywords
  { label = "@audit-info", insertText = "@audit-info", kind = 14 },
  { label = "@audit-ok", insertText = "@audit-ok", kind = 14 },
  { label = "@audit-warn", insertText = "@audit-warn", kind = 14 },
  { label = "@audit-fail", insertText = "@audit-fail", kind = 14 },
  { label = "@audit-fix", insertText = "@audit-fix", kind = 14 },
  { label = "@audit-todo", insertText = "@audit-todo", kind = 14 },
  { label = "@audit-note", insertText = "@audit-note", kind = 14 },
  { label = "@audit-question", insertText = "@audit-question", kind = 14 },
}

local source = {}
source.__index = source

--- Constructor required by blink.cmp's provider interface
function source.new()
  return setmetatable({}, source)
end

--- Returns true if completions should be shown:
--- - Always true for non-Solidity files (unchanged behavior)
--- - True for Solidity files only when cursor is inside a comment (// or /* */)
local function is_in_comment()
  local ft = vim.bo.filetype
  if ft ~= "solidity" then
    return true -- not solidity: show completions unconditionally (unchanged behavior)
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]
  local col = cursor[2]
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  if not line then return false end

  local before_cursor = line:sub(1, col)

  -- Check single-line comment: line starts with // after optional whitespace
  if before_cursor:match("^%s*//") then
    return true
  end

  -- Check if we're inside a block comment on the current line
  local block_start = before_cursor:find("/%*")
  if block_start then
    local after_start = before_cursor:sub(block_start + 2)
    local block_end = after_start:find("%*/")
    if not block_end then
      return true -- inside /* ... */
    end
  end

  -- Scan backward from current line looking for unclosed /*
  local inside_block = false
  for r = row, 1, -1 do
    local l = vim.api.nvim_buf_get_lines(0, r - 1, r, false)[1]
    if not l then break end
    local search_line = (r == row) and before_cursor or l
    -- Remove closed blocks: */ ... /*
    local cleaned = search_line:gsub("%*/.-/%*", "")
    -- Check for unclosed /*
    local open_pos = cleaned:find("/%*")
    local close_pos = cleaned:find("%*/")
    if open_pos and (not close_pos or open_pos > close_pos) then
      inside_block = true
      break
    end
    if close_pos and not open_pos then
      inside_block = false
      break
    end
  end

  return inside_block
end

--- blink.cmp calls this whenever completions are needed
function source:get_completions(_, callback)
  if not is_in_comment() then
    callback({
      items = {},
      is_incomplete_forward = false,
      is_incomplete_backward = false,
    })
    return
  end

  callback({
    items = keywords,
    is_incomplete_forward = false,
    is_incomplete_backward = false,
  })
end

--- Characters that trigger this source (ensures completions refresh after typing
--- these specific characters, especially useful after typing @ or - ).
function source:get_trigger_characters()
  return { "@", "-" }
end

return source
