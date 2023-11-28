local dap = require('dap')

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  -- launch exe
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    args = function()
      local input = vim.fn.input("Input args: ")
      return require("plugins.dap.dap-util").str2argtable(input)
    end,
    pythonPath = function()
      local venv_path = os.getenv("VIRTUAL_ENV")
      if venv_path then
        return venv_path .. "/bin/python"
      end
      return "/usr/bin/python"
    end
  }
}
