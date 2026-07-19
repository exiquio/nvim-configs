-- A custom blink.cmp source that provides AUDIT_* keywords
-- as completion items. These are primarily useful in comments
-- but are available everywhere (false positives are minimal since
-- AUDIT_ is unlikely to match real code identifiers).
--
-- Keep this list in sync with the keywords in todo-comments.lua
local keywords = {
	{ label = "AUDIT", insertText = "AUDIT", kind = 14 },
	{ label = "AUDIT_INFO", insertText = "AUDIT_INFO", kind = 14 },
	{ label = "AUDIT_OK", insertText = "AUDIT_OK", kind = 14 },
	{ label = "AUDIT_WARN", insertText = "AUDIT_WARN", kind = 14 },
	{ label = "AUDIT_FAIL", insertText = "AUDIT_FAIL", kind = 14 },
	{ label = "AUDIT_FIX", insertText = "AUDIT_FIX", kind = 14 },
	{ label = "AUDIT_TODO", insertText = "AUDIT_TODO", kind = 14 },
	{ label = "AUDIT_NOTE", insertText = "AUDIT_NOTE", kind = 14 },
	{ label = "AUDIT_QUESTION", insertText = "AUDIT_QUESTION", kind = 14 },
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
--- these specific characters, especially useful after typing AUDIT_).
function source:get_trigger_characters()
	return { "_" }
end

return source
