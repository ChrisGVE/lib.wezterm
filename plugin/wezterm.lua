local wezterm = require("wezterm") --[[@as Wezterm]]

local M = {}

--- Determines if two panes are adjacent and their split orientation
---@param pane1 any WezTerm pane object
---@param pane2 any WezTerm pane object
---@return boolean is_adjacent
---@return orientation orientation
function M.get_panes_orientation(pane1, pane2)
	local pos1 = pane1:get_position()
	local pos2 = pane2:get_position()
	local dims1 = pane1:get_dimensions()
	local dims2 = pane2:get_dimensions()

	-- Check if panes are adjacent horizontally (side by side)
	if
		(pos1.y == pos2.y and dims1.height == dims2.height)
		and ((pos1.x + dims1.pixel_width == pos2.x) or (pos2.x + dims2.pixel_width == pos1.x))
	then
		return true, "horizontal"
	end

	-- Check if panes are adjacent vertically (stacked)
	if
		(pos1.x == pos2.x and dims1.width == dims2.width)
		and ((pos1.y + dims1.pixel_height == pos2.y) or (pos2.y + dims2.pixel_height == pos1.y))
	then
		return true, "vertical"
	end

	return false, "unknown"
end

--- Process information returned from get_pane_process
---@class ProcessInfo
---@field name string Process name
---@field args string[] Process arguments if available
---@field is_shell boolean Whether this appears to be a shell process
---@field pid number|nil Process ID if available
---@field cwd string Current working directory if available

--- Determines the process running in a pane
---@param pane any WezTerm pane object
---@param shell_list string[]|nil Optional list of shell names to check against
---@return ProcessInfo
function M.get_pane_process(pane, shell_list)
	shell_list = shell_list or { "bash", "zsh", "fish", "sh", "dash", "ksh", "csh", "tcsh", "nushell" }

	-- Default return values
	local result = {
		name = "unknown",
		args = {},
		is_shell = false,
		pid = nil,
		cwd = "",
	}

	-- Try to get process info
	local success, process_info = pcall(function()
		return pane:get_foreground_process_info()
	end)

	if success and process_info then
		result.name = process_info.name or "unknown"
		result.args = process_info.args or {}
		result.pid = process_info.pid

		-- Check if this is a shell process
		for _, shell in ipairs(shell_list) do
			if result.name:find(shell) then
				result.is_shell = true
				break
			end
		end
	end

	-- Try to get current working directory
	local cwd_success, cwd = pcall(function()
		return pane:get_current_working_dir()
	end)

	if cwd_success and cwd then
		if type(cwd) == "string" then
			result.cwd = cwd
		elseif type(cwd) == "table" and cwd.file_path then
			result.cwd = cwd.file_path
		end
	end

	return result
end

--- Get current working directory from a pane
---@param pane any WezTerm pane object
---@return string cwd
function M.get_cwd(pane)
	local success, cwd = pcall(function()
		return pane:get_current_working_dir()
	end)

	if success and cwd then
		if type(cwd) == "string" then
			return cwd
		elseif type(cwd) == "table" and cwd.file_path then
			return cwd.file_path
		end
	end

	return ""
end

--- Capture scrollback buffer from a pane
---@param pane any WezTerm pane object
---@param max_lines number|nil Maximum number of lines to capture (nil for all available)
---@return string|nil scrollback
function M.capture_scrollback(pane, max_lines)
	local success, scrollback

	if max_lines then
		success, scrollback = pcall(function()
			return pane:get_lines_as_text(max_lines)
		end)
	else
		success, scrollback = pcall(function()
			return pane:get_lines_as_text()
		end)
	end

	if success and scrollback then
		return scrollback
	end

	return nil
end

return M
