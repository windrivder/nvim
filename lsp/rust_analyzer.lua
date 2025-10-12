local common = require("configs.lspconfig")

return {
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  single_file_support = true,
  flags = common.flags,
  settings = {
    ["rust-analyzer"] = {
      standalone = true,
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
