-- n, v, i, t = mode names
vim.g.mapleader = " "
local map = vim.keymap.set

-- general
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("i", "jk", "<ESC>", { desc = "jk to ESC" })
map("i", "<C-b>", "<ESC>^i", { desc = "beginning of line" })
map("i", "<C-e>", "<End>", { desc = "end of line" })
-- map("i", "<C-h>", "<Left>", { desc = "move left" })
-- map("i", "<C-l>", "<Right>", { desc = "move right" })
-- map("i", "<C-j>", "<Down>", { desc = "move down" })
-- map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<", "<<", { desc = "< to <<" })
map("n", ">", ">>", { desc = "> to >>" })
-- map("n", "H", "0", { desc = "H to 0" })
-- map("n", "L", "$", { desc = "L to $" })
map("n", "<C-e>", "%", { desc = "jump of symbol" })
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "general copy whole file" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })
map("n", "<C-d>", "<cmd> vsplit <CR>", { desc = "split current window in two vertically" })
map("n", "<C-S-d>", "<cmd> split <CR>", { desc = "split current window in two" })
map("n", "gq", "<cmd> bd <CR>", { desc = "close current buffer" })
map("n", "zc", "ggVGzC", { desc = "close indentation" })
map("n", "zo", "ggVGzO", { desc = "open indentation" })
map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "toggle line number" })
map("n", "<leader>c", "<cmd> e $MYVIMRC | :cd %:p:h <CR>", { desc = "open nvim config" })
map("n", "<TAB>", "<cmd> bnext <CR>", { desc = "switch next buffer" })
map("n", "<S-TAB>", "<cmd> bprevious <CR>", { desc = "switch previous buffer" })

-- lsp
map("n", "ga", "<cmd> lua vim.lsp.buf.code_action() <CR>", { desc = "lsp code action" })
map("n", "gd", "<cmd> lua vim.lsp.buf.definition() <CR>", { desc = "lsp definition" })
map("n", "gD", "<cmd> lua vim.lsp.buf.type_definition() <CR>", { desc = "lsp type definition" })
map("n", "ge", "<cmd> lua vim.lsp.buf.format { async = true } <CR>", { desc = "lsp format" })
map(
  "n",
  "ge",
  "<cmd> lua require('conform').format({ lsp_fallback = true, async = true }) <CR>",
  { desc = "lsp format" }
)
map("n", "gr", "<cmd> lua vim.lsp.buf.references() <CR>", { desc = "lsp references" })
map("n", "gi", "<cmd> lua vim.lsp.buf.implementation() <CR>", { desc = "lsp implementation" })
map("n", "gs", "<cmd> lua vim.lsp.buf.signature_help() <CR>", { desc = "lsp signature help" })
map("n", "K", "<cmd> lua vim.lsp.buf.hover() <CR>", { desc = "lsp hover" })
map("n", "<leader>rn", "<cmd> lua vim.lsp.buf.rename() <CR>", { desc = "lsp rename" })

-- nvimtree
map("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { desc = "toggle nvimtree" })

-- fzf
map("n", "<leader>f", "<cmd> lua require('fzf-lua').files() <CR>", { desc = "search file" })
map("n", "<leader>w", "<cmd> lua require('fzf-lua').grep_cword() <CR>", { desc = "search word" })
map("n", "<leader>o", "<cmd> lua require('fzf-lua').buffers() <CR>", { desc = "search old files" })
map(
  "n",
  "<leader>d",
  "<cmd> lua require('fzf-lua').lsp_document_diagnostics() <CR>",
  { desc = "search lsp document diagnostics" }
)
map(
  "n",
  "<leader>s",
  "<cmd> lua require('fzf-lua').lsp_document_symbols() <CR>",
  { desc = "search lsp document symbols" }
)

-- toggleterm
map("n", "<leader>h", "<cmd> ToggleTerm direction=horizontal <CR>", { desc = "toggle horizontal terminal" })
map("n", "<leader>v", "<cmd> ToggleTerm direction=vertical <CR>", { desc = "toggle vertical terminal" })
map("n", "<leader>m", [[<cmd> lua require("configs.others").custom_term("glow") <CR>]], { desc = "toggle markdown" })
map("n", "<leader>g", [[<cmd> lua require("configs.others").custom_term("lazygit") <CR>]], { desc = "toggle lazygit" })

map("t", "<ESC>", "[[<C-><C-n>]]", { desc = "vi mode" })
map("t", "<leader>h", "<cmd> ToggleTerm direction=horizontal <CR>", { desc = "toggle horizontal terminal" })
map("t", "<leader>v", "<cmd> ToggleTerm direction=vertical <CR>", { desc = "toggle vertical terminal" })

-- lazynvim
map("n", "<leader>ph", "<cmd> Lazy <CR>", { desc = "show package" })
map("n", "<leader>pu", "<cmd> Lazy update<CR>", { desc = "update package" })
map("n", "<leader>px", "<cmd> Lazy clean<CR>", { desc = "clean package" })
map("n", "<leader>pp", "<cmd> Lazy profile<CR>", { desc = "profile package" })
map("n", "<leader>pi", "<cmd> Lazy install<CR>", { desc = "install package" })

-- bufferline
map("n", "<leader>1", "<cmd> lua require('bufferline').go_to(1, true) <CR>", { desc = "goto buffer 1" })
map("n", "<leader>2", "<cmd> lua require('bufferline').go_to(2, true) <CR>", { desc = "goto buffer 2" })
map("n", "<leader>3", "<cmd> lua require('bufferline').go_to(3, true) <CR>", { desc = "goto buffer 3" })
map("n", "<leader>4", "<cmd> lua require('bufferline').go_to(4, true) <CR>", { desc = "goto buffer 4" })
map("n", "<leader>5", "<cmd> lua require('bufferline').go_to(5, true) <CR>", { desc = "goto buffer 5" })
map("n", "<leader>6", "<cmd> lua require('bufferline').go_to(6, true) <CR>", { desc = "goto buffer 6" })
map("n", "<leader>7", "<cmd> lua require('bufferline').go_to(7, true) <CR>", { desc = "goto buffer 7" })
map("n", "<leader>8", "<cmd> lua require('bufferline').go_to(8, true) <CR>", { desc = "goto buffer 8" })
map("n", "<leader>9", "<cmd> lua require('bufferline').go_to(9, true) <CR>", { desc = "goto buffer 9" })
map("n", "<leader>0", "<cmd> lua require('bufferline').go_to(-1, true) <CR>", { desc = "goto last buffer" })

-- opens and closes folds
map("n", "H", "<cmd> lua require('origami').h() <CR>", { desc = "open folds" })
map("n", "L", "<cmd> lua require('origami').l() <CR>", { desc = "close folds" })
