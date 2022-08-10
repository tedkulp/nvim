local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Run packer sync every time the config changes
vim.api.nvim_create_augroup("_packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = "_packer_user_config",
  pattern = { "*/plugins/**.lua", "*/keymaps.lua", "*/autocommands.lua" },
  callback = function()
    vim.cmd("source <afile>")
    -- vim.cmd("PackerSync")
    vim.cmd("PackerCompile")
    -- print("Packer Recompiled")
  end
})

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "single",
  },
  max_jobs = 50,
  git = {
    clone_timeout = 600,
  },
  auto_clean = true,
  ensure_dependencies = true,
})

return packer.startup(function(use)

  ----------------------------
  -- Core Stuff
  ----------------------------

  use {
    "wbthomason/packer.nvim",
  }

  use {
    "nvim-lua/plenary.nvim",
  }

  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end
  }

  -- use {
  --   "stevearc/dressing.nvim",
  -- }



  ----------------------------
  -- Color schemes
  ----------------------------
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true,
        },
        integration = {
          which_key = true,
          indent_blankline = {
            colored_indent_levels = true,
          },
          bufferline = true,
          lualine = true,
          hop = true,
          neotree = {
            enabled = true,
            show_root = true,
          },
        }
      });
    end
  }



  ----------------------------
  -- Navigation
  ----------------------------

  use {
    "folke/which-key.nvim", -- Do this at the top so we can use it for plugin bindings
    enter = "VimEnter",
    config = function()
      require("plugins.config.which-key").setup()
    end,
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.config.neo-tree")
    end,
  }

  use {
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup {
        open_folds = true,
      }
    end,
  }

  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.config.bufferline")
    end,
  }

  use {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
  }

  -- Better quick list
  use {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  }



  ----------------------------
  -- Look and Feel and Editing
  ----------------------------

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.config.lualine")
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.config.indent-blankline")
    end,
  }

  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  }

  use {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.loaded_matchit = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require("nvim-treesitter.configs").setup({
        matchup = {
          enable = true,
        },
      })
    end,
  }

  use {
    "p00f/nvim-ts-rainbow",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        rainbow = {
          enable = true,
        },
      })
    end,
  }

  use {
    "tpope/vim-repeat",
  }

  use {
    "tpope/vim-abolish",
    config = function()
      require("plugins.config.abolish")
    end,
  }

  use {
    "editorconfig/editorconfig-vim",
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.config.comment")
    end,
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufEnter",
  }

  use {
    "phaazon/hop.nvim",
    event = "BufRead",
    branch = "v2",
    config = function()
      require("plugins.config.hop")
    end,
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  }



  -----------------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------------

  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require('gitsigns').setup() end,
    event = "BufReadPre",
  }

  use {
    "sindrets/diffview.nvim",
    config = function() require("plugins.config.diffview") end,
    requires = "nvim-lua/plenary.nvim",
    cmd = "DiffviewOpen",
  }

  use {
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("plugins.config.neogit")
    end,
  }


  ----------------------------
  -- Treesitter
  ----------------------------

  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    run = ":TSUpdate",
    config = function()
      require("plugins.config.treesitter")
    end,
    -- event = "BufReadPre",
  }



  ----------------------------
  -- Telescope
  ----------------------------

  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugins.config.telescope")
    end,
    event = "BufEnter",
  }



  ----------------------------
  -- LSP & Friends
  ----------------------------

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "lukas-reineke/lsp-format.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- Other mason stuff
      { "jose-elias-alvarez/null-ls.nvim" },
    },
    config = function()
      require("plugins.config.lsp-zero")
    end,
  }

  use {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("plugins.config.lsp-signature")
    end,
  }

  use {
    'rmagatti/goto-preview',
    config = function()
      require("plugins.config.goto-preview")
    end
  }



  ----------------------------
  -- Other Stuff
  ----------------------------

  use {
    "christianrondeau/vim-base64",
    config = function()
      require("plugins.config.vim-base64")
    end
  }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
