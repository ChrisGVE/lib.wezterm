#!/bin/bash

# Get the absolute path to the project root
PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LUA_DIR="$PROJECT_ROOT/.lua"

# Setup environment for this script execution only
export LUA_PATH="$LUA_DIR/share/lua/5.4/?.lua;$LUA_DIR/share/lua/5.4/?/init.lua;$LUA_PATH"
export LUA_CPATH="$LUA_DIR/lib/lua/5.4/?.so;$LUA_CPATH"
export PATH="$LUA_DIR/bin:$PATH"

# Change to lib.wezterm directory
cd "$PROJECT_ROOT/lib.wezterm"

# Default to running all tests if no specific test is provided
if [ $# -eq 0 ]; then
  echo "Running all tests..."
  busted tests/unit
else
  echo "Running specified tests..."
  busted "$@"
fi

# Generate coverage report if -c flag was used
if [[ "$*" == *"-c"* ]]; then
  echo "Generating coverage report..."
  luacov
  echo "Coverage report available at: $(pwd)/luacov.report.out"
fi
