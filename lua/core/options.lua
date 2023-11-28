local opt = vim.opt
local g = vim.g

-- system
opt.history = 2000
opt.clipboard = "unnamedplus"
opt.magic = true
opt.virtualedit = "block"
opt.encoding = "utf-8"

-- window
opt.lazyredraw = true
opt.title = false
opt.cul = true -- cursor line
opt.mouse = ""
opt.mousescroll = "ver:3,hor:6"
opt.shortmess:append "sI" -- disable nvim intro
opt.errorbells = true
opt.visualbell = true

-- theme
opt.background = "dark"
require("plugins.theme").setup("gruvbox")
opt.termguicolors = true
opt.syntax = "on"

-- buffer
opt.hidden = true
opt.ttyfast = true
opt.laststatus = 0
opt.showmode = false
opt.jumpoptions = "view"

opt.formatoptions = "1jcroql"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --hidden --vimgrep --smart-case --"

-- indenting
opt.smartindent = true
opt.autoindent = true
opt.autoread = true
opt.autowrite = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99

-- tab
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.scrolloff = 4

-- search
opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.wildignorecase = true
opt.jumpoptions = "stack"

-- number
opt.number = false
opt.numberwidth = 1
opt.ruler = false

-- backup
opt.writebackup = false
opt.backup = false
opt.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
opt.breakat = [[\ \	;:,!?]]
opt.swapfile = false
opt.undofile = true

-- window
opt.signcolumn = "no"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 400
opt.updatetime = 250
opt.backspace = "eol,start,indent"
opt.linebreak = false
-- opt.showbreak = "↳  "
opt.completeopt = "menu,menuone,noselect"
opt.wildmenu = true
opt.inccommand = "nosplit"
opt.infercase = true
opt.startofline = false

opt.whichwrap:append "<>[]hl"
opt.list = true
opt.listchars = { tab = '⋅ ', nbsp = '+', extends = '→', precedes = '←' }
opt.conceallevel = 0
opt.concealcursor = "niv"

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "matchparen",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "syntax_completion",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
  "sql_completion",
}

g.did_install_default_menus = 1
g.did_install_syntax_menu = 1
for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
