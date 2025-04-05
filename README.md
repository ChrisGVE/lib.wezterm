# lib.wezterm

A library of common utility functions for WezTerm plugin developers.

## Overview

This library provides commonly used functionality for WezTerm plugin development, reducing duplication of code across multiple plugins. The library includes:

- File I/O operations
- String manipulation
- Table operations
- WezTerm-specific utilities
- Cross-platform path handling

## Installation

Add to your WezTerm configuration:

```lua
local lib = wezterm.plugin.require("https://github.com/chrisgve/lib.wezterm")
```

## Usage

```lua
-- Example: Using the hash function
local key = lib.hash("my-string")

-- Example: Reading a file
local success, content = lib.file_io.read_file("/path/to/file")
if success then
  -- Use content
end

-- Example: Get current window width
local width = lib.wezterm.get_current_window_width()
```

## Available Modules

### init

- `hash(str)` - Compute a hash from a string

### file_io

- `execute(cmd)` - Execute a command and return its stdout
- `ensure_folder_exists(path)` - Create a folder if it doesn't exist
- `write_file(file_path, str)` - Write a string to a file
- `read_file(file_path)` - Read a file's contents

### string

- `array_hash(arr)` - Generate a hash from an array
- `string.strip_format_esc_seq(str)` - Remove formatting escape sequences
- `string.replace_center(str, len, pad)` - Replace the center of a string
- `string.utf8len(str)` - Get the length of a UTF-8 string

### table

- `deepcopy(original)` - Create a deep copy of a table
- `tbl_deep_extend(behavior, ...)` - Merge tables with different behaviors

### utils

- Platform detection: `is_windows`, `is_mac`
- Path separator: `separator`

### wezterm

- `get_current_window_size()` - Get current window dimensions
- `get_current_window_width()` - Get current window width

## Testing

The library includes a comprehensive test suite to ensure functionality works as expected.

### Running Tests

```bash
cd tests
busted
```

See [tests/README.md](tests/README.md) for more details on testing.

## Contributing

Contributions are welcome! Please add tests for any new functionality.

## License

MIT
