local M = {}

local function config_dapi_and_sign()
  local dap_breakpoint_color = {
    breakpoint = {
      ctermbg = 0,
      fg = '#993939',
      bg = '#31353f',
    },
    logpoing = {
      ctermbg = 0,
      fg = '#61afef',
      bg = '#31353f',
    },
    stopped = {
      ctermbg = 0,
      fg = '#98c379',
      bg = '#31353f'
    },
  }

  vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
  vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
  vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)

  local dap_breakpoint = {
    error = {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    condition = {
      text = 'ﳁ',
      texthl = 'DapBreakpoint',
      linehl = 'DapBreakpoint',
      numhl = 'DapBreakpoint',
    },
    rejected = {
      text = "",
      texthl = "DapBreakpint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
    },
    logpoint = {
      text = '',
      texthl = 'DapLogPoint',
      linehl = 'DapLogPoint',
      numhl = 'DapLogPoint',
    },
    stopped = {
      text = '',
      texthl = 'DapStopped',
      linehl = 'DapStopped',
      numhl = 'DapStopped',
    },
  }

  vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
  vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
  vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
  vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
  vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
end

local function config_dapui()
  local dap, dapui                                      = require "dap", require "dapui"

  local debug_open                                      = function()
    dapui.open()
    vim.api.nvim_command("DapVirtualTextEnable")
    -- vim.api.nvim_command("NvimTreeClose")
  end
  local debug_close                                     = function()
    dap.repl.close()
    dapui.close()
    vim.api.nvim_command("DapVirtualTextDisable")
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    debug_open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    debug_close()
  end
  dap.listeners.before.event_exited["dapui_config"]     = function()
    debug_close()
  end
  dap.listeners.before.disconnect["dapui_config"]       = function()
    debug_close()
  end
end

local function config_debuggers()
  local dap = require "dap"
  dap.defaults.fallback.terminal_win_cmd = '30vsplit new'
  dap.set_log_level("DEBUG")

  require("dap.ext.vscode").load_launchjs(nil, { codelldb = { "c", "cpp", "rust" } })
  require('dap-python').setup(vim.fn.stdpath("data") .. '/mason/packages/debugpy/venv/bin/python')
  require('dap-go').setup()
end

function M.setup()
  config_dapi_and_sign()
  config_dapui()
  config_debuggers()
end

return M
