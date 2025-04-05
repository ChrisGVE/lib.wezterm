local wezterm = require("wezterm") --[[@as Wezterm]] --- this type cast invokes the LSP module for Wezterm

local M = {}

M.is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
M.is_mac = (wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin")
M.separator = M.is_windows and "\\" or "/"

-- compute a hash key from a string
---@param str string
---@return string hashkey
function M.hash(str)
	local hashkey = 5381
	for i = 1, #str do
		hashkey = ((hashkey << 5) + hashkey) + string.byte(str, i)
		hashkey = hashkey & 0xFFFFFFFF
	end
	return string.format("%08x", hashkey)
end

return M
