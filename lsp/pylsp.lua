local common = require("configs.lspconfig")

return {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  single_file_support = true,
  flags = common.flags,
  settings = {
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        pycodestyle = { enabled = true },
        autopep8 = { enabled = true },
        isort = { enabled = true, profile = "black" },
      },
    },
  },
}
