local utils = require("toolbox.utils")

local eq = MiniTest.expect.equality

describe("utils", function()
  describe("is_table_empty", function()
    it("empty table", function()
      local t = {}
      local get = utils.is_table_empty(t)
      local want = true
      eq(get, want)
    end)

    it("non empty table", function()
      local t = { "foo" }
      local get = utils.is_table_empty(t)
      local want = false
      eq(get, want)
    end)
    it("string", function()
      local t = "foo"
      local get = utils.is_table_empty(t)
      local want = nil
      eq(get, want)
    end)
  end)
end)
