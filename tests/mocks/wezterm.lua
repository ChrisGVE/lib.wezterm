-- Mock WezTerm API for testing
local mock = {}

-- Mock GUI window
local MockWindow = {}
MockWindow.__index = MockWindow

function MockWindow:is_focused()
    return true
end

function MockWindow:active_tab()
    return {
        get_size = function()
            return {
                rows = 24,
                cols = 80,
                pixel_width = 800,
                pixel_height = 600,
                dpi = 96
            }
        end
    }
end

-- Mock GUI module
mock.gui = {
    gui_windows = function()
        local window = setmetatable({}, MockWindow)
        return {window}
    end
}

-- Mock wezterm.plugin module
mock.plugin = {
    require = function(url)
        if url == "https://github.com/chrisgve/dev.wezterm" then
            return {
                setup = function(opts)
                    return opts
                end
            }
        end
        return nil
    end
}

-- Set platform-specific values for testing
mock.target_triple = "x86_64-unknown-linux-gnu" -- can be overridden in tests

return mock
