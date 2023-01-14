local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  ----------------------------
  -- Core Stuff
  ----------------------------

  {
    "nvim-lua/plenary.nvim",
    priority = 900,
  },

  {
    "stevearc/dressing.nvim",
    priority = 900,
  },

  {
    "rcarriga/nvim-notify",
    priority = 800,
    config = function()
      vim.notify = require("notify")
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "LukasPietzschmann/telescope-tabs",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-project.nvim",
        cmd = "Telescope project",
        config = function()
          require('telescope').load_extension("project")
        end,
      },
      {
        "jvgrootveld/telescope-zoxide",
        cmd = "Telescope zoxide",
        config = function()
          require('telescope').load_extension("zoxide")
        end,
      },
    },
    config = function()
      require("plugins.config.telescope")
    end,
  },

  ----------------------------
  -- Color schemes
  ----------------------------

  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
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
      require "colorscheme"
    end
  },

  ----------------------------
  -- Navigation
  ----------------------------

  {
    "folke/which-key.nvim", -- Do this at the top so we can use it for plugin bindings
    priority = 800,
    enter = "VimEnter",
    config = function()
      require("plugins.config.which-key").setup()
    end,
  },

  {
    "akinsho/bufferline.nvim",
    -- tag = "v2.*",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "tiagovla/scope.nvim",
    },
    config = function()
      require("plugins.config.bufferline")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        's1n7ax/nvim-window-picker',
      },
    },
    config = function()
      require("plugins.config.neo-tree")
    end,
  },

  {
    "vladdoster/remember.nvim",
    config = function()
      require("remember").setup {
        open_folds = true,
      }
    end,
  },

  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
  },

  {
    -- Better quick list
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  {
    "ojroques/nvim-bufdel",
    config = function()
      require("bufdel").setup({
        quit = false,
      })
    end,
  },

  {
    "mg979/vim-visual-multi",
    config = function()
      vim.cmd [[
        let g:VM_maps = {}
        let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
        let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'
        let g:VM_maps["Erase Regions"]      = '\\gr'
        let g:VM_maps["Mouse Cursor"]       = '<C-LeftMouse>'
        let g:VM_maps["Mouse Word"]         = '<C-RightMouse>'
        let g:VM_maps["Mouse Column"]       = '<M-C-RightMouse>'
      ]]
    end,
  },

  ----------------------------
  -- Look and Feel and Editing
  ----------------------------

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("plugins.config.lualine")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.config.indent-blankline")
    end,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  {
    "tpope/vim-repeat",
  },

  {
    "tpope/vim-abolish",
    config = function()
      require("plugins.config.abolish")
    end,
  },

  {
    "editorconfig/editorconfig-vim",
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.config.comment")
    end,
    event = "BufEnter",
  },

  {
    "phaazon/hop.nvim",
    branch = 'v2',
    dependencies = {
      "Weissle/easy-action",
      "mfussenegger/nvim-treehopper",
      {
        "kevinhwang91/promise-async",
        module = { "async" },
      }
    },
    config = function()
      require("plugins.config.hop")
    end,
  },

  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
    config = function()
      require("which-key").register({
        ["<C-K>"] = {
          require("ts-node-action").node_action,
          "Trigger Node Action",
        },
      })
    end,
  },

  {
    -- https://github.com/cbochs/grapple.nvim
    "cbochs/grapple.nvim",
    config = function()
      require("plugins.config.grapple")
    end
  },

  {
    "Akianonymus/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  },

  {
    "mizlan/iswap.nvim",
    config = function()
      require("plugins.config.iswap")
    end
  },

  {
    "terryma/vim-expand-region",
  },

  {
    "ur4ltz/move.nvim",
    event = "BufRead",
    config = function()
      local opts = { noremap = true, silent = true }
      -- Normal-mode commands
      vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
      vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
      vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
      vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

      -- Visual-mode commands
      vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
      vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
      vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
    end,
  },

  {
    "shortcuts/no-neck-pain.nvim",
    config = function()
      require('no-neck-pain').setup({
        enableOnVimEnter = false,
        toggleMapping = "<Leader>bn",
        width = 132,
      })
      require("which-key").register({
        ["<leader>bn"] = {
          "<cmd>NoNeckPain<cr>",
          "Auto-center Buffers",
        },
      })
    end
  },

  -----------------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------------

  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.config.gitsigns")
    end,
    event = "BufReadPre",
  },

  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("plugins.config.neogit")
    end,
  },

  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
      'almo7aya/openingh.nvim',
    },
    cmd = "Octo",
    config = function()
      require("plugins.config.github")
    end
  },

  ----------------------------
  -- Treesitter
  ----------------------------

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context",
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/playground",
      "chrisgrieser/nvim-various-textobjs",
    },
    run = ":TSUpdate",
    config = function()
      require("plugins.config.treesitter")
    end,
  },

  ----------------------------
  -- LSP & Friends
  ----------------------------

  {
    'VonHeikemen/lsp-zero.nvim',
    event = "BufRead",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "lukas-reineke/lsp-format.nvim" },
      { "nvim-lua/lsp-status.nvim" },
      { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", name = "lsp_lines", },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-emoji" },
      { "f3fora/cmp-spell" },
      { "barreiroleo/ltex-extra.nvim" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- Other mason stuff
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jayp0521/mason-null-ls.nvim" },

      -- DAP
      { "mfussenegger/nvim-dap" },
      { "jayp0521/mason-nvim-dap.nvim" },
    },
    config = function()
      require("plugins.config.lsp-zero")
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("plugins.config.lsp-signature")
    end,
  },

  {
    'rmagatti/goto-preview',
    config = function()
      require("plugins.config.goto-preview")
    end
  },

  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("plugins.config.hlslens")
    end
  },

  -----------------------------------------------------------------------------
  -- Languages
  -----------------------------------------------------------------------------

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = "MarkdownPreview",
  },

  {
    "gaoDean/autolist.nvim",
    ft = "markdown",
    config = function()
      require("autolist").setup({})
    end,
  },

  -----------------------------------------------------------------------------
  -- Knowledge Base
  -----------------------------------------------------------------------------

  {
    "renerocksai/telekasten.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "mickael-menu/zk-nvim",
    config = function()
      require("plugins.config.zk")
    end
  },

  {
    "sudormrfbin/cheatsheet.nvim",
    config = function()
      require("cheatsheet").setup({
        bundled_cheatsheets = true,
      })
    end,
    cmd = {
      "Cheatsheet",
      "CheatsheetEdit",
    },
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    }
  },

  {
    "romgrk/todoist.nvim",
  },

  ----------------------------
  -- Other Stuff
  ----------------------------

  {
    "christianrondeau/vim-base64",
    config = function()
      require("plugins.config.vim-base64")
    end
  },

  {
    -- Replace with register and don"t copy (use gr instead of r)
    "vim-scripts/ReplaceWithRegister",
    event = "BufEnter",
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.config.toggleterm")
    end
  },

  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      {
        "kkharji/sqlite.lua",
        module = "sqlite",
      },
    },
    config = function()
      require("plugins.config.neoclip")
    end,
  },

  {
    -- TODO: Remove me?
    'chentoast/marks.nvim',
    config = function()
      require("plugins.config.marks")
    end,
  },

  {
    "mrjones2014/dash.nvim",
    build = "gmake install || make install",
    config = function()
      require("plugins.config.dash")
    end,
  },

})
