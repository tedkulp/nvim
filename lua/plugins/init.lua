local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

vim.api.nvim_create_augroup("_packer_user_config", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "_packer_user_config",
  pattern = { "*/plugins/config/**.lua", "*/keymaps.lua", "*/autocommands.lua" },
  callback = function()
    vim.cmd("source <afile>")
    vim.cmd("PackerCompile")
  end
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "_packer_user_config",
  pattern = { "*/plugins/init.lua" },
  callback = function()
    vim.cmd("source <afile>")
  end
})

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
    prompt_border = "single",
  },
  --[[ max_jobs = 50, ]]
  git = {
    clone_timeout = 600,
  },
  auto_clean = true,
  ensure_dependencies = true,
})

return packer.startup({ function(use)

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

  use {
    "stevearc/dressing.nvim",
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
      require "colorscheme"
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
      {
        's1n7ax/nvim-window-picker',
      },
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
    requires = {
      "kyazdani42/nvim-web-devicons",
      "tiagovla/scope.nvim",
    },
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

  use {
    "ojroques/nvim-bufdel",
    config = function()
      require("bufdel").setup({
        quit = false,
      })
    end,
  }

  use {
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
    event = "BufEnter",
  }

  use {
    "ggandor/leap.nvim",
    config = function()
      require("plugins.config.leap")
    end,
    requires = {
      "Weissle/easy-action",
      "kevinhwang91/promise-async",
    },
  }

  -- https://github.com/cbochs/grapple.nvim
  use {
    "cbochs/grapple.nvim",
    config = function()
      require("plugins.config.grapple")
    end
  }

  use {
    "Akianonymus/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  }

  use {
    "mizlan/iswap.nvim",
    config = function()
      require("plugins.config.iswap")
    end
  }

  use {
    "terryma/vim-expand-region",
    event = "BufRead",
  }

  use {
    "fedepujol/move.nvim",
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
  }



  -----------------------------------------------------------------------------
  -- Git
  -----------------------------------------------------------------------------

  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.config.gitsigns")
    end,
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

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
      'almo7aya/openingh.nvim',
    },
    config = function()
      require("plugins.config.github")
    end
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
      "nvim-treesitter/nvim-treesitter-context",
      "p00f/nvim-ts-rainbow",
      "nvim-treesitter/playground",
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
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-project.nvim", opt = true, },
      "nvim-telescope/telescope-live-grep-args.nvim",
      "LukasPietzschmann/telescope-tabs",
      { "jvgrootveld/telescope-zoxide", opt = true, },
    },
    config = function()
      require("plugins.config.telescope")
    end,
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
      { "nvim-lua/lsp-status.nvim" },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

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
      --[[ { "hrsh7th/cmp-copilot", }, ]]

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- Other mason stuff
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jayp0521/mason-null-ls.nvim" },
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

  use {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require("plugins.config.hlslens")
    end
  }

  use {
    "mfussenegger/nvim-dap",
    --[[ module = { "dap" }, ]]
    --[[ wants = { ]]
    --[[   "nvim-dap-virtual-text", ]]
    --[[   "nvim-dap-ui", ]]
    --[[ }, ]]
    requires = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "suketa/nvim-dap-ruby",
    }
  }



  -----------------------------------------------------------------------------
  -- Languages
  -----------------------------------------------------------------------------

  use {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = { "MarkdownPreview" },
  }

  use {
    "gaoDean/autolist.nvim",
    ft = "markdown",
    config = function()
      require("autolist").setup({})
    end,
  }



  -----------------------------------------------------------------------------
  -- Knowledge Base
  -----------------------------------------------------------------------------

  use {
    "nvim-orgmode/orgmode",
    config = function()
      require("plugins.config.orgmode")
    end,
    requires = {
      "akinsho/org-bullets.nvim",
      "lukas-reineke/headlines.nvim",
    },
  }

  use {
    "renerocksai/telekasten.nvim",
    config = function()
      --[[ require("plugins.config.telekasten") ]]
    end,
    requires = {
      "nvim-telescope/telescope.nvim",
    },
  }

  use {
    "mickael-menu/zk-nvim",
    config = function()
      require("plugins.config.zk")
    end
  }

  use {
    "sudormrfbin/cheatsheet.nvim",
    config = function()
      require("cheatsheet").setup({
        bundled_cheatsheets = true,
      })
    end,
    requires = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    }
  }

  use {
    "romgrk/todoist.nvim",
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

  -- Replace with register and don"t copy (use gr instead of r)
  use {
    "vim-scripts/ReplaceWithRegister",
    event = "BufEnter",
  }

  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.config.toggleterm")
    end
  }

  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      { 'kkharji/sqlite.lua', module = 'sqlite' },
    },
    config = function()
      require("plugins.config.neoclip")
    end,
  }

  -- TODO: Remove me?
  use {
    'chentoast/marks.nvim',
    config = function()
      require("plugins.config.marks")
    end,
  }

  use({
    'mrjones2014/dash.nvim',
    run = 'gmake install || make install',
    config = function()
      require("plugins.config.dash")
    end,
  })

  --[[ use { ]]
  --[[   "github/copilot.vim", ]]
  --[[   config = function() ]]
  --[[     require("plugins.config.copilot") ]]
  --[[   end, ]]
  --[[ } ]]



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end,
  config = {
    max_jobs = 10,
  }
})
