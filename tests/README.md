# Testing lib.wezterm

This directory contains tests for the `lib.wezterm` library.

## Running Tests

### Prerequisites

- Lua 5.4
- LuaRocks
- Busted (testing framework)

### Install Dependencies

```bash
luarocks install busted
luarocks install luacov
```

### Run Tests

From the root of the repository:

```bash
cd tests
busted
```

Or to run with coverage:

```bash
cd tests
busted -c
luacov
```

## Test Structure

- `*_spec.lua` files contain tests for each module
- `mocks/` directory contains mock implementations of external dependencies
- `test_helper.lua` contains test setup utilities

## Adding New Tests

When adding new functionality to the library, please add corresponding tests:

1. If you've added a new module, create a new `module_name_spec.lua` file
2. For new functions in existing modules, add test cases to the corresponding spec file
3. When needed, update mocks in the `mocks/` directory

## Continuous Integration

Tests are automatically run on GitHub Actions when:
- Code is pushed to the main branch
- A pull request is opened against the main branch

See `.github/workflows/test.yml` for details.
