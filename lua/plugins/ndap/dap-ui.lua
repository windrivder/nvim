local present, dapui = pcall(require, 'dapui')
if not present then
  return
end

local options = {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "o", "<2-LeftMouse>", "<CR>" },
    open = "O",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        'scopes',
      },
      size = 30,
      position = 'left',
    },
    {
      elements = {
        'stacks',
        'breakpoints',
        'watches',
      },
      size = 30,
      position = 'right',
    },
    {
      elements = {
        'console',
      },
      size = 5,
      position = 'top',
    },
    {
      elements = {
        'repl',
      },
      size = 12,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

dapui.setup(options)
