local file = require("toolbox.file")

local eq = MiniTest.expect.equality

describe("file", function()
  local test_file = "./test.txt"
  after_each(function()
    os.remove(test_file)
  end)

  it("new-file", function()
    file.write_new_file(test_file, "Hello World\n", 0400)
    local get = file.read_file(test_file, 0400)
    local want = "Hello World\n"
    eq(get, want)
  end)

  it("append-file", function()
    file.write_new_file(test_file, "Hello World\n", 0400)
    file.append_to_file(test_file, "foo\n", 0400)
    local get = file.read_file(test_file, 0400)
    local want = "Hello World\nfoo\n"
    eq(get, want)
  end)
end)
