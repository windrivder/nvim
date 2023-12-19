-- n, v, i, t = mode names
vim.g.mapleader = " "

local M = {}

M.general = {
  i = {
    ["jk"] = { "<ESC>", "jk to esc" },

    -- go to beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },

    -- navigate within insert mode
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

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },
    ["<C-d>"] = { "<cmd> vsplit <CR>", "window split" },
    ["<C-S-d>"] = { "<cmd> split <CR>", "window split" },

    ["gq"] = { "<cmd> bd <CR>", "close buffer" },
    -- ["gb"] = { "gg=G<C-o>", "format document" },
    ["zc"] = { "ggVGzC", "close indentation" },
    ["zo"] = { "ggVGzO", "open indentation" },

    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>s"] = { "<cmd> e $MYVIMRC | :cd %:p:h <CR>", "open nvim config" },

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
    -- ["<leader>t"] = { "<cmd> LSoutlineToggle <CR>", "lsp outline" },
    -- ["<leader>a"] = { "<cmd> Lspsaga code_action <CR>", "lsp code action" },
    ["<leader>rn"] = { "<cmd> lua vim.lsp.buf.rename() <CR>", "lsp rename" },
    -- ["<leader>rn"] = { "<cmd> Lspsaga rename <CR>", "lsp rename" },
    -- ["<leader>wa"] = { "<cmd> lua vim.lsp.buf.add_workspace_folder() <CR>", "lsp add workspace folder" },
    -- ["<leader>wr"] = { "<cmd> lua vim.lsp.buf.remove_workspace_folder() <CR>", "lsp remove workspace folder" },
    -- ["<leader>wl"] = { "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <CR>",
    --   "lsp list workspace folder" },

    ["gd"] = { "<cmd> lua vim.lsp.buf.definition() <CR>", "lsp definition" },
    ["gD"] = { "<cmd> lua vim.lsp.buf.type_definition() <CR>", "lsp type definition" },
    -- ["gd"] = { "<cmd> Lspsaga goto_definition <CR>", "lsp definition" },
    -- ["gp"] = { "<cmd> Lspsaga peek_definition <CR>", "lsp definition" },
    -- ["gh"] = { "<cmd> Lspsaga lsp_finder <CR>", "lsp finder" },
    ["ge"] = { "<cmd> lua vim.lsp.buf.format { async = true } <CR>", "lsp format" },
    ["gr"] = { "<cmd> lua vim.lsp.buf.references() <CR>", "lsp references" },
    ["gi"] = { "<cmd> lua vim.lsp.buf.implementation() <CR>", "lsp implementation" },
    ["gs"] = { "<cmd> lua vim.lsp.buf.signature_help() <CR>", "lsp signature help" },
    ["K"] = { "<cmd> lua vim.lsp.buf.hover() <CR>", "lsp hover" },
    -- ["K"] = { "<cmd> Lspsaga hover_doc <CR>", "lsp hover" },
  },
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  }
}

M.fzf = {
  n = {
    ["<leader>f"] = { "<cmd> lua require('fzf-lua').files() <CR>", "search file" },
    ["<leader>w"] = { "<cmd> lua require('fzf-lua').grep_cword() <CR>", "search word" },
    ["<leader>o"] = { "<cmd> lua require('fzf-lua').buffers() <CR>", "search old files" },
  }
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
    -- ["<leader>ps"] = { "<cmd> Lazy sync<CR>", "sync package" },
    ["<leader>pu"] = { "<cmd> Lazy update<CR>", "update package" },
    ["<leader>px"] = { "<cmd> Lazy clean<CR>", "clean package" },
    -- ["<leader>pl"] = { "<cmd> Lazy restore<CR>", "restore package" },
    ["<leader>pp"] = { "<cmd> Lazy profile<CR>", "profile package" },
    ["<leader>pi"] = { "<cmd> Lazy install<CR>", "install package" },
  }
}

M.other = {
  n = {
    ["<leader>gb"] = { [[<cmd> GitBlameToggle <CR>]], "toggle gitblame" },
    ["<leader>t"] = { [[<cmd> SymbolsOutline <CR>]], "toggle outline" },
    -- ["<leader>a"] = { [[<cmd> Alpha <CR>]], "toggle dashboard" },
    -- ["<leader>r"] = { "<Plug>RestNvim", "run the request under the cursor" }
  }
}

--[[ M.dap = {
  n = {
    ["<leader>ds"] = { "<cmd> lua require('dap').continue() <CR>", "dap.continue" },
    ["<leader>dc"] = { "<cmd> lua require('dap').step_over() <CR>", "dap.step_over" },
    ["<leader>di"] = { "<cmd> lua require('dap').step_into() <CR>", "dap.step_into" },
    ["<leader>do"] = { "<cmd> lua require('dap').step_out() <CR>", "dap.step_out" },
    ["<leader>db"] = { "<cmd> lua require('dap').toggle_breakpoint() <CR>", "dap.toggle_breakpoint" },

    ["<leader>dt"] = { "<cmd> lua require('dap').terminate() <CR>", "dap.terminate" },
    ["<leader>dh"] = { "<cmd> lua require('dapui').toggle() <CR>", "dap.ui.toggle" },
  }
} ]]

M.refactoring = {
  n = {
    ["<leader>rI"] = { "<cmd> lua require('refactoring').refactor('Inline Function') <CR>", "refactor.inline_function" },
    ["<leader>ri"] = { "<cmd> lua require('refactoring').refactor('Inline Variable') <CR>", "refactor.inline_variable" },
    ["<leader>rb"] = { "<cmd> lua require('refactoring').refactor('Extract Block') <CR>", "refactor.extract_block" },
    ["<leader>rbf"] = { "<cmd> lua require('refactoring').refactor('Extract Block To File') <CR>", "refactor.extract_block_to_file" },

  },
  v = {
    ["<leader>re"] = { "<cmd> lua require('refactoring').refactor('Extract Function') <CR>", "refactor.extract_function" },
    ["<leader>rf"] = { "<cmd> lua require('refactoring').refactor('Extract Function To File') <CR>", "refactor.extract_function_to_file" },
    ["<leader>rv"] = { "<cmd> lua require('refactoring').refactor('Extract Variable') <CR>", "refactor.extract_variable" },
  }
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
  }
}

M.project = {
  n = {
    ["<leader>p"] = { "<cmd> WorkspacesOpen <CR>", "open workspace" },
    ["<leader>pa"] = { "<cmd> WorkspacesAdd <CR>", "add workspace" },
    ["<leader>pr"] = { "<cmd> WorkspacesRemove <CR>", "remove workspace" },
    ["<leader>pl"] = { "<cmd> WorkspacesList <CR>", "list workspace" },

  }
}

M.session = {
  n = {
    ["<leader>sl"] = { "<cmd> lua require('session_manager').load_session() <CR>", "load session" },
    ["<leader>sa"] = { "<cmd> lua require('session_manager').save_current_session() <CR>", "save session" },
    ["<leader>sd"] = { "<cmd> lua require('session_manager').delete_session() <CR>", "delete session" },
  }
}

for _, sect in pairs(M) do
  require("core.plugins").set_section_map(sect)
end

return M
