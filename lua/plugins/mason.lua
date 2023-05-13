local present, mason = pcall(require, "mason")

if not present then
  return
end

local options = {
  ensure_installed = {
    "clangd",
    "rust-analyzer",
    "python-lsp-server",
    "gopls",
    "lua-language-server",
    "svelte-language-server",
    "vue-language-server",
    "typescript-language-server",
    "json-lsp",
    "bash-language-server",
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
