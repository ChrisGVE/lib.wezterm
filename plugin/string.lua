local init = require("plugin.init")
local M = {}

local string_utils = {}

-- Compute a hash key from a string using the DJB2 algorithm (Dan Bernstein)
-- The DJB2 is a simple and fast non-cryptographic hash function
-- Formula: hash = ((hash << 5) + hash) + c = hash * 33 + c
---@param str string Input string to hash
---@return string hashkey Hexadecimal representation of the hash
function string_utils.hash(str)
	local hashkey = 5381
	for i = 1, #str do
		hashkey = ((hashkey << 5) + hashkey) + string.byte(str, i)
		hashkey = hashkey & 0xFFFFFFFF
	end
	return string.format("%08x", hashkey)
end

-- Generate a hash from an array by concatenating elements with commas
-- then applying the DJB2 hashing algorithm
---@param arr table Array of values to hash
---@return string hashkey Hexadecimal representation of the hash
function string_utils.array_hash(arr)
	local str = table.concat(arr, ",")
	return init.hash(str)
end

-- Helper function to remove formatting esc sequences in the string
---@param str string Input string that may contain ANSI escape sequences
---@return string Clean string with escape sequences removed
function string_utils.strip_format_esc_seq(str)
	local clean_str, _ = str:gsub(string.char(27) .. "%[[^m]*m", "")
	return clean_str
end

-- Replace the center of a string with another string
---@param str string String to be modified
---@param len number Length to be removed from the middle of str
---@param pad string String that must be inserted in place of the missing part of str
---@return string Modified string with center replaced
function string_utils.replace_center(str, len, pad)
	local mid = #str // 2
	local start = mid - (len // 2)
	return str:sub(1, start) .. pad .. str:sub(start + len + 1)
end

-- Returns the length of a utf8 string, correctly counting multi-byte characters
---@param str string UTF-8 encoded string
---@return number Count of UTF-8 characters (not bytes)
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
