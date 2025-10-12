local common = require("configs.lspconfig")
local util = require "lspconfig/util"

return {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  single_file_support = true,
  flags = common.flags,

  cmd = { "gopls", "-remote=auto" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        shadow = false,
        unusedparams = false,
        unusewrites = true,
        ST1000 = false,  -- 包注释不正确或缺失
        ST1020 = false, -- 导出函数的文档应以函数名称开头
      },
      staticcheck = true,
      usePlaceholders = false,
      completeUnimported = true,
      gofumpt = true,
    },
  },
}
