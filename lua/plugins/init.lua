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
      "ray-x/cmp-treesitter",
    },
    config = function()
      -- require("codeium").setup({})
      require "plugins.nvimcmp"
    end
  },

  -- dap bugger
  --[[ {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
    },
    config = function()
      require("plugins.ndap")
    end
  }, ]]

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

  -- ui
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({})
    end
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
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
    "windrivder/fzf-lua",
    lazy = true,
  },

  -- quickly move: s char char
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

  --[[ {
    "rest-nvim/rest.nvim",
    ft = "http",
    config = function()
      require("plugins.others").rest()
    end
  }, ]]

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        enabled = false,
        date_format = '%y:%m:%d'
      })
    end
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },

  {
    "windrivder/symbols-outline.nvim",
    config = function()
      require("plugins.others").outline()
    end
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugins.others").refactoring()
    end,
  },

  --[[ {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("plugins.others").alpha()
    end
  }, ]]

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("plugins.others").bufferline()
    end
  },

  -- {
  --   'natecraddock/workspaces.nvim',
  --   config = function()
  --     require("workspaces").setup({
  --       path = vim.fn.stdpath("data") .. "/projects/data",
  --       hooks = {
  --         open = function()
  --           require("session_manager").load_current_dir_session()
  --         end
  --       }
  --     })
  --   end
  -- },
  -- {
  --   'Shatur/neovim-session-manager',
  --   config = function()
  --     local Path = require('plenary.path')
  --     local config = require('session_manager.config')
  --     require("session_manager").setup({
  --       sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
  --       autosave_last_session = false,
  --       autosave_only_in_session = true,
  --       autoload_mode = config.AutoloadMode.CurrentDir,
  --     })
  --   end
  -- },
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
