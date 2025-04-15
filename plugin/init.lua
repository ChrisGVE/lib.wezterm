local wezterm = require("wezterm") --[[@as Wezterm]]

---@type { setup: fun(opts: table)}
local dev = wezterm.plugin.require("https://github.com/chrisgve/dev.wezterm")

local M = {}

local function init()
	local opts = {
		keywords = { "http", "github", "chrisgve", "lib", "wezterm" },
		auto = true,
	}
	dev.setup(opts) -- Use local underscore to explicitly mark as ignored return value
end

init()

M.table = require("lib.table")
M.env = require("lib.env")
M.file_io = require("lib.file_io")
M.math = require("lib.math")
-- M.string = require("lib.string")
M.wezterm = require("lib.wezterm")
M.logger = require("lib.logger")

return M
