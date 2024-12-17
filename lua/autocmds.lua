local autocmd = vim.api.nvim_create_autocmd

-- auto mkdir
-- vim.api.nvim_create_augroup("MkdirRun", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     local dir = vim.fn.expand "<afile>:p:h"
--
--     -- This handles URLs using netrw. See ':help netrw-transparent' for details.
--     if dir:find "%l+://" == 1 then
--       return
--     end
--
--     if vim.fn.isdirectory(dir) == 0 then
--       vim.fn.mkdir(dir, "p")
--     end
--   end,
--   group = "MkdirRun",
-- })

-- dont auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- auto indent and space
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "html", "css", "xml", "json", "yaml", "vue" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false

    local bufnr = vim.fn.bufnr "%"
    vim.keymap.set("n", "o", function()
      vim.api.nvim_command [[execute "normal! \<cr>"]]
      vim.api.nvim_command(bufnr .. "bd")
    end, { buffer = bufnr })

    vim.keymap.set("n", "<CR>", function()
      vim.api.nvim_command [[execute "normal! \<cr>"]]
      vim.api.nvim_command(bufnr .. "bd")
    end, { buffer = bufnr })
  end,
})

autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
  end,
})

-- returns the last closed position
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line "'\"" > 0 and vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.fn.setpos(".", vim.fn.getpos "'\"")
      vim.cmd "silent! foldopen"
    end
  end,
})

-- auto close some filetype with <q>
autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "nofile",
    "lspinfo",
    "terminal",
    "prompt",
    "toggleterm",
    "copilot",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<CMD>close<CR>", { silent = true })
  end,
})
