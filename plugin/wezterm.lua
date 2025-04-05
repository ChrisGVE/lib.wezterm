local wezterm = require("wezterm") --[[@as Wezterm]] --- this type cast invokes the LSP module for Wezterm

local M = {}

-- getting the width of the current window
---@return TabSize|nil
function M.get_current_window_size()
	local windows = wezterm.gui.gui_windows()
	for _, window in ipairs(windows) do
		if window:is_focused() then
			return window:active_tab():get_size()
		end
	end
end

-- getting the width of the current window
---@return number|nil
function M.get_current_window_width()
	local size = M.get_current_window_size()
	if size ~= nil then
		return size.cols
	end
end

return M
