local M = {}

M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")

  if not present then
    return
  end

  local options = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  luasnip.config.set_config(options)
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
  require("luasnip.loaders.from_vscode").lazy_load { paths = "~/.config/nvim/.snippets" }

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.lspsaga = function()
  require("lspsaga").setup({
    diagnostic = {
      icon = '💡',
      show_code_action = false,
      show_source = false,
      auto_enter_float = false,
    },
    code_action_lightbulb = {
      enable = false,
      enable_in_insert = false,
    },
    symbol_in_winbar = {
      enable = false,
    }
  })
end

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not (present1 and present2) then
    return
  end

  local options = {
    fast_wrap = {},
    disable_filetype = { "vim" },
    map_cr = true,
    map_complete = true,
    auto_select = true
  }

  autopairs.setup(options)

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.toggleterm = function()
  local present, toggleterm = pcall(require, "toggleterm")

  if not present then
    return
  end

  local options = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    open_mapping = [[<c-\>]],
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    hide_numbers = false,
    shade_terminals = false,
    direction = 'tab',
  }

  toggleterm.setup(options)
end

M.custom_term = function(exec_name)
  local Terminal = require('toggleterm.terminal').Terminal

  local term = Terminal:new({
    cmd = exec_name,
    close_on_exit = true,
    hidden = true,
    direction = "float",
    float_opts = {
      border = "single",
    },
  })
  term:toggle()
end

M.rest = function()
  local present, rest = pcall(require, "rest-nvim")

  if not present then
    return
  end

  local options = {
    result_split_in_place = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = true,
    -- Encode URL before making request
    encode_url = true,
    result = {
      -- toggle showing URL, HTTP info, headers at top the of result window
      show_url = true,
      show_http_info = true,
      show_headers = true,
      formatters = {
        json = "jq",
        html = function(body)
          return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
        end
      },
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = '.env',
    custom_dynamic_variables = {},
    yank_dry_run = true,
  }

  rest.setup(options)
end

M.outline = function()
  local present, outline = pcall(require, "symbols-outline")

  if not present then
    return
  end

  outline.setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = false,
    width = 25,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    autofold_depth = nil,
    auto_unfold_hover = false,
    fold_markers = { '', '' },
    wrap = false,
    keymaps = {
      close = { "<Esc>", "q" },
      goto_location = "<CR>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
  })
end

M.refactoring = function()
  require("refactoring").setup({
    -- prompt for return type
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
      python = true,
      rust = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
      python = true,
      rust = true,
    },
  })
end

M.alpha = function()
  local alpha = require('alpha')
  local startify = require('alpha.themes.startify')
  startify.section.header.val = {
    [[                         _    _   ]],
    [[                        | |  | |  ]],
    [[__      __ _   _   __ _ | |_ | |_ ]],
    [[\ \ /\ / /| | | | / _` || __|| __|]],
    [[ \ V  V / | |_| || (_| || |_ | |_ ]],
    [[  \_/\_/   \__, | \__,_| \__| \__|]],
    [[            __/ |                 ]],
    [[           |___/                  ]],
  }
  alpha.setup(startify.config)
end

M.bufferline = function()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      mode = "buffers",
      themable = true,
      numbers = "ordinal",
      show_buffer_icons = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      show_duplicate_prefix = true,
      persist_buffer_sort = true,
      always_show_bufferline = false,
      tab_size = 16,
      truncate_names = true,
      separator_style = "thin",
      enforce_regular_tabs = true,
    }
  })
end

return M
