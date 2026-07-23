-- Auto-reload: detect external file changes and reload buffers
-- Uses native Neovim APIs only — no plugins required

local M = {}

-- Configuration
local config = {
  interval = 2500,         -- Timer interval in ms (2.5s)
  excluded_modes = {       -- Modes where checktime is skipped
    c = true,              -- Command-line mode
    t = true,              -- Terminal mode
    i = true,              -- Insert mode
    R = true,              -- Replace mode
  },
}

-- Guard: returns true if checktime is safe to run
local function can_checktime()
  local m = vim.fn.mode(true):sub(1, 1)
  return not config.excluded_modes[m]
end

-- Timer handle (module-level for idempotent re-source)
local timer = nil

-- Idempotent timer start
local function start_timer()
  if timer then
    timer:stop()
    timer:close()
  end
  timer = vim.uv.new_timer()
  timer:start(
    config.interval,
    config.interval,
    vim.schedule_wrap(function()
      if can_checktime() then
        vim.cmd("checktime")
      end
    end)
  )
end

-- Setup: called once on init
function M.setup()
  local group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

  -- Enable autoread globally
  vim.o.autoread = true

  -- Event-driven checktime
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = group,
    callback = function()
      if can_checktime() then
        vim.cmd("checktime")
      end
    end,
  })

  -- Passive background timer
  start_timer()

  -- Cleanup on exit
  vim.api.nvim_create_autocmd("VimLeave", {
    group = group,
    callback = function()
      if timer then
        timer:stop()
        timer:close()
        timer = nil
      end
    end,
  })

  vim.notify("Auto-reload enabled (timer: " .. config.interval .. "ms)", vim.log.levels.INFO)
end

return M
