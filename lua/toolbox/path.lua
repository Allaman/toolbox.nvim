local M = {}

---returns OS dependant path separator
---@return string
M.path_separator = function()
  return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- Check if path exists
M.path_exists = function(path)
  path = vim.fn.expand(path)
  return vim.uv.fs_stat(path) ~= nil
end

---get the path of the user's home directory
---@return string
function M.get_home()
  return os.getenv("XDG_CONFIG_HOME")
    or os.getenv("HOME")
    or os.getenv("USERPROFILE")
    or (os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH"))
end

return M
