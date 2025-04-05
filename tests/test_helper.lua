-- Test helper for lib.wezterm tests
require("busted")
require("luassert")

-- Add custom assertions
require("say")

-- Helper to create temp files for testing
local function create_temp_file(content)
	local path = os.tmpname()
	local file = io.open(path, "w")
	if file then
		file:write(content or "")
		file:close()
	end
	return path
end

-- Helper to cleanup temp files
local function remove_temp_file(path)
	os.remove(path)
end

-- Override require to use our mocks
local original_require = _G.require
local function mock_require(name)
	-- Check if we're trying to require wezterm
	if name == "wezterm" then
		return require("tests.mocks.wezterm")
	elseif name == "utils" then
		return require("tests.mocks.utils")
	else
		-- Try to load from plugin directory
		local success, module = pcall(original_require, "plugin." .. name)
		if success then
			return module
		end
		-- If not found in plugin, use the original require
		return original_require(name)
	end
end

local function setup_test_env()
	-- Save original functions to restore later
	local original_functions = {
		require = _G.require,
	}

	-- Replace functions with mocks
	_G.require = mock_require

	return function()
		-- Restore original functions
		_G.require = original_functions.require
	end
end

return {
	setup_test_env = setup_test_env,
	create_temp_file = create_temp_file,
	remove_temp_file = remove_temp_file,
}
