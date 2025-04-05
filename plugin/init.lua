local wezterm = require("wezterm") --[[@as Wezterm]] --- this type cast invokes the LSP module for Wezterm
local dev = wezterm.plugin.require("https://github.com/chrisgve/dev.wezterm")

local M = {}

local function init()
	local opts = {
		keywords = { "utils", "wezterm" },
		auto = true,
	}
	local _ = dev.setup(opts)  -- Use local underscore to explicitly mark as ignored return value
end

init()

return M
