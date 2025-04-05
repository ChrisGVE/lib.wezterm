#!/bin/bash
# Check for dependencies
echo "Checking for dependencies..."
which lua
which busted
which luacov

# If missing, try to install
if [ $? -ne 0 ]; then
    echo "Attempting to install dependencies..."
    which luarocks
    if [ $? -eq 0 ]; then
        luarocks install busted
        luarocks install luacov
    else
        echo "LuaRocks not found. Cannot install dependencies."
        exit 1
    fi
fi

# Try to run tests
echo "Running tests..."
cd /projects/dev/projects/plugins/wezterm/lib.wezterm/tests
busted -v
