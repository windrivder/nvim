local plugins = {
  { "nvim-lua/plenary.nvim",   module = "plenary" },

  { "lewis6991/impatient.nvim" },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = require("core.plugins").mason_cmds,
    config = function()
      require "plugins.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.lspconfig"
    end,
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
      "hrsh7th/cmp-cmdline",
      "amarakon/nvim-cmp-buffer-lines",
      "ray-x/cmp-treesitter",
    },
    config = function()
      -- require("codeium").setup({})
      require "plugins.nvimcmp"
    end
  },

  --[[ {

    "jcdickinson/codeium.nvim",
    dependencies = {
      "jcdickinson/http.nvim",
      build = "cargo build --workspace --release"
    },
    config = function()
      require("codeium").setup({})
    end
  }, ]]

  {
    "rafamadriz/friendly-snippets",
    module = { "cmp", "cmp_nvim_lsp" },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.others").luasnip()
    end,
  },

  -- misc plugins
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = require("core.plugins").toggleterm_cmds,
    config = function()
      require("plugins.others").toggleterm()
    end
  },

  -- {
  --   "glepnir/lspsaga.nvim",
  --   config = function()
  --     require("plugins.others").lspsaga()
  --   end,
  -- },

  { "stevearc/dressing.nvim", event = "VeryLazy" },

  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "kyazdani42/nvim-tree.lua",
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.nvimtree"
    end,
  },

  {
    "ibhagwan/fzf-lua",
    lazy = true,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.others").autopairs()
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    cmd = require("core.plugins").treesitter_cmds,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require "plugins.treesitter"
    end,
  },

  {
    "rest-nvim/rest.nvim",
    ft = "http",
    config = function()
      require("plugins.others").rest()
    end
  },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    event = "InsertEnter",
    config = function()
      require("gopher").setup()
    end
  },
}

-- Load all plugins
local present, lazy = pcall(require, "lazy")
if present then
  local opts = {
    root = vim.fn.stdpath("data") .. "/lazy",
    lockfile = vim.fn.stdpath("data") .. "/lazy/lazy-lock.json"
  }

  lazy.setup(plugins, opts)
end
