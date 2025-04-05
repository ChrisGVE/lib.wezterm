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
    
    describe("hash", function()
        it("should generate a consistent hash for a string", function()
            local init = require("plugin.init")
            
            -- Test with some known strings
            local hash1 = init.hash("test")
            assert.is_string(hash1)
            assert.is_not.equal("", hash1)
            
            -- Same input should produce same hash
            local hash2 = init.hash("test")
            assert.are.equal(hash1, hash2)
            
            -- Different input should produce different hash
            local hash3 = init.hash("different")
            assert.are_not.equal(hash1, hash3)
        end)
        
        it("should handle empty strings", function()
            local init = require("plugin.init")
            
            local hash = init.hash("")
            assert.is_string(hash)
            assert.is_not.equal("", hash)
        end)
        
        it("should handle special characters", function()
            local init = require("plugin.init")
            
            local hash = init.hash("!@#$%^&*()")
            assert.is_string(hash)
            assert.is_not.equal("", hash)
        end)
    end)
end)
