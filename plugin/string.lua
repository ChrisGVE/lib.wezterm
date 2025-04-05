local utils = require("plugin.utils")
local M = {}

local string_utils = {}

-- compute a hash key from a string
---@param str string
---@return string hashkey
function string_utils.hash(str)
	local hashkey = 5381
	for i = 1, #str do
		hashkey = ((hashkey << 5) + hashkey) + string.byte(str, i)
		hashkey = hashkey & 0xFFFFFFFF
	end
	return string.format("%08x", hashkey)
end

-- generate a hash from an array
---@param arr table
---@return string hashkey
function string_utils.array_hash(arr)
	local str = table.concat(arr, ",")
	return utils.hash(str)
end

-- Helper function to remove formatting esc sequences in the string
---@param str string
---@return string
function string_utils.strip_format_esc_seq(str)
	local clean_str, _ = str:gsub(string.char(27) .. "%[[^m]*m", "")
	return clean_str
end

-- replace the center of a string with another string
---@param str string string to be modified
---@param len number length to be removed from the middle of str
---@param pad string string that must be inserted in place of the missing part of str
function string_utils.replace_center(str, len, pad)
	local mid = #str // 2
	local start = mid - (len // 2)
	return str:sub(1, start) .. pad .. str:sub(start + len + 1)
end

-- returns the length of a utf8 string
---@param str string
---@return number
function string_utils.utf8len(str)
	local _, len = str:gsub("[%z\1-\127\194-\244][\128-\191]*", "")
	return len
end

-- Add the string functions to the built-in string table
for name, func in pairs(string_utils) do
	string[name] = func
end

-- The string metatable is protected in recent Lua versions
-- We need to use debug library to access it (if available)
local ok, string_mt = pcall(function()
	return debug.getmetatable("")
end)
if ok and string_mt then
	-- If we successfully got the metatable, ensure it has __index pointing to string table
	if not string_mt.__index then
		string_mt.__index = string
	end
else
	-- In environments where debug isn't available or metatable is inaccessible
	-- This is an alternative approach but may not work in all Lua environments
	local mt = {}
	mt.__index = string
	-- This attempt may fail in protected environments
	pcall(function()
		setmetatable("", mt)
	end)
end

-- Add functions to the module export table
M.hash = string_utils.hash
M.array_hash = string_utils.array_hash

return M
