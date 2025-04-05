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
}

-- Allow module definitions with custom fields
files["plugin/*.lua"] = {
    read_globals = {"require", "io", "os", "string", "table", "debug"},
}

-- Different rules for test files
files["tests/**/*.lua"] = {
    read_globals = {"describe", "it", "assert", "spy", "mock", "stub", "before_each", "after_each"},
}
