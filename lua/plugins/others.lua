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

M.aerial = function()
  local present, aerial = pcall(require, "aerial")

  if not present then
    return
  end

  aerial.setup({
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
      max_width = { 40, 0.4 },
      width = nil,
      min_width = 25,
      -- Enum: prefer_right, prefer_left, right, left, float
      default_direction = "prefer_right",
      lazy_load = true,
      autojump = true,
    },
  })
end

return M
