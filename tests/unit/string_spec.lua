-- Tests for string.lua
local helper = require("tests.test_helper")

describe("string", function()
	local restore

	before_each(function()
		restore = helper.setup_test_env()
	end)

	after_each(function()
		restore()
	end)

	describe("strip_format_esc_seq", function()
		it("should remove ANSI escape sequences from a string", function()
			-- Load the string module to initialize its functions
			require("plugin.string")

			local test_str = string.char(27) .. "[31mRed Text" .. string.char(27) .. "[0m"
			local result = string.strip_format_esc_seq(test_str)

			assert.are.equal("Red Text", result)
		end)

		it("should handle strings without escape sequences", function()
			-- Load the string module to initialize its functions
			require("plugin.string")

			local test_str = "Plain text without formatting"
			local result = string.strip_format_esc_seq(test_str)

			assert.are.equal(test_str, result)
		end)
	end)

	describe("replace_center", function()
		it("should replace the center of a string with provided pad", function()
			-- Load the string module to initialize its functions
			require("plugin.string")

			local test_str = "0123456789"
			local result = string.replace_center(test_str, 4, "****")

			assert.are.equal("012****789", result)
		end)

		it("should handle short strings", function()
			-- Load the string module to initialize its functions
			require("plugin.string")

			local test_str = "01"
			local result = string.replace_center(test_str, 0, "*")

			assert.are.equal("0*1", result)
		end)
	end)

	describe("utf8len", function()
		it("should correctly count UTF-8 characters", function()
			-- Load the string module to initialize its functions
			require("plugin.string")

			-- Test with ASCII
			assert.are.equal(5, string.utf8len("Hello"))

			-- Test with non-ASCII Unicode
			assert.are.equal(4, string.utf8len("Café"))

			-- Test with emoji
			assert.are.equal(2, string.utf8len("🙂👍"))

			-- Test with mixed content
			assert.are.equal(7, string.utf8len("Hi 你好 🎮"))
		end)
	end)

	describe("hash", function()
		it("should generate a consistent hash for a string", function()
			local str_module = require("plugin.string")

			-- Test with some known strings
			local hash1 = str_module.hash("test")
			assert.is_string(hash1)
			assert.is_not.equal("", hash1)

			-- Same input should produce same hash
			local hash2 = str_module.hash("test")
			assert.are.equal(hash1, hash2)

			-- Different input should produce different hash
			local hash3 = str_module.hash("different")
			assert.are_not.equal(hash1, hash3)
		end)

		it("should handle empty strings", function()
			local str_module = require("plugin.string")

			local hash = str_module.hash("")
			assert.is_string(hash)
			assert.is_not.equal("", hash)
		end)

		it("should handle special characters", function()
			local str_module = require("plugin.string")

			local hash = str_module.hash("!@#$%^&*()")
			assert.is_string(hash)
			assert.is_not.equal("", hash)
		end)
	end)

	describe("array_hash", function()
		it("should generate a hash from an array", function()
			local str_module = require("plugin.string")

			local hash1 = str_module.array_hash({ "a", "b", "c" })
			assert.is_string(hash1)

			-- Same input should produce same hash
			local hash2 = str_module.array_hash({ "a", "b", "c" })
			assert.are.equal(hash1, hash2)

			-- Different input should produce different hash
			local hash3 = str_module.array_hash({ "a", "b", "d" })
			assert.are_not.equal(hash1, hash3)
		end)
	end)
end)
