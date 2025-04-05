local wezterm = require("wezterm") --[[@as Wezterm]] --- this type cast invokes the LSP module for Wezterm
local dev = wezterm.plugin.require("https://github.com/chrisgve/dev.wezterm")

local M = {}

local function init()
	local opts = {
		keywords = { "utils", "wezterm" },
		auto = true,
	}
	_ = dev.setup(opts)
end

-- Compute a hash key from a string using the DJB2 algorithm (Dan Bernstein)
-- The DJB2 is a simple and fast non-cryptographic hash function
-- Formula: hash = ((hash << 5) + hash) + c = hash * 33 + c
-- Starting value 5381 is a prime number chosen by Dan Bernstein for the algorithm
---@param str string Input string to hash
---@return string hashkey Hexadecimal representation of the hash
function M.hash(str)
	local hashkey = 5381
	for i = 1, #str do
		hashkey = ((hashkey << 5) + hashkey) + string.byte(str, i)
		hashkey = hashkey & 0xFFFFFFFF
	end
	return string.format("%08x", hashkey)
end

init()

return M
