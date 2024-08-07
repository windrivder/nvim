local present, mason = pcall(require, "mason")

if not present then
  return
end

local options = {
  ensure_installed = {
    "yaml-language-server",
    "bash-language-server",
    "clangd",
    "gopls",
    "lua-language-server",
    "python-lsp-server",
    "rust-analyzer",
    "taplo",
    "typescript-language-server",
    "html-lsp",
    "clang-format",
    "vue-language-server",
    "ruff",
    "stylua",
  },
  PATH = "skip",
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 10,
}

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})

mason.setup(options)
