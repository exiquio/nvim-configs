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

--- blink.cmp calls this whenever completions are needed
function source:get_completions(_, callback)
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
