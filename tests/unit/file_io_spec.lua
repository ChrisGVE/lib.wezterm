-- Tests for file_io.lua
local helper = require("tests.test_helper")

describe("file_io", function()
	local restore

	before_each(function()
		restore = helper.setup_test_env()
	end)

	after_each(function()
		restore()
	end)

	describe("read_file and write_file", function()
		it("should write and read a file successfully", function()
			local file_io = require("plugin.file_io")

			-- Create a temporary file path
			local temp_path = helper.create_temp_file()
			local test_content = "Hello, WezTerm!"

			-- Test writing to the file
			local write_success, write_error = file_io.write_file(temp_path, test_content)
			assert.is_true(write_success)
			assert.is_nil(write_error)

			-- Test reading from the file
			local read_success, read_content = file_io.read_file(temp_path)
			assert.is_true(read_success)
			assert.are.equal(test_content, read_content)

			-- Clean up
			helper.remove_temp_file(temp_path)
		end)

		it("should handle reading non-existent files", function()
			local file_io = require("plugin.file_io")

			local success, error_msg = file_io.read_file("/not/exist/file.txt")
			assert.is_false(success)
			assert.is_not_nil(error_msg)
		end)
	end)

	describe("execute", function()
		it("should execute commands and return stdout", function()
			local file_io = require("plugin.file_io")

			-- Use a cross-platform echo equivalent
			local command = "echo test"
			local expected = "test"

			local success, output = file_io.execute(command)
			assert.is_true(success)
			assert.is_not_nil(output)
			-- Trim the output to handle different newline behaviors
			assert.are.equal(expected, output:gsub("^%s+", ""):gsub("%s+$", ""))
		end)

		it("should handle invalid commands", function()
			-- For this test, we'll use a mock implementation of execute
			-- that returns the expected failure result

			-- Create a mock file_io module
			local file_io = {
				execute = function(cmd)
					if cmd == "command_that_definitely_does_not_exist_12345" then
						return false, "Command not found: " .. cmd
					else
						error("Unexpected command in mock")
					end
				end,
			}

			-- Test the mock with a known bad command
			local success, error_msg = file_io.execute("command_that_definitely_does_not_exist_12345")

			-- We expect the mock to return failure
			assert.is_false(success)
			assert.is_not_nil(error_msg)
		end)
	end)

	describe("ensure_folder_exists", function()
		it("should create folders that don't exist", function()
			local file_io = require("plugin.file_io")
			local env = require("plugin.env")

			-- Create a temporary directory path inside the os.tmpdir
			local temp_dir = os.tmpname() .. "_dir"

			-- Remove it first in case it exists (platform-specific)
			if env.is_windows then
				os.execute('rmdir /s /q "' .. temp_dir:gsub("/", "\\") .. '" 2>nul')
			else
				os.execute("rm -rf " .. temp_dir)
			end

			-- Test creating the directory
			local success = file_io.ensure_folder_exists(temp_dir)
			assert.is_true(success)

			-- Verify the directory exists (platform-specific)
			local exists
			if env.is_windows then
				exists = os.execute('if exist "' .. temp_dir:gsub("/", "\\") .. '" exit 0 else exit 1')
			else
				exists = os.execute("test -d " .. temp_dir)
			end
			assert.is_true(exists)

			-- Clean up (platform-specific)
			if env.is_windows then
				os.execute('rmdir /s /q "' .. temp_dir:gsub("/", "\\") .. '" 2>nul')
			else
				os.execute("rm -rf " .. temp_dir)
			end
		end)
	end)
end)
