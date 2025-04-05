#!/usr/bin/env lua

-- Run all unit tests

-- This is a convenience wrapper around run_tests.lua
dofile("tests/run_tests.lua", "unit/.*_spec.lua")
