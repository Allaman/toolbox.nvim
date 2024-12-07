local M = {}

---info notification via vim.notify
---@param message string
---@param title string
M.info = function(message, title)
  vim.notify(message, vim.log.levels.INFO, { title = title })
end

---warning notification via vim.notify
---@param message string
---@param title string
M.warn = function(message, title)
  vim.notify(message, vim.log.levels.WARN, { title = title })
end

---error notification via vim.notify
---@param message string
---@param title string
M.error = function(message, title)
  vim.notify(message, vim.log.levels.ERROR, { title = title })
end

return M
