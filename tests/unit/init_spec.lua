-- Tests for init.lua
local helper = require "tests.test_helper"

describe("init", function()
    local restore
    
    before_each(function()
        restore = helper.setup_test_env()
    end)
    
    after_each(function()
        restore()
    end)
    
    -- Basic test to ensure init module can be loaded and returned
    it("should load without errors", function()
        local init = require("plugin.init")
        assert.is_table(init)
    end)
end)
