local present, nvim_lsp = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  if client.server_capabilities.signatureHelpProvider then
    require("plugins.signature").setup(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
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

local flags = { debounce_text_changes = 150 }

local servers = {
  "clangd",
  "rust_analyzer",
  "tsserver",
  "svelte",
  "vuels",
  "jsonls",
  "bashls",
  "taplo",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = M.on_attach,
    capabilities = capabilities,
    single_file_support = true,
    flags = flags,
  }
end

local util = require("lspconfig/util")

nvim_lsp.pylsp.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,
  single_file_support = true,
  flags = flags,
  settings = {
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        pycodestyle = { enabled = true },
        autopep8 = { enabled = true },
        isort = { enabled = true, profile = "black" },
      }
    }
  }

}

nvim_lsp.rust_analyzer.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,
  single_file_support = true,
  flags = flags,
  settings = {
    ['rust-analyzer'] = {
      standalone = true,
      checkOnSave = {
        command = 'clippy'
      }
    }
  }
}

nvim_lsp.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,
  single_file_support = true,
  flags = flags,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        enable = true,
      },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

nvim_lsp.gopls.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,
  single_file_support = true,
  flags = flags,

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
      },
      staticcheck = true,
      usePlaceholders = false,
      completeUnimported = true,
      allowImplicitNetworkAccess = true,
      gofumpt = true,
    }
  },
}

return M
