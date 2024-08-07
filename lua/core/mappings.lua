-- n, v, i, t = mode names
vim.g.mapleader = " "

local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "jk to esc" },

    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },

    ["<C-h>"] = { "<Left>", "move left" },
    ["<C-l>"] = { "<Right>", "move right" },
    ["<C-j>"] = { "<Down>", "move down" },
    ["<C-k>"] = { "<Up>", "move up" },
  },
  n = {
    ["<"] = { "<<", "< to <<" },
    [">"] = { ">>", "> to >>" },

    ["H"] = { "0", "H to 0" },
    ["L"] = { "$", "L to $" },
    ["<C-e>"] = { "%", "jump of symbol" },
    ["yie"] = { "<cmd> %y+ <CR>", "copy full text" },

    ["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },
    ["<C-d>"] = { "<cmd> vsplit <CR>", "window split" },
    ["<C-S-d>"] = { "<cmd> split <CR>", "window split" },

    ["gq"] = { "<cmd> bd <CR>", "close buffer" },
    ["zc"] = { "ggVGzC", "close indentation" },
    ["zo"] = { "ggVGzO", "open indentation" },

    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>c"] = { "<cmd> e $MYVIMRC | :cd %:p:h <CR>", "open nvim config" },

    ["<TAB>"] = { "<cmd> bnext <CR>", "next buffer" },
    ["<S-TAB>"] = { "<cmd> bprevious <CR>", "previous buffer" },

    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
  },
  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
  },
  v = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
  },
}

M.lsp = {
  n = {
    ["ga"] = { "<cmd> lua vim.lsp.buf.code_action() <CR>", "lsp code action" },
    ["gd"] = { "<cmd> lua vim.lsp.buf.definition() <CR>", "lsp definition" },
    ["gD"] = { "<cmd> lua vim.lsp.buf.type_definition() <CR>", "lsp type definition" },
    -- ["ge"] = { "<cmd> lua vim.lsp.buf.format { async = true } <CR>", "lsp format" },
    ["ge"] = { "<cmd> lua require('conform').format({ lsp_fallback = true, async = true }) <CR>", "lsp format" },
    ["gr"] = { "<cmd> lua vim.lsp.buf.references() <CR>", "lsp references" },
    ["gi"] = { "<cmd> lua vim.lsp.buf.implementation() <CR>", "lsp implementation" },
    ["gs"] = { "<cmd> lua vim.lsp.buf.signature_help() <CR>", "lsp signature help" },
    ["K"] = { "<cmd> lua vim.lsp.buf.hover() <CR>", "lsp hover" },
    ["<leader>rn"] = { "<cmd> lua vim.lsp.buf.rename() <CR>", "lsp rename" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.fzf = {
  n = {
    ["<leader>f"] = { "<cmd> lua require('fzf-lua').files() <CR>", "search file" },
    ["<leader>w"] = { "<cmd> lua require('fzf-lua').grep_cword() <CR>", "search word" },
    ["<leader>o"] = { "<cmd> lua require('fzf-lua').buffers() <CR>", "search old files" },
    ["<leader>d"] = { "<cmd> lua require('fzf-lua').lsp_document_diagnostics() <CR>", "search old files" },
    ["<leader>s"] = { "<cmd> lua require('fzf-lua').lsp_document_symbols() <CR>", "search old files" },
  },
}

M.toggleterm = {
  t = {
    ["<ESC>"] = { [[<C-\><C-n>]], "vi mode" },
    ["<leader>h"] = { "<cmd> ToggleTerm direction=horizontal <CR>", "toggle horizontal terminal" },
    ["<leader>v"] = { "<cmd> ToggleTerm direction=vertical <CR>", "toggle vertical terminal" },
  },
  n = {
    ["<leader>h"] = { "<cmd> ToggleTerm direction=horizontal <CR>", "toggle horizontal terminal" },
    ["<leader>v"] = { "<cmd> ToggleTerm direction=vertical <CR>", "toggle vertical terminal" },
    ["<leader>m"] = { [[<cmd> lua require("plugins.others").custom_term("glow") <CR>]], "toggle markdown" },
    ["<leader>g"] = { [[<cmd> lua require("plugins.others").custom_term("lazygit") <CR>]], "toggle lazygit" },
  },
}

M.lazy = {
  n = {
    ["<leader>ph"] = { "<cmd> Lazy <CR>", "show package" },
    ["<leader>pu"] = { "<cmd> Lazy update<CR>", "update package" },
    ["<leader>px"] = { "<cmd> Lazy clean<CR>", "clean package" },
    ["<leader>pp"] = { "<cmd> Lazy profile<CR>", "profile package" },
    ["<leader>pi"] = { "<cmd> Lazy install<CR>", "install package" },
  },
}

M.bufferline = {
  n = {
    ["<leader>1"] = { "<cmd> lua require('bufferline').go_to(1, true) <CR>", "goto buffer 1" },
    ["<leader>2"] = { "<cmd> lua require('bufferline').go_to(2, true) <CR>", "goto buffer 2" },
    ["<leader>3"] = { "<cmd> lua require('bufferline').go_to(3, true) <CR>", "goto buffer 3" },
    ["<leader>4"] = { "<cmd> lua require('bufferline').go_to(4, true) <CR>", "goto buffer 4" },
    ["<leader>5"] = { "<cmd> lua require('bufferline').go_to(5, true) <CR>", "goto buffer 5" },
    ["<leader>6"] = { "<cmd> lua require('bufferline').go_to(6, true) <CR>", "goto buffer 6" },
    ["<leader>7"] = { "<cmd> lua require('bufferline').go_to(7, true) <CR>", "goto buffer 7" },
    ["<leader>8"] = { "<cmd> lua require('bufferline').go_to(8, true) <CR>", "goto buffer 8" },
    ["<leader>9"] = { "<cmd> lua require('bufferline').go_to(9, true) <CR>", "goto buffer 9" },
    ["<leader>0"] = { "<cmd> lua require('bufferline').go_to(-1, true) <CR>", "goto last buffer" },
  },
}

for _, sect in pairs(M) do
  require("core.plugins").set_section_map(sect)
end

return M
