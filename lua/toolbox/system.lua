local M = {}
local msg = require("toolbox.msg")

---checks if a executable is available
---@param executable string
---@return boolean
M.is_executable = function(executable)
  return vim.fn.executable(executable) == 1
end

---checks if the minimum Neovim version is satisfied
---expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.is_neovim_version_satisfied = function(version)
  -- TODO: Handle Neovim major version jump
  return version <= tonumber(vim.version().minor)
end

---returns the OS; depends on uname
---@return string
M.get_os_identifier = function()
  if not M.is_executable("uname") then
    msg.error("uname command not found", "utils.nvim")
    return ""
  end
  local os = vim.system({ "uname", "-s" }):wait()
  if os.code ~= 0 then
    msg.error("error while getting OS info: " .. os.stderr, "utils.nvim")
    return ""
  end
  return os.stdout
end

return M
