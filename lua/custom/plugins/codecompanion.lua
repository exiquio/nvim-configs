local M = {}

-- Plugins/dependencies to clone
M.plugins = {
	"olimorris/codecompanion.nvim",
}

-- Auto-detect: inside the web3 VM → route through host's LiteLLM proxy
if vim.fn.hostname() == "web3" then
	M.vm = true
end

-- Configuration to run after packages are cloned
M.config = function()
	if M.vm then
		-- On the VM: talk to the host's LiteLLM proxy at 192.168.122.1:4000
		require("codecompanion").setup({
			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://192.168.122.1:4000",
							api_key = "sk-dummy-key-does-not-matter",
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "deepseek/deepseek-v4-flash",
							},
							temperature = {
								default = 0,
							},
							max_tokens = {
								default = 8192,
							},
							top_p = {
								default = 1,
							},
						},
					})
				end,
			},
			strategies = {
				chat = { adapter = { name = "deepseek", model = "deepseek/deepseek-v4-flash" } },
				inline = { adapter = { name = "deepseek", model = "deepseek/deepseek-v4-flash" } },
				agent = { adapter = { name = "deepseek", model = "deepseek/deepseek-v4-pro" } },
			},
		})
	else
		-- On the host: talk directly to DeepSeek's API
		require("codecompanion").setup({
			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						env = {
							api_key = "DEEPSEEK_API_KEY",
						},
						schema = {
							model = {
								default = "deepseek-v4-flash",
							},
							temperature = {
								default = 0,
							},
							max_tokens = {
								default = 8192,
							},
							top_p = {
								default = 1,
							},
						},
					})
				end,
			},
			strategies = {
				chat = { adapter = { name = "deepseek", model = "deepseek-v4-pro" } },
				inline = { adapter = { name = "deepseek", model = "deepseek-v4-flash" } },
				agent = { adapter = { name = "deepseek", model = "deepseek-v4-pro" } },
			},
		})
	end

	-- Spinner: show an animated indicator while CodeCompanion is thinking
	vim.api.nvim_set_hl(0, "DraculaPink", { fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "DraculaCyan", { fg = "#8be9fd", bold = true })
	vim.api.nvim_set_hl(0, "DraculaGreen", { fg = "#50fa7b", bold = true })

	local spinner_timer = nil
	local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
	local spinner_idx = 1

	local function start_spinner()
		if spinner_timer then
			return
		end
		spinner_timer = vim.uv.new_timer()
		spinner_timer:start(
			0,
			100,
			vim.schedule_wrap(function()
				vim.api.nvim_echo({
					{ "󰚩 ", "DraculaPink" },
					{ "CodeCompanion is thinking... ", "Normal" },
					{ spinner_frames[spinner_idx], "DraculaCyan" },
				}, false, {})
				spinner_idx = (spinner_idx % #spinner_frames) + 1
			end)
		)
	end

	local function stop_spinner()
		if spinner_timer then
			spinner_timer:stop()
			spinner_timer:close()
			spinner_timer = nil
			vim.api.nvim_echo({
				{ "󰚩 ", "DraculaGreen" },
				{ "CodeCompanion: Response finished", "DraculaGreen" },
			}, false, {})
			vim.defer_fn(function()
				vim.api.nvim_echo({ { "", "" } }, false, {})
			end, 2000)
		end
	end

	local cc_group = vim.api.nvim_create_augroup("CodeCompanionFeedback", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "CodeCompanionRequestStarted",
		group = cc_group,
		callback = start_spinner,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "CodeCompanionRequestFinished",
		group = cc_group,
		callback = stop_spinner,
	})
end

return M
