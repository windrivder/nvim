local M = {}

local merge_tb = vim.tbl_deep_extend

M.mason_cmds = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

M.treesitter_cmds = {
  "TSUpdate",
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

M.toggleterm_cmds = {
  "ToggleTerm",
  "ToggleTermSetName",
  "ToggleTermToggleAll",
  "ToggleTermSendVisualLines",
  "ToggleTermSendCurrentLine",
  "ToggleTermSendVisualSelection",
}

M.set_section_map = function(section_values)
  if section_values.plugin then
    return
  end
  section_values.plugin = nil

  for mode, mode_values in pairs(section_values) do
    local default_opts = merge_tb("force", { mode = mode }, {})
    for keybind, mapping_info in pairs(mode_values) do
      -- merge default + user opts
      local opts = merge_tb("force", default_opts, mapping_info.opts or {})

      mapping_info.opts, opts.mode = nil, nil
      opts.desc = mapping_info[2]

      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

return M
