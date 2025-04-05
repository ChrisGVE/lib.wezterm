#!/bin/bash

# Project root directory
PROJECT_ROOT="/Users/chris/dev/projects/plugins/wezterm"
LUA_ROOT="$PROJECT_ROOT/.lua"

# Set environment variables for this session
export LUA_PATH="$LUA_ROOT/share/lua/5.4/?.lua;$LUA_ROOT/share/lua/5.4/?/init.lua;;"
export LUA_CPATH="$LUA_ROOT/lib/lua/5.4/?.so;;"
export PATH="$LUA_ROOT/bin:$PATH"

# Run tests
cd "$PROJECT_ROOT/lib.wezterm"
busted "$@"
