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
  pattern = { "*/plugins/**.lua", "*/keymaps.lua" },
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
  use {
    "wbthomason/packer.nvim",
  }

  use {
    "nvim-lua/plenary.nvim",
  }



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

  -- use {
  --   "williamboman/mason.nvim",
  --   requires = {
  --     "williamboman/mason-lspconfig.nvim",
  --     "neovim/nvim-lspconfig",
  --     "jose-elias-alvarez/null-ls.nvim",
  --   },
  --   config = function()
  --     require("plugins.config.mason")
  --     require("plugins.config.lsp")
  --   end,
  -- }
  --
  -- use {
  --   "folke/trouble.nvim",
  --   config = function()
  --     require("plugins.config.trouble")
  --   end,
  -- }



  ----------------------------
  -- Completion
  ----------------------------
  -- use {
  --   "hrsh7th/nvim-cmp",
  --   requires = {
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-cmdline",
  --     "hrsh7th/cmp-nvim-lua",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-nvim-lsp-document-symbol",
  --     "saadparwaiz1/cmp_luasnip",
  --     "L3MON4D3/LuaSnip",
  --     "rafamadriz/friendly-snippets",
  --   },
  --   config = function()
  --     require("plugins.config.cmp")
  --   end,
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
