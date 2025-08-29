local plugins = {
  "nvim-lua/plenary.nvim",

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require "configs.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        rust = { "rustfmt", lsp_format = "fallback" },
        go = { "goimports", "gofmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
    },
    config = function()
      require "configs.nvimcmp"
    end,
  },

  {
    "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("configs.others").luasnip()
    end,
  },

  -- misc plugins
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = {
      "ToggleTerm",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
      "ToggleTermSendVisualLines",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualSelection",
    },
    config = function()
      require("configs.others").toggleterm()
    end,
  },

  -- ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup()
      -- require("configs.cursorword").setup()
    end,
  },

  {
    "kyazdani42/nvim-tree.lua",
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "configs.nvimtree"
    end,
  },

  -- quickly move: s char char
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "ibhagwan/fzf-lua",
    lazy = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("configs.others").autopairs()
    end,
  },

  -- open or close folds
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      foldKeymaps = {
        setup = true,
        hOnlyOpensOnFirstColumn = true,
      },
    },
  },

  -- smooth scrolling
  -- {
  --   "karb94/neoscroll.nvim",
  --   opts = {},
  -- },

  --[[ Old text                    Command         New text
--------------------------------------------------------------------------------
    surr*ound_words             ysiw)           (surround_words)
    *make strings               ys$"            "make strings"
    [delete ar*ound me!]        ds]             delete around me!
    remove <b>HTML t*ags</b>    dst             remove HTML tags
    'change quot*es'            cs'"            "change quotes"
    <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
    delete(functi*on calls)     dsf             function calls ]]
  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    cmd = {
      "TSUpdate",
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require "configs.treesitter"
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup()
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs.others").bufferline()
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      }
    end,
  },
}

-- Load all plugins
local present, lazy = pcall(require, "lazy")
if present then
  local opts = {
    root = vim.fn.stdpath "data" .. "/lazy",
    lockfile = vim.fn.stdpath "data" .. "/lazy/lazy-lock.json",
  }

  lazy.setup(plugins, opts)
end
