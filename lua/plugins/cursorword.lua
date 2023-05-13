local MiniCursorword = {}
local H = {}

--- Module setup
---
---@param config table|nil Module config table. See |MiniCursorword.config|.
---
---@usage `require('mini.cursorword').setup({})` (replace `{}` with your `config` table)
MiniCursorword.setup = function(config)
  -- TODO: Remove after Neovim<=0.6 support is dropped
  if vim.fn.has('nvim-0.7') == 0 then
    vim.notify(
      '(mini.cursorword) Neovim<0.7 is soft deprecated (module works but not supported).'
      .. ' It will be deprecated after Neovim 0.9.0 release (module will not work).'
      .. ' Please update your Neovim version.'
    )
  end

  -- Export module
  _G.MiniCursorword = MiniCursorword

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Module behavior
  vim.api.nvim_exec(
    [[augroup MiniCursorword
        au!
        au CursorMoved                   * lua MiniCursorword.auto_highlight()
        au InsertEnter,TermEnter,QuitPre * lua MiniCursorword.auto_unhighlight()
        au FileType TelescopePrompt let b:minicursorword_disable=v:true
        au ColorScheme * hi default MiniCursorword cterm=underline gui=underline
      augroup END]],
    false
  )

  if vim.fn.exists('##ModeChanged') == 1 then
    vim.api.nvim_exec(
    -- Call `auto_highlight` on mode change to respect `minicursorword_disable`
      [[augroup MiniCursorword
          au ModeChanged *:[^i] lua MiniCursorword.auto_highlight()
        augroup END]],
      false
    )
  end

  -- Create highlighting
  vim.api.nvim_exec(
    [[hi default MiniCursorword cterm=underline gui=underline
      hi default link MiniCursorwordCurrent MiniCursorword]],
    false
  )
end

--- Module config
---
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
MiniCursorword.config = {
  -- Delay (in ms) between when cursor moved and when highlighting appeared
  delay = 100,
}
--minidoc_afterlines_end

-- Module functionality =======================================================
--- Auto highlight word under cursor
---
--- Designed to be used with |autocmd|. No need to use it directly,
--- everything is setup in |MiniCursorword.setup|.
MiniCursorword.auto_highlight = function()
  -- Stop any possible previous delayed highlighting
  H.timer:stop()

  -- Stop highlighting immediately if module is disabled when cursor is not on
  -- 'keyword'
  if H.is_disabled() or not H.is_cursor_on_keyword() then
    H.unhighlight()
    return
  end

  -- Get current information
  local win_id = vim.api.nvim_get_current_win()
  local win_match = H.window_matches[win_id] or {}
  local curword = H.get_cursor_word()

  -- Only immediately update highlighting of current word under cursor if
  -- currently highlighted word equals one under cursor
  if win_match.word == curword then
    H.unhighlight(true)
    H.highlight(true)
    return
  end

  -- Stop highlighting previous match (if it exists)
  H.unhighlight()

  -- Delay highlighting
  H.timer:start(
    H.get_config().delay,
    0,
    vim.schedule_wrap(function()
      -- Ensure that always only one word is highlighted
      H.unhighlight()
      H.highlight()
    end)
  )
end

--- Auto unhighlight word under cursor
---
--- Designed to be used with |autocmd|. No need to use it directly, everything
--- is setup in |MiniCursorword.setup|.
MiniCursorword.auto_unhighlight = function()
  -- Stop any possible previous delayed highlighting
  H.timer:stop()
  H.unhighlight()
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniCursorword.config

-- Delay timer
H.timer = vim.loop.new_timer()

-- Information about last match highlighting (stored *per window*):
-- - Key: windows' unique buffer identifiers.
-- - Value: table with:
--     - `id` field for match id (from `vim.fn.matchadd()`).
--     - `word` field for matched word.
H.window_matches = {}

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  vim.validate({ delay = { config.delay, 'number' } })

  return config
end

H.apply_config = function(config) MiniCursorword.config = config end

H.is_disabled = function() return vim.g.minicursorword_disable == true or vim.b.minicursorword_disable == true end

H.get_config = function(config)
  return vim.tbl_deep_extend('force', MiniCursorword.config, vim.b.minicursorword_config or {}, config or {})
end

-- Highlighting ---------------------------------------------------------------
---@param only_current boolean|nil Whether to forcefuly highlight only current word
---   under cursor.
---@private
H.highlight = function(only_current)
  -- A modified version of https://stackoverflow.com/a/25233145
  -- Using `matchadd()` instead of a simpler `:match` to tweak priority of
  -- 'current word' highlighting: with `:match` it is higher than for
  -- `incsearch` which is not convenient.
  local win_id = vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_is_valid(win_id) then return end

  H.window_matches[win_id] = H.window_matches[win_id] or {}

  -- Add match highlight for current word under cursor
  local current_word_pattern = [[\k*\%#\k*]]
  local match_id_current = vim.fn.matchadd('MiniCursorwordCurrent', current_word_pattern, -1)
  H.window_matches[win_id].id_current = match_id_current

  -- Don't add main match id if not needed or if one is already present
  if only_current or H.window_matches[win_id].id ~= nil then return end

  -- Add match highlight for non-current word under cursor. NOTEs:
  -- - Using `\(...\)\@!` allows to not match current word.
  -- - Using 'very nomagic' ('\V') allows not escaping.
  -- - Using `\<` and `\>` matches whole word (and not as part).
  local curword = H.get_cursor_word()
  local pattern = string.format([[\(%s\)\@!\&\V\<%s\>]], current_word_pattern, curword)
  local match_id = vim.fn.matchadd('MiniCursorword', pattern, -1)

  -- Store information about highlight
  H.window_matches[win_id].id = match_id
  H.window_matches[win_id].word = curword
end

---@param only_current boolean|nil Whether to remove highlighting only of current
---   word under cursor.
---@private
H.unhighlight = function(only_current)
  -- Don't do anything if there is no valid information to act upon
  local win_id = vim.api.nvim_get_current_win()
  local win_match = H.window_matches[win_id]
  if not vim.api.nvim_win_is_valid(win_id) or win_match == nil then return end

  -- Use `pcall` because there is an error if match id is not present. It can
  -- happen if something else called `clearmatches`.
  pcall(vim.fn.matchdelete, win_match.id_current)
  H.window_matches[win_id].id_current = nil

  if not only_current then
    pcall(vim.fn.matchdelete, win_match.id)
    H.window_matches[win_id] = nil
  end
end

H.is_cursor_on_keyword = function()
  local col = vim.fn.col('.')
  local curchar = vim.api.nvim_get_current_line():sub(col, col)

  -- Use `pcall()` to catch `E5108` (can happen in binary files, see #112)
  local ok, match_res = pcall(vim.fn.match, curchar, '[[:keyword:]]')
  return ok and match_res >= 0
end

H.get_cursor_word = function() return vim.fn.escape(vim.fn.expand('<cword>'), [[\/]]) end

return MiniCursorword
