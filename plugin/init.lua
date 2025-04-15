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

M.table = require("table")
M.env = require("env")
M.file_io = require("file_io")
M.math = require("math")
M.string = require("string")
M.wezterm = require("wezterm")
M.logger = require("logger")

return M
