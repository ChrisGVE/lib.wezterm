-- Table utility functions for wezterm
local M = {}

-- deep copy
---@param original table
---@return any copy
function M.deepcopy(original)
	local copy
	if type(original) == "table" then
		copy = {}
		for k, v in pairs(original) do
			copy[k] = M.deepcopy(v)
		end
	else
		copy = original
	end
	return copy
end

-- shallow copy
---@param original table
---@return table
function M.shallowcopy(original)
	local dest
	if type(original) == "table" then
		dest({})
		for k, v in pairs(original) do
			dest[k] = v
		end
	else
		dest = original
	end
	return dest
end

-- extend table
---@param behavior behavior
---@param ... table
---@return table|nil
function M.tbl_deep_extend(behavior, ...)
	local tables = { ... }
	if #tables == 0 then
		return {}
	end

	local result = {}
	for k, v in pairs(tables[1]) do
		if type(v) == "table" then
			result[k] = M.deepcopy(v)
		else
			result[k] = v
		end
	end

	for i = 2, #tables do
		for k, v in pairs(tables[i]) do
			if type(result[k]) == "table" and type(v) == "table" then
				-- For nested tables, we recurse with the same behavior
				result[k] = M.tbl_deep_extend(behavior, result[k], v)
			elseif result[k] ~= nil then
				-- Key exists in the result already
				if behavior == "error" then
					error("Key '" .. tostring(k) .. "' exists in multiple tables")
				elseif behavior == "force" then
					-- "force" uses value from rightmost table
					if type(v) == "table" then
						result[k] = M.deepcopy(v)
					else
						result[k] = v
					end
				end
			-- "keep" keeps the leftmost value, which is already in result
			else
				-- Key doesn't exist in result yet, add it
				if type(v) == "table" then
					result[k] = M.deepcopy(v)
				else
					result[k] = v
				end
			end
		end
	end

	return result
end

return M
