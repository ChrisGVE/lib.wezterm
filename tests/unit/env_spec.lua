-- Tests for utils.lua
local helper = require("tests.test_helper")

describe("plugin.env", function()
	local restore

	before_each(function()
		restore = helper.setup_test_env()
	end)

	after_each(function()
		restore()
	end)

	it("should detect Windows platform correctly", function()
		-- Set up a mock for Windows
		package.loaded["tests.mocks.wezterm"] = nil -- Clear cached module
		local mock_wezterm = require("tests.mocks.wezterm")
		mock_wezterm.target_triple = "x86_64-pc-windows-msvc"

		-- Reload utils with the Windows mock
		package.loaded["plugin.env"] = nil
		local env = require("plugin.env")

		assert.is_true(env.is_windows)
		assert.is_false(env.is_mac)
		assert.are.equal("\\", env.separator)
	end)

	it("should detect macOS platform correctly", function()
		-- Set up a mock for macOS
		package.loaded["tests.mocks.wezterm"] = nil -- Clear cached module
		local mock_wezterm = require("tests.mocks.wezterm")
		mock_wezterm.target_triple = "x86_64-apple-darwin"

		-- Reload utils with the macOS mock
		package.loaded["plugin.env"] = nil
		local env = require("plugin.env")

		assert.is_false(env.is_windows)
		assert.is_true(env.is_mac)
		assert.are.equal("/", env.separator)
	end)

	it("should detect Linux platform correctly", function()
		-- Set up a mock for Linux
		package.loaded["tests.mocks.wezterm"] = nil -- Clear cached module
		local mock_wezterm = require("tests.mocks.wezterm")
		mock_wezterm.target_triple = "x86_64-unknown-linux-gnu"

		-- Reload utils with the Linux mock
		package.loaded["plugin.env"] = nil
		local env = require("plugin.env")

		assert.is_false(env.is_windows)
		assert.is_false(env.is_mac)
		assert.are.equal("/", env.separator)
	end)
end)
