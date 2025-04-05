#!/usr/bin/env lua

-- Universal test runner for lib.wezterm
local busted = require "busted.runner"

-- Get command line arguments
local args = {...}
local pattern = args[1] or ".*_spec.lua"

-- Print info about what's being run
print("Running tests with pattern: " .. pattern)

-- Run tests with the specified pattern or all *_spec.lua files by default
busted({ pattern = pattern })
