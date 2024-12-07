local utils = setmetatable({}, {
  __index = function(t, k)
    local ok, val = pcall(require, string.format("utils.%s", k))

    if ok then
      rawset(t, k, val)
    end

    return val
  end,
})

return utils
