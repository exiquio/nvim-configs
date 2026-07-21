local M = {}

local plugins = {}
local configs = {}

local scan_dir = vim.fn.stdpath("config") .. "/lua/custom/plugins"
local handle = vim.uv.fs_scandir(scan_dir)

if handle then
  while true do
    local name, fs_type = vim.uv.fs_scandir_next(handle)
    if not name then
      break
    end
    if (fs_type == "file" or fs_type == "link") and name ~= "init.lua" and name:match("%.lua$") then
      local module_name = "custom.plugins." .. name:gsub("%.lua$", "")
      local ok, plugin_module = pcall(require, module_name)
      if ok and type(plugin_module) == "table" then
        -- Gather package sources
        if plugin_module.plugins then
          for _, p in ipairs(plugin_module.plugins) do
            table.insert(plugins, p)
          end
        end
        -- Gather startup configs
        if plugin_module.config then
          table.insert(configs, plugin_module.config)
        end
      else
        vim.notify(
          "Failed to load plugin module: " .. module_name .. "\nError: " .. tostring(plugin_module),
          vim.log.levels.ERROR
        )
      end
    end
  end
end

M.plugins = plugins
M.configs = configs

return M
