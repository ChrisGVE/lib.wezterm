-- Global objects defined by WezTerm
globals = {
    "wezterm",
}

-- Ignore 'unused argument self/cls' warnings
self = false

-- Ignore 'unused variable' warnings
unused_args = false

-- Exclude third-party libraries and generated files
exclude_files = {
    "tests/mocks/",
    ".lua/**/*.lua",       -- Exclude luarocks installed files
}

-- Allow module definitions with custom fields
files["plugin/*.lua"] = {
    read_globals = {"require", "io", "os", "string", "table", "debug"},
    globals = {
        "_",  -- Allow underscore as throwaway variable
    },
    ignore = {
        "631",  -- Line contains trailing whitespace
        "542",  -- Setting read-only field ? of global string
    },
}

-- Different rules for test files
files["tests/**/*.lua"] = {
    read_globals = {
        "describe", "it", "assert", "spy", "mock", "stub", 
        "before_each", "after_each", "pending", "busted", "say",
    },
    ignore = {
        "611",  -- Line contains only whitespace
        "614",  -- Trailing whitespace
        "211",  -- Unused variable
        "212",  -- Unused argument
        "421",  -- Shadowing a local variable
        "111",  -- Setting non-standard global variable
        "113",  -- Accessing undefined variable
        "143",  -- Accessing undefined field of global
    },
}

-- Allow setting string metatable fields
not_globals = {
    "string\\?",  -- Allow modifying string metatable
}

-- Line length and formatting options
max_line_length = 120
