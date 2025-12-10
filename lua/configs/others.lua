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
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
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
    auto_select = true,
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
    direction = "tab",
  }

  toggleterm.setup(options)
end

M.custom_term = function(exec_name)
  local Terminal = require("toggleterm.terminal").Terminal

  local term = Terminal:new {
    cmd = exec_name,
    close_on_exit = true,
    hidden = true,
    direction = "tab",
    -- float_opts = {
    --   border = "single",
    -- },
  }
  term:toggle()
end

M.bufferline = function()
  local bufferline = require "bufferline"
  bufferline.setup {
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
      tab_size = 14,
      truncate_names = true,
      separator_style = "thin",
      enforce_regular_tabs = true,
    },
  }
end

return M
