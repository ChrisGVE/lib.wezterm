#!/usr/bin/env lua

-- Find and run all test files
local busted = require "busted.runner"

-- This will automatically discover and run all *_spec.lua files
busted()
