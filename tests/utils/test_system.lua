local sys = require("utils.system")

local eq = MiniTest.expect.equality

describe("system", function()
  describe("executable", function()
    it("valid", function()
      local get = sys.is_executable("nvim")
      local want = true
      eq(get, want)
    end)
    it("invalid", function()
      local get = sys.is_executable("fooooobar")
      local want = false
      eq(get, want)
    end)
  end)

  describe("vim version", function()
    it("satisfied", function()
      local get = sys.is_neovim_version_satisfied(5)
      local want = true
      eq(get, want)
    end)
    it("not satisfied", function()
      local get = sys.is_neovim_version_satisfied(999)
      local want = false
      eq(get, want)
    end)
  end)

  describe("get_os_identifier", function()
    local mock_system
    local original_system

    before_each(function()
      -- Store original notify function
      original_notify = vim.notify
      -- Replace with empty function
      vim.notify = function() end
      -- Store original vim.system
      original_system = vim.system
      -- Create mock for vim.system
      mock_system = function(cmd)
        return {
          wait = function()
            return {
              code = 0,
              stdout = "Linux\n",
              stderr = "",
            }
          end,
        }
      end
      -- Replace vim.system with our mock
      vim.system = mock_system
    end)

    after_each(function()
      -- Restore original notify function
      vim.notify = original_notify
      -- Restore original vim.system
      vim.system = original_system
    end)

    it("should return OS name when uname exists and succeeds", function()
      local get = sys.get_os_identifier()
      eq(get, "Linux\n")
    end)

    it("should return empty string when uname doesn't exist", function()
      -- Mock is_executable to return false
      sys.is_executable = function(cmd)
        return false
      end
      local get = sys.get_os_identifier()
      eq(get, "")
    end)

    it("should return empty string when uname command fails", function()
      -- Override mock_system for this specific test
      vim.system = function(cmd)
        return {
          wait = function()
            return {
              code = 1,
              stdout = "",
              stderr = "some error",
            }
          end,
        }
      end

      local get = sys.get_os_identifier()
      eq(get, "")
    end)
  end)
end)
