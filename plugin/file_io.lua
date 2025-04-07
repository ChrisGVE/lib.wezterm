-- File I/O operations for WezTerm plugins
local env = require("env")

local M = {}

-- Execute a cmd and return its stdout
---@param cmd string command
---@return boolean success result
---@return string|nil error
function M.execute(cmd)
	local stdout
	local suc, err = pcall(function()
		local handle = io.popen(cmd)
		if not handle then
			error("Could not open process: " .. cmd)
		end
		stdout = handle:read("*a")
		if stdout == nil then
			error("Error running process: " .. cmd)
		end
		handle:close()
	end)
	if suc then
		return suc, stdout
	else
		return suc, err
	end
end

-- Create the folder if it does not exist
---@param path string
---@return boolean?
---@return number? signal
function M.ensure_folder_exists(path)
	local suc, exitcode, signal
	if env.is_windows then
		suc, exitcode, signal = os.execute('mkdir /p "' .. path:gsub("/", "\\") .. '"')
	else
		suc, exitcode, signal = os.execute('mkdir -p "' .. path .. '"')
	end
	if exitcode == "signal" then
		return suc, signal
	else
		return suc
	end
end

-- Write a file with the content of a string
---@param file_path string full filename
---@param str string content to write
---@return boolean success result
---@return string|nil error
function M.write_file(file_path, str)
	local suc, err = pcall(function()
		local handle = io.open(file_path, "w+")
		if not handle then
			error("Could not open file: " .. file_path)
		end
		handle:write(str)
		handle:flush()
		handle:close()
	end)
	return suc, err
end

-- Read a file and return its content
---@param file_path string full filename
---@return boolean success result
---@return string|nil content_or_error
function M.read_file(file_path)
	local stdout
	local suc, err = pcall(function()
		local handle = io.open(file_path, "r")
		if not handle then
			error("Could not open file: " .. file_path)
		end
		stdout = handle:read("*a")
		handle:close()
	end)
	if suc then
		return suc, stdout
	else
		return suc, err
	end
end

return M
