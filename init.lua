vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

-- plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- core
require "options"
require "autocmds"

-- mappings
vim.schedule(function()
  require "mappings"
end)

-- improve startup time
vim.loader.enable()
