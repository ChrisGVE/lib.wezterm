-- Tests for wezterm.lua
local helper = require "tests.test_helper"

describe("wezterm", function()
    local restore
    
    before_each(function()
        restore = helper.setup_test_env()
    end)
    
    after_each(function()
        restore()
    end)
    
    describe("get_current_window_size", function()
        it("should return the size of the current window", function()
            local wzt = require("plugin.wezterm")
            
            local size = wzt.get_current_window_size()
            assert.is_not_nil(size)
            assert.are.equal(24, size.rows)
            assert.are.equal(80, size.cols)
            assert.are.equal(800, size.pixel_width)
            assert.are.equal(600, size.pixel_height)
            assert.are.equal(96, size.dpi)
        end)
    end)
    
    describe("get_current_window_width", function()
        it("should return the width of the current window", function()
            local wzt = require("plugin.wezterm")
            
            local width = wzt.get_current_window_width()
            assert.is_not_nil(width)
            assert.are.equal(80, width)
        end)
    end)
end)