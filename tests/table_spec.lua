-- Tests for table.lua
local helper = require "tests.test_helper"

describe("table", function()
    local restore
    
    before_each(function()
        restore = helper.setup_test_env()
    end)
    
    after_each(function()
        restore()
    end)
    
    describe("deepcopy", function()
        it("should create a deep copy of a table", function()
            local tbl = require("plugin.table")
            
            -- Test with a nested table
            local original = {
                a = 1,
                b = {
                    c = 2,
                    d = {
                        e = 3
                    }
                }
            }
            
            local copy = tbl.deepcopy(original)
            
            -- The copy should equal the original
            assert.are.same(original, copy)
            
            -- But it should be a different table instance
            assert.are_not.equal(original, copy)
            
            -- Nested tables should also be different instances
            assert.are_not.equal(original.b, copy.b)
            assert.are_not.equal(original.b.d, copy.b.d)
            
            -- Modifying the copy should not affect the original
            copy.b.c = 99
            assert.are.equal(2, original.b.c)
            assert.are.equal(99, copy.b.c)
        end)
        
        it("should handle non-table values", function()
            local tbl = require("plugin.table")
            
            assert.are.equal(42, tbl.deepcopy(42))
            assert.are.equal("test", tbl.deepcopy("test"))
            assert.is_true(tbl.deepcopy(true))
            assert.is_nil(tbl.deepcopy(nil))
        end)
    end)
    
    describe("tbl_deep_extend", function()
        it("should merge tables with 'force' behavior", function()
            local tbl = require("plugin.table")
            
            local t1 = {a = 1, b = {c = 2}}
            local t2 = {b = {d = 3}, e = 4}
            
            local result = tbl.tbl_deep_extend("force", t1, t2)
            
            assert.are.same({a = 1, b = {c = 2, d = 3}, e = 4}, result)
        end)
        
        it("should handle the 'keep' behavior", function()
            local tbl = require("plugin.table")
            
            local t1 = {a = 1, b = {c = 2}}
            local t2 = {a = 99, b = {c = 99, d = 3}}
            
            local result = tbl.tbl_deep_extend("keep", t1, t2)
            
            -- 'keep' behavior should keep the first value and not overwrite
            assert.are.equal(1, result.a)
            assert.are.equal(2, result.b.c)
            assert.are.equal(3, result.b.d)
        end)
        
        it("should throw an error with 'error' behavior when keys conflict", function()
            local tbl = require("plugin.table")
            
            local t1 = {a = 1}
            local t2 = {a = 2}
            
            assert.has_error(function()
                tbl.tbl_deep_extend("error", t1, t2)
            end)
        end)
        
        it("should handle multiple tables", function()
            local tbl = require("plugin.table")
            
            local t1 = {a = 1}
            local t2 = {b = 2}
            local t3 = {c = 3}
            
            local result = tbl.tbl_deep_extend("force", t1, t2, t3)
            assert.are.same({a = 1, b = 2, c = 3}, result)
        end)
        
        it("should handle empty tables", function()
            local tbl = require("plugin.table")
            
            local result = tbl.tbl_deep_extend("force", {})
            assert.are.same({}, result)
            
            result = tbl.tbl_deep_extend("force")
            assert.are.same({}, result)
        end)
    end)
end)
