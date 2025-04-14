local wezterm = require("wezterm") --[[@as Wezterm]]

--- Logger module providing consistent logging with customizable prefix and debug level control
---@class Logger
---@field prefix string The prefix to prepend to all log messages
---@field debug_enabled boolean Whether debug messages should be displayed
local Logger = {}
Logger.__index = Logger

--- Create a new logger instance
---@param opts {prefix: string, debug_enabled: boolean}
---@return Logger
function Logger.new(opts)
	local self = setmetatable({}, Logger)
	self.prefix = opts.prefix or "[plugin]"
	self.debug_enabled = opts.debug_enabled or false
	return self
end

--- Enable debug mode for this logger
---@return Logger
function Logger:enable_debug()
	self.debug_enabled = true
	return self
end

--- Disable debug mode for this logger
---@return Logger
function Logger:disable_debug()
	self.debug_enabled = false
	return self
end

--- Set the prefix for this logger
---@param prefix string
---@return Logger
function Logger:set_prefix(prefix)
	self.prefix = prefix
	return self
end

--- Log a debug message (only if debug is enabled)
---@param ... any
function Logger:debug(...)
	if self.debug_enabled then
		wezterm.log_info(self.prefix .. " DEBUG:", ...)
	end
end

--- Log an info message
---@param ... any
function Logger:info(...)
	wezterm.log_info(self.prefix .. " INFO:", ...)
end

--- Log a warning message
---@param ... any
function Logger:warn(...)
	wezterm.log_warning(self.prefix .. " WARN:", ...)
end

--- Log an error message
---@param ... any
function Logger:error(...)
	wezterm.log_error(self.prefix .. " ERROR:", ...)
end

--- Log a message at the specified level
---@param level "debug"|"info"|"warn"|"error"
---@param ... any
function Logger:log(level, ...)
	if level == "debug" then
		self:debug(...)
	elseif level == "info" then
		self:info(...)
	elseif level == "warn" then
		self:warn(...)
	elseif level == "error" then
		self:error(...)
	else
		wezterm.log_error(self.prefix .. " Invalid log level:", level)
	end
end

return Logger
