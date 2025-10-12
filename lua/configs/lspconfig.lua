-- LSP 通用配置
local M = {}

-- 通用 on_attach 函数
M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if client.server_capabilities.signatureHelpProvider then
    require("configs.signature").setup(client)
  end
end

-- 通用 capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- 通用 flags
M.flags = { debounce_text_changes = 150 }

M.defaults = function()
  local servers = {
    "clangd",
    "rust_analyzer",
    "bashls",
    "taplo",
    "yamlls",
    "html",
    "jsonls",
    "ts_ls",
    "pylsp",
    "rust_analyzer",
    "lua_ls",
    "gopls",
  }
  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end 
end

return M