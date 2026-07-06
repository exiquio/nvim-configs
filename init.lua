-- [[ vim.loader ]]
vim.loader.enable()

-- [[ GLOBALS ]]

-- Leader key
-- WARNING: Required before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd fonts - Must be installed on host
vim.g.have_nerd_font = true

-- [[ CONFIGURATIONS ]]

require("config.options")
require("config.keymaps")
require("config.autocommands")

-- [[ PLUGINS ]]
-- Using Neovim's native package manager (pack)
local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

local function bootstrap_pack(plugins_list)
	local github_prefix = "https://github.com/"
	for _, plugin in ipairs(plugins_list) do
		local repo, name, url
		if type(plugin) == "string" then
			repo = plugin
			name = plugin:match(".*/(.*)")
			url = github_prefix .. repo .. ".git"
		elseif type(plugin) == "table" then
			repo = plugin[1]
			name = plugin.name or repo:match(".*/(.*)")
			url = plugin.url or (github_prefix .. repo .. ".git")
		end

		local install_path = pack_path .. "/" .. name
		if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
			vim.api.nvim_echo({ { "Cloning " .. (repo or name) .. "...", "Type" } }, true, {})
			vim.fn.system({
				"git",
				"clone",
				"--filter=blob:none",
				url,
				install_path,
			})
		end
		-- Load the plugin instantly into Neovim's runtimepath
		vim.opt.runtimepath:prepend(install_path)
	end
end

-- Load dynamically discovered plugin configuration definitions
local custom_plugins = require("custom.plugins")

-- Clone plugins and inject into runtimepath
bootstrap_pack(custom_plugins.plugins)

-- Automatically clean up plugins that are no longer in the configuration list
local function cleanup_unused_plugins(plugins_list)
	local active_names = {}
	for _, plugin in ipairs(plugins_list) do
		local name
		if type(plugin) == "string" then
			name = plugin:match(".*/(.*)")
		elseif type(plugin) == "table" then
			name = plugin.name or plugin[1]:match(".*/(.*)")
		end
		if name then
			active_names[name] = true
		end
	end

	local handle = vim.uv.fs_scandir(pack_path)
	if handle then
		while true do
			local name, fs_type = vim.uv.fs_scandir_next(handle)
			if not name then
				break
			end
			if fs_type == "directory" and not active_names[name] then
				local dir_to_delete = pack_path .. "/" .. name
				vim.api.nvim_echo({ { "Removing unused plugin: " .. name .. "\n", "WarningMsg" } }, true, {})
				vim.fn.delete(dir_to_delete, "rf")
			end
		end
	end
end

cleanup_unused_plugins(custom_plugins.plugins)

-- Execute each plugin's setup config
for _, config_fn in ipairs(custom_plugins.configs) do
	local ok, err = pcall(config_fn)
	if not ok then
		vim.notify("Error configuring plugin: " .. tostring(err), vim.log.levels.ERROR)
	end
end
