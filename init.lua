vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

-- core
require "core"
require "core.options"

-- plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "git@github.com:folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- mappings
vim.defer_fn(function()
  require "core.mappings"
end, 0)
