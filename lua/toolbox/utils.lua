local M = {}

---checks if a variable is not empty nor nil
---@param s string
---@return boolean
M.is_empty = function(s)
  return s == nil or s == ""
end

---returns the number of items in a table
---@param t table
---@return integer
M.table_length = function(t)
  return #t
end

---checks if a table is empty
---@param t table<any>
---@return boolean|nil
M.is_table_empty = function(t)
  if type(t) ~= "table" then
    return
  end
  return next(t) == nil
end

---checks if a module is available
---@param module string
---@return boolean
M.is_module_available = function(module)
  local ok, _ = pcall(require, module)
  return ok
end

---set a key mapping
---@param mode string|string[]
---@param l string
---@param r string|function
---@param opts vim.keymap.set.Opts|nil
M.map = function(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

return M
