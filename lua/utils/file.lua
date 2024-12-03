local M = {}
local msg = require("utils.msg")

local function write(path, content, flags, mode)
  local fd = vim.uv.fs_open(path, flags, mode)
  if fd == nil then
    msg.error("could not open " .. path, "utils.nvim")
    return
  end
  local bytes = vim.uv.fs_write(fd, content)
  if bytes == nil then
    msg.error("could not write to " .. path, "utils.nvim")
    return
  end
  local success = vim.uv.fs_close(fd)
  if success == nil then
    msg.error("could not close fd" .. fd, "utils.nvim")
    return
  end
end

---appends to a file
---creates the file if not existing
---@param path string
---@param content string
---@param permissions integer # octal (e.g. 0644)
M.append_to_file = function(path, content, permissions)
  write(path, content, "a", permissions)
end

---writes to a new file
---fails if the file exists
---@param path string
---@param content string
---@param permissions integer # octal (e.g. 0644)
M.write_new_file = function(path, content, permissions)
  write(path, content, "wx", permissions)
end

---reads from a file
---@param path string
---@param permissions integer # octal (e.g. 0644)
---@return string|nil
M.read_file = function(path, permissions)
  local fd = vim.uv.fs_open(path, "r", permissions)
  if fd == nil then
    msg.error("could not open " .. path, "utils.nvim")
    return
  end
  local stat = vim.uv.fs_fstat(fd)
  if stat == nil then
    msg.error("unknown error occured", "utils.nvim")
    return
  end
  local data = vim.uv.fs_read(fd, stat.size, 0)
  vim.uv.fs_close(fd)
  return data
end

return M
