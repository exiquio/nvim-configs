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

-- Execute each plugin's setup config
for _, config_fn in ipairs(custom_plugins.configs) do
	local ok, err = pcall(config_fn)
	if not ok then
		vim.notify("Error configuring plugin: " .. tostring(err), vim.log.levels.ERROR)
	end
end
