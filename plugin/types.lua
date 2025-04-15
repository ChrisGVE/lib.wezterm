---@alias behavior
---| 'error' # Raises an error if a kye exists in multiple tables
---| 'keep'  # Uses the value from the leftmost table (first occurrence)
---| 'force' # Uses the value from the rightmost table (last occurrence)

--- Orientation enum for panes
---@alias orientation
---| 'horizontal'
---| 'vertical'
---| 'unknown'

---@class TabSize
---@field rows number
---@field cols number
---@field pixel_width number
---@field pixel_height number
---@field dpi number
